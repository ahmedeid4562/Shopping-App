class ProductModel {
  final int id;
  final String title;
  final double price;
  final String description;
  final String category;
  final String image;
  final double rating;
  final int ratingCount;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.category,
    required this.image,
    required this.rating,
    required this.ratingCount,
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

    final images = json['images'];

    final image = json['thumbnail'] ??
        json['image'] ??
        (images is List && images.isNotEmpty ? images.first : '');

    return ProductModel(
      id: (json['id'] as num?)?.toInt() ?? 0,
      title: json['title'] ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      image: image.toString(),
      rating: rating,
      ratingCount: ratingCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'description': description,
      'category': category,
      'image': image,
      'rating': {
        'rate': rating,
        'count': ratingCount,
      },
    };
  }
}