import 'package:equatable/equatable.dart';

import '../../data/model/product_model.dart';

abstract class CartState extends Equatable {
  const CartState();

  @override
  List<Object?> get props => [];
}

class CartInitial extends CartState {
  const CartInitial();
}

class CartLoading extends CartState {
  const CartLoading();
}

class CartLoaded extends CartState {
  final List<ProductModel> products;

  const CartLoaded(this.products);

  double get totalPrice {
    return products.fold(
      0,
      (total, product) => total + product.price,
    );
  }

  @override
  List<Object?> get props => [products];
}

class CartError extends CartState {
  final String message;

  const CartError(this.message);

  @override
  List<Object?> get props => [message];
}
