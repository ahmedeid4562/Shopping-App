import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../data/api/admin_product_api.dart';
import '../../../../data/model/product_model.dart';

class AddProductScreen extends StatefulWidget {
  final ProductModel? product;

  const AddProductScreen({super.key, this.product});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final _formKey = GlobalKey<FormState>();

  final _titleController = TextEditingController();
  final _priceController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();

  final AdminProductApi _productApi = AdminProductApi();
  final ImagePicker _imagePicker = ImagePicker();

  final List<_VariantDraft> _variants = [];

  bool _isLoading = false;
  bool _isPickingImages = false;

  bool get _isEditing => widget.product != null;

  @override
  void initState() {
    super.initState();

    final product = widget.product;

    if (product != null) {
      _titleController.text = product.title;
      _priceController.text = product.price.toString();
      _descriptionController.text = product.description;
      _categoryController.text = product.category;

      if (product.variants.isNotEmpty) {
        for (final variant in product.variants) {
          _variants.add(
            _VariantDraft(
              colorName: variant.colorName,
              colorHex: variant.colorHex,
              images: variant.images.map((url) {
                return _VariantImageDraft(url: url);
              }).toList(),
            ),
          );
        }
      } else {
        // Keep compatibility with old products having one image.
        _variants.add(
          _VariantDraft(
            colorName: 'Default',
            colorHex: '#FFFFFF',
            images: product.image.isNotEmpty
                ? [_VariantImageDraft(url: product.image)]
                : [],
          ),
        );
      }
    } else {
      _variants.add(_VariantDraft(colorName: 'Default', colorHex: '#FFFFFF'));
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _priceController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();

    for (final variant in _variants) {
      variant.dispose();
    }

    super.dispose();
  }

  // Add another color.
  void _addVariant() {
    if (_isLoading || _isPickingImages) return;

    setState(() {
      _variants.add(_VariantDraft(colorName: '', colorHex: '#FFFFFF'));
    });
  }

  // Remove a color and its images.
  void _removeVariant(int index) {
    if (_isLoading || _isPickingImages) return;

    setState(() {
      final variant = _variants.removeAt(index);
      variant.dispose();
    });
  }

  // Choose multiple images for a specific color.
  Future<void> _pickImages(int variantIndex) async {
    if (_isPickingImages || _isLoading) return;

    setState(() => _isPickingImages = true);

    try {
      final pickedImages = await _imagePicker.pickMultiImage(imageQuality: 85);

      if (pickedImages.isEmpty) return;

      final newImages = await Future.wait(
        pickedImages.map((file) async {
          final bytes = await file.readAsBytes();

          return _VariantImageDraft(file: file, bytes: bytes);
        }),
      );

      if (!mounted) return;

      setState(() {
        _variants[variantIndex].images.addAll(newImages);
      });
    } catch (e) {
      if (!mounted) return;

      _showMessage('Failed to select images: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isPickingImages = false);
      }
    }
  }

  // Remove one image.
  void _removeImage(int variantIndex, int imageIndex) {
    if (_isLoading || _isPickingImages) return;

    setState(() {
      _variants[variantIndex].images.removeAt(imageIndex);
    });
  }

  void _showMessage(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : null,
      ),
    );
  }

  Color _colorFromHex(String hex) {
    try {
      final value = hex.replaceAll('#', '').trim();

      if (value.length != 6) {
        return Colors.white;
      }

      return Color(int.parse('FF$value', radix: 16));
    } catch (_) {
      return Colors.white;
    }
  }

  bool _isValidHex(String hex) {
    return RegExp(r'^#?[0-9a-fA-F]{6}$').hasMatch(hex.trim());
  }

  // Upload local images and prepare variants for Firestore.
  Future<List<ProductVariant>> _prepareVariants() async {
    final result = <ProductVariant>[];

    for (var i = 0; i < _variants.length; i++) {
      final variant = _variants[i];

      final colorName = variant.colorNameController.text.trim();
      final colorHex = variant.colorHexController.text.trim();

      if (colorName.isEmpty) {
        throw Exception('Please enter the name of color ${i + 1}');
      }

      if (!_isValidHex(colorHex)) {
        throw Exception('Enter a valid HEX color for $colorName');
      }

      if (variant.images.isEmpty) {
        throw Exception('Please add at least one image for $colorName');
      }

      final imageUrls = <String>[];

      for (var j = 0; j < variant.images.length; j++) {
        final image = variant.images[j];

        // Keep previously uploaded images.
        if (image.url != null && image.url!.isNotEmpty) {
          imageUrls.add(image.url!);
          continue;
        }

        // Upload newly selected images.
        if (image.bytes != null && image.file != null) {
          final imageUrl = await _productApi.uploadProductImage(
            imageBytes: image.bytes!,
            fileName: image.file!.name,
          );

          imageUrls.add(imageUrl);
        }
      }

      if (imageUrls.isEmpty) {
        throw Exception('No valid images found for $colorName');
      }

      result.add(
        ProductVariant(
          colorName: colorName,
          colorHex: colorHex.startsWith('#') ? colorHex : '#$colorHex',
          images: imageUrls,
        ),
      );
    }

    return result;
  }

  // Save product to Firestore.
  Future<void> _saveProduct() async {
    if (!_formKey.currentState!.validate()) return;

    if (_variants.isEmpty) {
      _showMessage('Please add at least one color', isError: true);
      return;
    }

    final colorNames = <String>{};

    for (final variant in _variants) {
      final name = variant.colorNameController.text.trim().toLowerCase();

      if (name.isEmpty) {
        _showMessage('Please enter all color names', isError: true);
        return;
      }

      if (!colorNames.add(name)) {
        _showMessage('Each color must have a unique name', isError: true);
        return;
      }
    }

    setState(() => _isLoading = true);

    try {
      final title = _titleController.text.trim();
      final price = double.parse(_priceController.text.trim());
      final description = _descriptionController.text.trim();
      final category = _categoryController.text.trim();

      // Upload images and prepare product colors.
      final List<ProductVariant> variants = await _prepareVariants();

      if (variants.isEmpty || variants.first.images.isEmpty) {
        throw Exception('Please add product images');
      }

      final String mainImage = variants.first.images.first;

      if (_isEditing) {
        final productId = widget.product!.firestoreId;

        if (productId == null || productId.isEmpty) {
          throw Exception('Product ID is missing');
        }

        await _productApi.updateProduct(
          productId: productId,
          title: title,
          price: price,
          description: description,
          category: category,
          imageUrl: mainImage,
          variants: variants,
        );
      } else {
        await _productApi.addProduct(
          title: title,
          price: price,
          description: description,
          category: category,
          imageUrl: mainImage,
          variants: variants,
        );
      }

      if (!mounted) return;

      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;

      _showMessage('Failed to save product: $e', isError: true);
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? hint,
    String? Function(String?)? validator,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(14)),
        ),
        validator:
            validator ??
            (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Please enter $label';
              }

              return null;
            },
      ),
    );
  }

  Widget _buildImagePreview(_VariantImageDraft image) {
    if (image.bytes != null) {
      return Image.memory(
        image.bytes!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
      );
    }

    if (image.url != null) {
      return Image.network(
        image.url!,
        fit: BoxFit.cover,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, _, _) {
          return const Icon(
            Icons.broken_image_outlined,
            color: Colors.grey,
            size: 35,
          );
        },
      );
    }

    return const Icon(Icons.image_outlined, color: Colors.grey);
  }

  Widget _buildVariantCard(int index) {
    final variant = _variants[index];
    final colors = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 18),
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: colors.outline.withValues(alpha: 0.2)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Variant heading.
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    '${index + 1}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Text(
                    'Color Variant ${index + 1}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: _isLoading || _isPickingImages
                      ? null
                      : () => _removeVariant(index),
                  tooltip: 'Remove color',
                  icon: const Icon(Icons.delete_outline, color: Colors.red),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // Color name.
            TextFormField(
              controller: variant.colorNameController,
              enabled: !_isLoading && !_isPickingImages,
              decoration: InputDecoration(
                labelText: 'Color Name',
                hintText: 'Example: Black, White, Red',
                prefixIcon: const Icon(Icons.palette_outlined),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // Color HEX.
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: variant.colorHexController,
                    enabled: !_isLoading && !_isPickingImages,
                    onChanged: (_) {
                      setState(() {});
                    },
                    decoration: InputDecoration(
                      labelText: 'Color HEX',
                      hintText: '#000000',
                      prefixIcon: const Icon(Icons.color_lens_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _colorFromHex(variant.colorHexController.text),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.outline.withValues(alpha: 0.5),
                      width: 2,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 22),

            // Images heading.
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Color Images',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                ),
                Text(
                  '${variant.images.length} Images',
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Images grid.
            if (variant.images.isEmpty)
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: colors.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Column(
                  children: [
                    Icon(
                      Icons.add_photo_alternate_outlined,
                      size: 38,
                      color: Colors.grey,
                    ),
                    SizedBox(height: 8),
                    Text('No images added yet'),
                  ],
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: variant.images.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, imageIndex) {
                  final image = variant.images[imageIndex];

                  return Stack(
                    children: [
                      Positioned.fill(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: _buildImagePreview(image),
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: Material(
                          color: Colors.black54,
                          shape: const CircleBorder(),
                          child: InkWell(
                            onTap: _isLoading || _isPickingImages
                                ? null
                                : () {
                                    _removeImage(index, imageIndex);
                                  },
                            customBorder: const CircleBorder(),
                            child: const Padding(
                              padding: EdgeInsets.all(5),
                              child: Icon(
                                Icons.close,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),

            const SizedBox(height: 14),

            // Add multiple images.
            SizedBox(
              width: double.infinity,
              height: 48,
              child: OutlinedButton.icon(
                onPressed: _isLoading || _isPickingImages
                    ? null
                    : () => _pickImages(index),
                icon: const Icon(Icons.add_photo_alternate_outlined),
                label: Text(
                  _isPickingImages
                      ? 'Opening Gallery...'
                      : 'Add Images From Device',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor: primaryColor,
                  side: const BorderSide(color: primaryColor),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isEditing ? 'Edit Product' : 'Add Product',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Product Information',
                style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 20),

              _buildTextField(
                controller: _titleController,
                label: 'Product Name',
                icon: Icons.shopping_bag_outlined,
              ),

              _buildTextField(
                controller: _priceController,
                label: 'Price',
                icon: Icons.attach_money,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: (value) {
                  final price = double.tryParse(value?.trim() ?? '');

                  if (price == null || price <= 0) {
                    return 'Enter a valid price greater than zero';
                  }

                  return null;
                },
              ),

              _buildTextField(
                controller: _categoryController,
                label: 'Category',
                icon: Icons.category_outlined,
                hint: 'Shoes, Electronics, Clothing...',
              ),

              _buildTextField(
                controller: _descriptionController,
                label: 'Description',
                icon: Icons.description_outlined,
                maxLines: 4,
              ),

              const SizedBox(height: 12),

              // Product colors and images.
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Expanded(
                    child: Text(
                      'Product Colors & Images',
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Text(
                    '${_variants.length} Colors',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              Text(
                'Add each available color and select multiple '
                'images for every color.',
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 13,
                ),
              ),

              const SizedBox(height: 18),

              ...List.generate(
                _variants.length,
                (index) => _buildVariantCard(index),
              ),

              // Add another color.
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton.icon(
                  onPressed: _isLoading || _isPickingImages
                      ? null
                      : _addVariant,
                  icon: const Icon(Icons.add),
                  label: const Text('Add Another Color'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: primaryColor,
                    side: const BorderSide(color: primaryColor, width: 1.3),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // Save product.
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: _isLoading || _isPickingImages
                      ? null
                      : _saveProduct,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: _isLoading
                      ? const SizedBox(
                          width: 23,
                          height: 23,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : Text(
                          _isEditing ? 'Save Changes' : 'Add Product',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}

// Temporary image data before uploading to Cloudinary.
class _VariantImageDraft {
  final XFile? file;
  final Uint8List? bytes;
  final String? url;

  _VariantImageDraft({this.file, this.bytes, this.url});
}

// Temporary color data while creating or editing a product.
class _VariantDraft {
  final TextEditingController colorNameController;
  final TextEditingController colorHexController;

  final List<_VariantImageDraft> images;

  _VariantDraft({
    required String colorName,
    required String colorHex,
    List<_VariantImageDraft>? images,
  }) : colorNameController = TextEditingController(text: colorName),
       colorHexController = TextEditingController(text: colorHex),
       images = images ?? [];

  void dispose() {
    colorNameController.dispose();
    colorHexController.dispose();
  }
}
