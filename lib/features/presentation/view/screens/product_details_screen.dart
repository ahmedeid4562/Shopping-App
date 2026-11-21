import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/model/product_model.dart';
import '../../view_model/cart_cubit.dart';

class ProductDetailsScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  State<ProductDetailsScreen> createState() => _ProductDetailsScreenState();
}

class _ProductDetailsScreenState extends State<ProductDetailsScreen> {
  int _currentImageIndex = 0;
  bool _isAddingToCart = false;

  Future<void> _addToCart() async {
    if (_isAddingToCart) return;

    setState(() => _isAddingToCart = true);

    try {
      await context.read<CartCubit>().addToCart(widget.product);

      if (!mounted) return;

      final l = AppLocalizations.of(context)!;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.productAddedToCart(widget.product.title)),
          backgroundColor: Colors.green,
          duration: const Duration(seconds: 2),
        ),
      );
    } catch (_) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to add product to cart'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isAddingToCart = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final l = AppLocalizations.of(context)!;

    final product = widget.product;
    final productImages = product.allImages;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.productDetails,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                  color: theme.cardColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: productImages.isEmpty
                      ? const Center(
                          child: Icon(
                            Icons.image_not_supported_outlined,
                            size: 60,
                            color: Colors.grey,
                          ),
                        )
                      : PageView.builder(
                          itemCount: productImages.length,
                          onPageChanged: (index) {
                            setState(() {
                              _currentImageIndex = index;
                            });
                          },
                          itemBuilder: (context, index) {
                            return CachedNetworkImage(
                              imageUrl: productImages[index],
                              fit: BoxFit.contain,
                              placeholder: (_, _) => const Center(
                                child: CircularProgressIndicator(
                                  color: ProductDetailsScreen.primaryColor,
                                ),
                              ),
                              errorWidget: (_, _, _) => const Icon(
                                Icons.image_not_supported_outlined,
                                size: 60,
                                color: Colors.grey,
                              ),
                            );
                          },
                        ),
                ),
              ),
              if (productImages.length > 1) ...[
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(productImages.length, (index) {
                    final isSelected = _currentImageIndex == index;

                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: isSelected ? 22 : 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? ProductDetailsScreen.primaryColor
                            : colors.outlineVariant,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    );
                  }),
                ),
              ],
              const SizedBox(height: 24),
              Text(
                product.category.toUpperCase(),
                style: const TextStyle(
                  color: ProductDetailsScreen.primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.title,
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 14),
              Row(
                children: [
                  const Icon(Icons.star, color: Colors.amber, size: 22),
                  const SizedBox(width: 5),
                  Text(
                    product.rating.toStringAsFixed(1),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  if (product.ratingCount > 0) ...[
                    const SizedBox(width: 5),
                    Text(
                      '(${product.ratingCount} ${l.reviews})',
                      style: TextStyle(color: colors.onSurfaceVariant),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 20),
              Text(
                '\$${product.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: ProductDetailsScreen.primaryColor,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l.description,
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                product.description,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: colors.onSurfaceVariant,
                  height: 1.6,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton.icon(
                  onPressed: _isAddingToCart ? null : _addToCart,
                  icon: _isAddingToCart
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            color: Colors.white,
                            strokeWidth: 2,
                          ),
                        )
                      : const Icon(Icons.shopping_cart_outlined),
                  label: Text(
                    _isAddingToCart ? l.loading : l.addToCart,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ProductDetailsScreen.primaryColor,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
