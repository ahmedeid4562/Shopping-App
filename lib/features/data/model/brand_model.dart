class BrandModel {
  final String name;
  final String slug;
  final String image;

  const BrandModel({required this.name, required this.slug, this.image = ''});

  factory BrandModel.fromJson(Map<String, dynamic> json) {
    return BrandModel(
      name: json['name']?.toString() ?? json['brand']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {'name': name, 'slug': slug, 'image': image};
  }
}
