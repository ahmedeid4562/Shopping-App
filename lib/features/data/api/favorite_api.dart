import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product_model.dart';

class FavoriteApi {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  FavoriteApi({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _favoritesCollection {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('favorites');
  }

  Future<List<ProductModel>> getFavorites() async {
    final snapshot = await _favoritesCollection.get();

    return snapshot.docs.map((doc) {
      return ProductModel.fromJson(doc.data());
    }).toList();
  }

  Future<bool> isFavorite(int productId) async {
    final document = await _favoritesCollection
        .doc(productId.toString())
        .get();

    return document.exists;
  }

  Future<void> addFavorite(ProductModel product) async {
    await _favoritesCollection
        .doc(product.id.toString())
        .set(product.toJson());
  }

  Future<void> removeFavorite(int productId) async {
    await _favoritesCollection
        .doc(productId.toString())
        .delete();
  }

  Future<void> toggleFavorite(ProductModel product) async {
    final document = _favoritesCollection.doc(
      product.id.toString(),
    );

    final snapshot = await document.get();

    if (snapshot.exists) {
      await document.delete();
    } else {
      await document.set(product.toJson());
    }
  }

  Stream<List<ProductModel>> watchFavorites() {
    return _favoritesCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return ProductModel.fromJson(doc.data());
      }).toList();
    });
  }
}
