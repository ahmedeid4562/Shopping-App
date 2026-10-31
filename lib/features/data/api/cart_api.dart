import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class CartApi {
  static const String _cartKey = 'shopping_cart';

  Future<List<ProductModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    final cartData = prefs.getStringList(_cartKey) ?? [];

    return cartData.map((item) {
      final json = jsonDecode(item) as Map<String, dynamic>;
      return ProductModel.fromJson(json);
    }).toList();
  }

  Future<void> addToCart(ProductModel product) async {
    final prefs = await SharedPreferences.getInstance();

    final cart = await getCart();

    cart.add(product);

    final cartData = cart.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    final cart = await getCart();

    cart.removeWhere((product) => product.id == productId);

    final cartData = cart.map((item) => jsonEncode(item.toJson())).toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
