import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class CartApi {
  static const String _cartKey = 'shopping_cart';

  String _getProductKey(ProductModel product) {
    return product.firestoreId ?? product.id.toString();
  }

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

    final productKey = _getProductKey(product);

    final exists = cart.any(
      (item) => _getProductKey(item) == productKey,
    );

    if (exists) return;

    cart.add(product);

    final cartData = cart
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> removeFromCart(int productId) async {
    final prefs = await SharedPreferences.getInstance();

    final cart = await getCart();

    cart.removeWhere((product) => product.id == productId);

    final cartData = cart
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> removeFromCartByFirestoreId(String firestoreId) async {
    final prefs = await SharedPreferences.getInstance();

    final cart = await getCart();

    cart.removeWhere(
      (product) => product.firestoreId == firestoreId,
    );

    final cartData = cart
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_cartKey);
  }
}
