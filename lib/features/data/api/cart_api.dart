import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/product_model.dart';

class CartApi {
  static const String _cartKey = 'shopping_cart';

  String _getProductKey(ProductModel product) {
    final firestoreId = product.firestoreId;

    if (firestoreId != null && firestoreId.isNotEmpty) {
      return firestoreId;
    }

    return product.id.toString();
  }

  Future<List<ProductModel>> getCart() async {
    final prefs = await SharedPreferences.getInstance();

    final cartData = prefs.getStringList(_cartKey) ?? [];

    final products = <ProductModel>[];

    for (final item in cartData) {
      try {
        final json = jsonDecode(item) as Map<String, dynamic>;
        products.add(ProductModel.fromJson(json));
      } catch (_) {
        continue;
      }
    }

    return products;
  }

  Future<void> _saveCart(List<ProductModel> products) async {
    final prefs = await SharedPreferences.getInstance();

    final cartData = products
        .map((product) => jsonEncode(product.toJson()))
        .toList();

    await prefs.setStringList(_cartKey, cartData);
  }

  Future<void> addToCart(ProductModel product) async {
    final cart = await getCart();

    final productKey = _getProductKey(product);

    final index = cart.indexWhere((item) => _getProductKey(item) == productKey);

    if (index != -1) {
      final currentProduct = cart[index];

      cart[index] = currentProduct.copyWith(
        quantity: (currentProduct.quantity + product.quantity).clamp(1, 999),
      );
    } else {
      cart.add(product.copyWith(quantity: product.quantity.clamp(1, 999)));
    }

    await _saveCart(cart);
  }

  Future<void> updateQuantity(ProductModel product, int quantity) async {
    final cart = await getCart();

    final productKey = _getProductKey(product);

    final index = cart.indexWhere((item) => _getProductKey(item) == productKey);

    if (index == -1) return;

    if (quantity <= 0) {
      cart.removeAt(index);
    } else {
      cart[index] = cart[index].copyWith(quantity: quantity.clamp(1, 999));
    }

    await _saveCart(cart);
  }

  Future<void> increaseQuantity(ProductModel product) async {
    await updateQuantity(product, product.quantity + 1);
  }

  Future<void> decreaseQuantity(ProductModel product) async {
    await updateQuantity(product, product.quantity - 1);
  }

  Future<void> removeProduct(ProductModel product) async {
    final cart = await getCart();

    final productKey = _getProductKey(product);

    cart.removeWhere((item) => _getProductKey(item) == productKey);

    await _saveCart(cart);
  }

  Future<void> removeFromCart(int productId) async {
    final cart = await getCart();

    cart.removeWhere((product) => product.id == productId);

    await _saveCart(cart);
  }

  Future<void> removeFromCartByFirestoreId(String firestoreId) async {
    final cart = await getCart();

    cart.removeWhere((product) => product.firestoreId == firestoreId);

    await _saveCart(cart);
  }

  Future<void> clearCart() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_cartKey);
  }
}
