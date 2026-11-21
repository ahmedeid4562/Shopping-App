import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/admin_product_api.dart';
import '../../data/model/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AdminProductApi _productApi;
  StreamSubscription<List<ProductModel>>? _productsSubscription;

  HomeCubit({AdminProductApi? productApi})
    : _productApi = productApi ?? AdminProductApi(),
      super(HomeInitial());

  Future<void> getProducts() async {
    if (isClosed) return;

    await _productsSubscription?.cancel();

    emit(HomeLoading());

    _productsSubscription = _productApi.watchProducts().listen(
      (products) {
        if (isClosed) return;
        emit(HomeSuccess(products));
      },
      onError: (error) {
        if (isClosed) return;
        emit(HomeError(error.toString()));
      },
    );
  }

  Future<void> refreshProducts() async {
    await getProducts();
  }

  @override
  Future<void> close() async {
    await _productsSubscription?.cancel();
    return super.close();
  }
}
