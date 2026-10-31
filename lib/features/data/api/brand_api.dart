import 'package:dio/dio.dart';

import '../../../core/constants/api_constants.dart';
import '../model/brand_model.dart';

class BrandApi {
  final Dio _dio;

  BrandApi({Dio? dio})
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

  Future<List<BrandModel>> getBrands() async {
    try {
      final response = await _dio.get(
        '${ApiConstants.baseUrl}${ApiConstants.productsEndpoint}',
        queryParameters: {'limit': 0},
      );

      if (response.statusCode != 200) {
        throw Exception('Failed to load brands: ${response.statusCode}');
      }

      final responseData = response.data;

      if (responseData is! Map<String, dynamic> ||
          responseData['products'] is! List) {
        throw Exception('Invalid brands response from API');
      }

      final List<dynamic> products = responseData['products'];

      final Map<String, BrandModel> uniqueBrands = {};

      for (final product in products) {
        if (product is! Map<String, dynamic>) continue;

        final brandName = product['brand']?.toString().trim() ?? '';

        if (brandName.isEmpty) continue;

        final normalizedName = brandName.toLowerCase();

        uniqueBrands.putIfAbsent(
          normalizedName,
          () => BrandModel(
            name: brandName,
            slug: normalizedName.replaceAll(RegExp(r'\s+'), '-'),
          ),
        );
      }

      return uniqueBrands.values.toList();
    } on DioException catch (e) {
      throw Exception('API Error (${e.type}): ${e.message}');
    }
  }
}
