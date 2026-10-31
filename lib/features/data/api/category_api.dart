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
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              headers: {'Accept': 'application/json'},
            ),
          );

  // Get all categories
  Future<List<CategoryModel>> getCategories() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.categoriesEndpoint}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data;

        return data
            .map(
              (category) =>
                  CategoryModel.fromJson(category as Map<String, dynamic>),
            )
            .toList();
      }

      throw Exception('Failed to load categories: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }

  // Get products by category
  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/products/category/$category',
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = response.data['products'];

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
