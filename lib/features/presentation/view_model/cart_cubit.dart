import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/cart_api.dart';
import '../../data/model/product_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit({CartApi? cartApi})
    : _cartApi = cartApi ?? CartApi(),
      super(const CartInitial()) {
    loadCart();
  }

  final CartApi _cartApi;

  final List<ProductModel> _products = [];

  List<ProductModel> get products => List.unmodifiable(_products);

  Future<void> loadCart() async {
    emit(const CartLoading());

    try {
      final products = await _cartApi.getCart();

      _products
        ..clear()
        ..addAll(products);

      _emitLoaded();
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  void _emitLoaded() {
    emit(CartLoaded(List.unmodifiable(_products)));
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      await _cartApi.addToCart(product);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to add product: $e'));
    }
  }

  Future<void> increaseQuantity(ProductModel product) async {
    try {
      await _cartApi.increaseQuantity(product);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to increase quantity: $e'));
    }
  }

  Future<void> decreaseQuantity(ProductModel product) async {
    try {
      await _cartApi.decreaseQuantity(product);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to decrease quantity: $e'));
    }
  }

  Future<void> updateQuantity(ProductModel product, int quantity) async {
    try {
      await _cartApi.updateQuantity(product, quantity);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to update quantity: $e'));
    }
  }

  Future<void> removeProduct(ProductModel product) async {
    try {
      await _cartApi.removeProduct(product);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to remove product: $e'));
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      await _cartApi.removeFromCart(productId);

      await _refreshCart();
    } catch (e) {
      emit(CartError('Failed to remove product: $e'));
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartApi.clearCart();

      _products.clear();

      _emitLoaded();
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }

  Future<void> _refreshCart() async {
    final products = await _cartApi.getCart();

    _products
      ..clear()
      ..addAll(products);

    _emitLoaded();
  }
}
