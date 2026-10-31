import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/model/product_model.dart';
import 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(const CartInitial());

  final List<ProductModel> _products = [];

  List<ProductModel> get products => List.unmodifiable(_products);

  void loadCart() {
    emit(const CartLoaded([]));
  }

  void addToCart(ProductModel product) {
    _products.add(product);
    emit(CartLoaded(List.from(_products)));
  }

  void removeFromCart(int productId) {
    _products.removeWhere((product) => product.id == productId);
    emit(CartLoaded(List.from(_products)));
  }

  void clearCart() {
    _products.clear();
    emit(const CartLoaded([]));
  }
}
