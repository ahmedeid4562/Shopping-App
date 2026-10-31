import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/admin_product_api.dart';
import '../../data/model/product_model.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final AdminProductApi _adminProductApi;

  StreamSubscription<List<ProductModel>>? _productsSubscription;

  HomeCubit({AdminProductApi? adminProductApi})
      : _adminProductApi = adminProductApi ?? AdminProductApi(),
        super(HomeInitial());

  Future<void> getProducts() async {
    if (isClosed) return;

    await _productsSubscription?.cancel();

    if (isClosed) return;

    emit(HomeLoading());

    try {
      _productsSubscription = _adminProductApi.watchProducts().listen(
        (products) {
          if (isClosed) return;

          // Products come only from the Firestore products collection.
          emit(HomeSuccess(products));
        },
        onError: (Object error) {
          if (isClosed) return;

          emit(HomeError(error.toString()));
        },
      );
    } catch (e) {
      if (isClosed) return;

      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    if (isClosed) return;

    await getProducts();
  }

  @override
  Future<void> close() async {
    await _productsSubscription?.cancel();
    await super.close();
  }
}
