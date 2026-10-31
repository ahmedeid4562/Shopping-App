import 'package:dio/dio.dart';
import 'package:shopping_app/features/data/model/product_model.dart';

import '../../../core/constants/api_constants.dart';

class ProductApi {
  final Dio _dio;

  ProductApi({Dio? dio})
    : _dio =
          dio ??
          Dio(
            BaseOptions(
              connectTimeout: const Duration(seconds: 30),
              receiveTimeout: const Duration(seconds: 30),
              sendTimeout: const Duration(seconds: 30),
              responseType: ResponseType.json,
              headers: {'Accept': 'application/json'},
            ),
          );

  Future<List<ProductModel>> getProducts() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}',
        queryParameters: {'limit': 0},
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

      throw Exception('Failed to load products: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }

  Future<ProductModel> getProductById(int id) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.productDetailsEndpoint}$id',
      );

      return ProductModel.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }

  // Search products by name
  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}/products/search',
        queryParameters: {'q': query},
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

      throw Exception('Failed to search products: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }
}
