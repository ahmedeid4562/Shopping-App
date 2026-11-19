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
              baseUrl: ApiConstants.baseUrl,
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
        ApiConstants.menClothingEndpoint,
      );

      if (response.statusCode == 200 && response.data is List) {
        final List<dynamic> data = response.data as List<dynamic>;

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
        '${ApiConstants.productDetailsEndpoint}$id',
      );

      if (response.statusCode == 200 && response.data is Map<String, dynamic>) {
        return ProductModel.fromJson(
          response.data as Map<String, dynamic>,
        );
      }

      throw Exception('Failed to load product: ${response.statusCode}');
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }

  Future<List<ProductModel>> searchProducts(String query) async {
    try {
      final products = await getProducts();

      if (query.trim().isEmpty) {
        return products;
      }

      return products.where((product) {
        return product.title
            .toLowerCase()
            .contains(query.trim().toLowerCase());
      }).toList();
    } catch (e) {
      throw Exception('Failed to search products: $e');
    }
  }
}