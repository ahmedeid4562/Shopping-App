import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              baseUrl: ApiConstants.baseUrl,
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
              responseType: ResponseType.json,
              headers: {'Accept': 'application/json'},
            ),
          );

  Future<List<CategoryModel>> getCategories() async {
    return const [
      CategoryModel(slug: 'men', name: 'Men', url: ''),
      CategoryModel(slug: 'women', name: 'Women', url: ''),
      CategoryModel(slug: 'kids', name: 'Kids', url: ''),
      CategoryModel(slug: 'watches', name: 'Watches', url: ''),
      CategoryModel(slug: 'bags', name: 'Bags', url: ''),
      CategoryModel(slug: 'jewelry', name: 'Jewelry', url: ''),
      CategoryModel(slug: 'sunglasses', name: 'Sunglasses', url: ''),
      CategoryModel(slug: 'belts', name: 'Belts', url: ''),
      CategoryModel(slug: 'wallets', name: 'Wallets', url: ''),
    ];
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    final normalized = category.trim().toLowerCase();

    if (normalized != 'men') {
      return [];
    }

    try {
      final response = await _dio.get(ApiConstants.menClothingEndpoint);

      if (response.statusCode == 200 && response.data is List) {
        final data = response.data as List<dynamic>;

        return data
            .map(
              (product) =>
                  ProductModel.fromJson(product as Map<String, dynamic>),
            )
            .toList();
      }

      throw Exception(
        'Failed to load category products: ${response.statusCode}',
      );
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }
}
