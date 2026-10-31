class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;

  // Main image for compatibility with existing screens.
  final String image;

  final double rating;
  final int ratingCount;
  final String? firestoreId;

  // Each variant represents a color and its images.
  final List<ProductVariant> variants;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
    this.firestoreId,
    this.variants = const [],
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    final ratingData = json['rating'];

    double rating = 0.0;
    int ratingCount = 0;

    if (ratingData is num) {
      rating = ratingData.toDouble();
    } else if (ratingData is Map) {
      rating = (ratingData['rate'] as num?)?.toDouble() ?? 0.0;
      ratingCount = (ratingData['count'] as num?)?.toInt() ?? 0;
    }

    if (json['reviews'] is List && ratingCount == 0) {
      ratingCount = (json['reviews'] as List).length;
    }

    final variants = _parseVariants(json['variants']);
    final images = json['images'];

    final variantImage = variants.isNotEmpty && variants.first.images.isNotEmpty
        ? variants.first.images.first
        : '';

    final image =
        json['thumbnail'] ??
        json['image'] ??
        (images is List && images.isNotEmpty ? images.first : null) ??
        variantImage;

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      image: image.toString(),
      rating: rating,
      ratingCount: ratingCount,
      firestoreId: json['firestoreId']?.toString(),
      variants: variants,
    );
  }

  factory ProductModel.fromFirestore(
    String documentId,
    Map<String, dynamic> json,
  ) {
    final variants = _parseVariants(json['variants']);

    final variantImage = variants.isNotEmpty && variants.first.images.isNotEmpty
        ? variants.first.images.first
        : '';

    final storedImage = json['image']?.toString() ?? '';

    final ratingData = json['rating'];

    double rating = 0.0;
    int ratingCount = 0;

    if (ratingData is num) {
      rating = ratingData.toDouble();
    } else if (ratingData is Map) {
      rating = (ratingData['rate'] as num?)?.toDouble() ?? 0.0;
      ratingCount = (ratingData['count'] as num?)?.toInt() ?? 0;
    }

    ratingCount = (json['ratingCount'] as num?)?.toInt() ?? ratingCount;

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title']?.toString() ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      image: storedImage.isNotEmpty ? storedImage : variantImage,
      rating: rating,
      ratingCount: ratingCount,
      firestoreId: documentId,
      variants: variants,
    );
  }

  static List<ProductVariant> _parseVariants(dynamic value) {
    if (value is! List) return [];

    return value
        .whereType<Map>()
        .map((item) => ProductVariant.fromJson(Map<String, dynamic>.from(item)))
        .toList();
  }

  // Returns all product images.
  // Old products without variants still return their single image.
  List<String> get allImages {
    final variantImages = variants
        .expand((variant) => variant.images)
        .where((image) => image.trim().isNotEmpty)
        .toList();

    if (variantImages.isNotEmpty) {
      return variantImages;
    }

    return image.trim().isNotEmpty ? [image] : [];
  }

  // Whether this product has color variants.
  bool get hasVariants => variants.isNotEmpty;

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {'rate': rating, 'count': ratingCount},
      'ratingCount': ratingCount,
      'firestoreId': firestoreId,
      'variants': variants.map((variant) => variant.toJson()).toList(),
    };
  }
}

class ProductVariant {
  final String colorName;
  final String colorHex;
  final List<String> images;

  const ProductVariant({
    required this.colorName,
    required this.colorHex,
    required this.images,
  });

  factory ProductVariant.fromJson(Map<String, dynamic> json) {
    final rawImages = json['images'];

    final images = rawImages is List
        ? rawImages
              .map((image) => image.toString())
              .where((image) => image.trim().isNotEmpty)
              .toList()
        : <String>[];

    return ProductVariant(
      colorName: json['colorName']?.toString() ?? 'Default',
      colorHex: json['colorHex']?.toString() ?? '#FFFFFF',
      images: images,
    );
  }

  Map<String, dynamic> toJson() {
    return {'colorName': colorName, 'colorHex': colorHex, 'images': images};
  }
}
