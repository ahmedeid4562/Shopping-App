import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/product_model.dart';

class OrderApi {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OrderApi({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  CollectionReference<Map<String, dynamic>> get _ordersCollection {
    final user = _auth.currentUser;

    if (user == null) {
      throw Exception('Please login first');
    }

    return _firestore
        .collection('users')
        .doc(user.uid)
        .collection('orders');
  }

  Future<String> createOrder({
    required List<ProductModel> products,
    required double totalPrice,
    required String customerName,
    required String phone,
    required String address,
    required String paymentMethod,
    double? subtotalPrice,
    double discountAmount = 0,
    String? couponCode,
  }) async {
    if (products.isEmpty) {
      throw Exception('Your cart is empty');
    }

    if (totalPrice < 0 || discountAmount < 0) {
      throw Exception('Invalid order total');
    }

    final order = {
      'products': products.map((product) => product.toJson()).toList(),
      'subtotalPrice': subtotalPrice ?? totalPrice + discountAmount,
      'discountAmount': discountAmount,
      'totalPrice': totalPrice,
      'couponCode': couponCode,
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

  Stream<List<Map<String, dynamic>>> watchAllOrders() {
    return _firestore
        .collectionGroup('orders')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        return {
          ...doc.data(),
          'id': doc.id,
          'userId': doc.reference.parent.parent?.id,
        };
      }).toList();
    });
  }

  Future<void> updateOrderStatus({
    required String userId,
    required String orderId,
    required String status,
  }) async {
    if (status.trim().isEmpty) {
      throw Exception('Order status cannot be empty');
    }

    await _firestore
        .collection('users')
        .doc(userId)
        .collection('orders')
        .doc(orderId)
        .update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> cancelOrder(String orderId) async {
    await _ordersCollection.doc(orderId).update({
      'status': 'Cancelled',
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }
}
