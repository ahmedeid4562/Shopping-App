import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/api/product_api.dart';
import 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final ProductApi _productApi;

  HomeCubit(this._productApi) : super(HomeInitial());

  Future<void> getProducts() async {
    if (isClosed) return;

    emit(HomeLoading());

    try {
      final products = await _productApi.getProducts();

      if (isClosed) return;

      emit(HomeSuccess(products));
    } catch (e) {
      if (isClosed) return;

      emit(HomeError(e.toString()));
    }
  }

  Future<void> refreshProducts() async {
    if (isClosed) return;

    await getProducts();
  }
}
