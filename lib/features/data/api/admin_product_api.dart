import 'dart:convert';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;

import '../model/product_model.dart';

class AdminProductApi {
  static const String _cloudName = 'ivnkxlru';
  static const String _uploadPreset = 'products_unsigned';

  final FirebaseFirestore _firestore;

  AdminProductApi({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _productsCollection {
    return _firestore.collection('products');
  }

  // Listen to all products.
  Stream<List<ProductModel>> watchProducts() {
    return _productsCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return ProductModel.fromFirestore(doc.id, doc.data());
          }).toList();
        });
  }

  // Upload one image to Cloudinary.
  Future<String> uploadProductImage({
    required Uint8List imageBytes,
    required String fileName,
  }) async {
    if (imageBytes.isEmpty) {
      throw Exception('Image file is empty');
    }

    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/'
      '$_cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = _uploadPreset;
    request.fields['folder'] = 'products';

    request.files.add(
      http.MultipartFile.fromBytes(
        'file',
        imageBytes,
        filename: fileName.isEmpty ? 'product.jpg' : fileName,
      ),
    );

    final streamedResponse = await request.send().timeout(
      const Duration(seconds: 60),
    );

    final responseBody = await streamedResponse.stream.bytesToString();

    dynamic decodedData;

    try {
      decodedData = jsonDecode(responseBody);
    } catch (_) {
      throw Exception('Invalid response from Cloudinary');
    }

    if (decodedData is! Map) {
      throw Exception('Invalid response from Cloudinary');
    }

    final responseData = Map<String, dynamic>.from(decodedData);

    if (streamedResponse.statusCode < 200 ||
        streamedResponse.statusCode >= 300) {
      String message = 'Cloudinary upload failed';

      final errorData = responseData['error'];

      if (errorData is Map) {
        final errorMessage = errorData['message'];

        if (errorMessage != null) {
          message = errorMessage.toString();
        }
      }

      throw Exception(message);
    }

    final imageUrl = responseData['secure_url'];

    if (imageUrl == null || imageUrl.toString().isEmpty) {
      throw Exception('Cloudinary did not return an image URL');
    }

    return imageUrl.toString();
  }

  // Validate product data.
  void _validateProduct({
    required String title,
    required double price,
    required String category,
    required String imageUrl,
    required List<ProductVariant> variants,
  }) {
    if (title.trim().isEmpty) {
      throw Exception('Product name is required');
    }

    if (price <= 0) {
      throw Exception('Price must be greater than zero');
    }

    if (category.trim().isEmpty) {
      throw Exception('Category is required');
    }

    if (imageUrl.trim().isEmpty) {
      throw Exception('Product image is required');
    }

    if (variants.isEmpty) {
      throw Exception('Add at least one product color');
    }

    for (final variant in variants) {
      if (variant.colorName.trim().isEmpty) {
        throw Exception('Every color must have a name');
      }

      if (variant.images.isEmpty) {
        throw Exception('Every color must have at least one image');
      }

      for (final image in variant.images) {
        if (image.trim().isEmpty) {
          throw Exception('Invalid image found in ${variant.colorName}');
        }
      }
    }
  }

  // Add new product.
  Future<String> addProduct({
    required String title,
    required double price,
    required String description,
    required String category,
    required String imageUrl,
    required List<ProductVariant> variants,
  }) async {
    _validateProduct(
      title: title,
      price: price,
      category: category,
      imageUrl: imageUrl,
      variants: variants,
    );

    final document = _productsCollection.doc();

    await document.set({
      'id': DateTime.now().microsecondsSinceEpoch,
      'title': title.trim(),
      'price': price,
      'description': description.trim(),
      'category': category.trim(),
      'image': imageUrl,
      'variants': variants.map((variant) {
        return variant.toJson();
      }).toList(),
      'rating': 0.0,
      'ratingCount': 0,
      'createdAt': FieldValue.serverTimestamp(),
      'updatedAt': FieldValue.serverTimestamp(),
    });

    return document.id;
  }

  // Update existing product.
  Future<void> updateProduct({
    required String productId,
    required String title,
    required double price,
    required String description,
    required String category,
    required String imageUrl,
    required List<ProductVariant> variants,
  }) async {
    _validateProduct(
      title: title,
      price: price,
      category: category,
      imageUrl: imageUrl,
      variants: variants,
    );

    final document = _productsCollection.doc(productId);

    final oldDocument = await document.get();

    if (!oldDocument.exists) {
      throw Exception('Product not found');
    }

    await document.update({
      'title': title.trim(),
      'price': price,
      'description': description.trim(),
      'category': category.trim(),
      'image': imageUrl,
      'variants': variants.map((variant) {
        return variant.toJson();
      }).toList(),
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  // Delete product.
  Future<void> deleteProduct(String productId) async {
    if (productId.trim().isEmpty) {
      throw Exception('Product ID is missing');
    }

    await _productsCollection.doc(productId).delete();
  }
}
