import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product_model.dart';

class OrderApi {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderApi({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _ordersCollection {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    return _firestore.collection('users').doc(user.uid).collection('orders');
  }

  Future<String> createOrder({
    required List<ProductModel> products,
    required double totalPrice,
    required String customerName,
    required String phone,
    required String address,
    required String paymentMethod,
  }) async {
    if (products.isEmpty) {
      throw Exception('Your cart is empty');
    }

    final order = {
      'products': products.map((product) => product.toJson()).toList(),
      'totalPrice': totalPrice,
      'customerName': customerName,
      'phone': phone,
      'address': address,
      'paymentMethod': paymentMethod,
      'status': 'Pending',
      'createdAt': FieldValue.serverTimestamp(),
    };

    final document = await _ordersCollection.add(order);

    return document.id;
  }

  Stream<List<Map<String, dynamic>>> watchOrders() {
    return _ordersCollection
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            return {'id': doc.id, ...doc.data()};
          }).toList();
        });
  }

  Future<void> cancelOrder(String orderId) async {
    await _ordersCollection.doc(orderId).update({'status': 'Cancelled'});
  }
}
