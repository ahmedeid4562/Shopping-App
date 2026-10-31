import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/cart_api.dart';
import '../../data/model/product_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial()) {
    loadCart();
  }

  final CartApi _cartApi = CartApi();

  final List<ProductModel> _products = [];

  List<ProductModel> get products => List.unmodifiable(_products);

  Future<void> loadCart() async {
    emit(const CartLoading());

    try {
      final products = await _cartApi.getCart();

      _products
        ..clear()
        ..addAll(products);

      emit(CartLoaded(List.from(_products)));
    } catch (e) {
      emit(CartError('Failed to load cart: $e'));
    }
  }

  Future<void> addToCart(ProductModel product) async {
    try {
      await _cartApi.addToCart(product);

      _products.add(product);

      emit(CartLoaded(List.from(_products)));
    } catch (e) {
      emit(CartError('Failed to add product: $e'));
    }
  }

  Future<void> removeFromCart(int productId) async {
    try {
      await _cartApi.removeFromCart(productId);

      _products.removeWhere((product) => product.id == productId);

      emit(CartLoaded(List.from(_products)));
    } catch (e) {
      emit(CartError('Failed to remove product: $e'));
    }
  }

  Future<void> clearCart() async {
    try {
      await _cartApi.clearCart();

      _products.clear();

      emit(const CartLoaded([]));
    } catch (e) {
      emit(CartError('Failed to clear cart: $e'));
    }
  }
}
