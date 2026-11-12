import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../model/category_model.dart';
import '../model/product_model.dart';

class CategoryApi {
  final Dio _dio;

  CategoryApi({Dio? dio})
      : _dio = dio ??
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
    try {
      return [
        CategoryModel.fromJson({
          'name': "Men's Clothing",
          'slug': "men's clothing",
        }),
      ];
    } catch (e) {
      throw Exception('Failed to load categories: $e');
    }
  }

  Future<List<ProductModel>> getProductsByCategory(String category) async {
    try {
      final normalizedCategory = category
          .trim()
          .toLowerCase()
          .replaceAll('-', ' ');

      if (normalizedCategory != "men's clothing") {
        return [];
      }

      final response = await _dio.get(
        ApiConstants.menClothingEndpoint,
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data as List<dynamic>;

        return data
            .map(
              (product) => ProductModel.fromJson(
                product as Map<String, dynamic>,
              ),
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