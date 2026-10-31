import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/data/model/product_model.dart';

import '../../data/api/favorite_api.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteApi _favoriteApi;

  FavoritesCubit(this._favoriteApi) : super(const FavoritesInitial());

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());

    try {
      final favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(favorites));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    try {
      await _favoriteApi.toggleFavorite(product);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> addFavorite(ProductModel product) async {
    try {
      await _favoriteApi.addFavorite(product);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavorite(int productId) async {
    try {
      await _favoriteApi.removeFavorite(productId);
      await loadFavorites();
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}