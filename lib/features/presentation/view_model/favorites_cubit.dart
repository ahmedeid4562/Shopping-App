import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shopping_app/features/data/model/product_model.dart';

import '../../data/api/favorite_api.dart';
import 'favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  final FavoriteApi _favoriteApi;

  FavoritesCubit(this._favoriteApi) : super(const FavoritesInitial());

  List<ProductModel> _favorites = [];

  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  Future<void> loadFavorites() async {
    emit(const FavoritesLoading());

    try {
      _favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(List.from(_favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<bool> isFavorite(ProductModel product) async {
    try {
      return await _favoriteApi.isProductFavorite(product);
    } catch (e) {
      return false;
    }
  }

  Future<void> toggleFavorite(ProductModel product) async {
    try {
      await _favoriteApi.toggleFavorite(product);
      _favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(List.from(_favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> addFavorite(ProductModel product) async {
    try {
      await _favoriteApi.addFavorite(product);
      _favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(List.from(_favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavorite(int productId) async {
    try {
      await _favoriteApi.removeFavorite(productId);
      _favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(List.from(_favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }

  Future<void> removeFavoriteProduct(ProductModel product) async {
    try {
      await _favoriteApi.removeFavoriteProduct(product);
      _favorites = await _favoriteApi.getFavorites();
      emit(FavoritesSuccess(List.from(_favorites)));
    } catch (e) {
      emit(FavoritesError(e.toString()));
    }
  }
}
