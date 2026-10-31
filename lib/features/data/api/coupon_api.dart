import 'package:cloud_firestore/cloud_firestore.dart';

class CouponModel {
  final String code;
  final String type;
  final double value;
  final double minOrder;
  final DateTime expiresAt;
  final bool isActive;

  const CouponModel({
    required this.code,
    required this.type,
    required this.value,
    required this.minOrder,
    required this.expiresAt,
    required this.isActive,
  });

  factory CouponModel.fromFirestore(
    String documentId,
    Map<String, dynamic> data,
  ) {
    final expiry = data['expiresAt'];

    return CouponModel(
      code: documentId,
      type: data['type']?.toString() ?? 'percentage',
      value: (data['value'] as num?)?.toDouble() ?? 0,
      minOrder: (data['minOrder'] as num?)?.toDouble() ?? 0,
      expiresAt: expiry is Timestamp
          ? expiry.toDate()
          : DateTime.fromMillisecondsSinceEpoch(0),
      isActive: data['isActive'] == true,
    );
  }

  double calculateDiscount(double subtotal) {
    if (type == 'percentage') {
      return (subtotal * value / 100).clamp(0, subtotal).toDouble();
    }

    return value.clamp(0, subtotal).toDouble();
  }
}

class CouponApi {
  final FirebaseFirestore _firestore;

  CouponApi({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _couponsCollection {
    return _firestore.collection('coupons');
  }

  Stream<List<CouponModel>> watchCoupons() {
    return _couponsCollection.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        return CouponModel.fromFirestore(doc.id, doc.data());
      }).toList();
    });
  }

  Future<CouponModel> validateCoupon({
    required String code,
    required double subtotal,
  }) async {
    final normalizedCode = code.trim().toUpperCase();

    if (normalizedCode.isEmpty) {
      throw Exception('Please enter a coupon code');
    }

    final document = await _couponsCollection.doc(normalizedCode).get();

    if (!document.exists || document.data() == null) {
      throw Exception('Invalid coupon code');
    }

    final coupon = CouponModel.fromFirestore(
      document.id,
      document.data()!,
    );

    if (!coupon.isActive) {
      throw Exception('This coupon is inactive');
    }

    if (!coupon.expiresAt.isAfter(DateTime.now())) {
      throw Exception('This coupon has expired');
    }

    if (subtotal < coupon.minOrder) {
      throw Exception(
        'Minimum order is \$${coupon.minOrder.toStringAsFixed(2)}',
      );
    }

    if (coupon.value <= 0) {
      throw Exception('Invalid coupon value');
    }

    if (coupon.type == 'percentage' && coupon.value > 100) {
      throw Exception('Invalid discount percentage');
    }

    if (coupon.type != 'percentage' && coupon.type != 'fixed') {
      throw Exception('Invalid coupon type');
    }

    return coupon;
  }

  Future<void> createCoupon({
    required String code,
    required String type,
    required double value,
    required double minOrder,
    required DateTime expiresAt,
  }) async {
    final normalizedCode = code.trim().toUpperCase();

    if (!RegExp(r'^[A-Z0-9_-]{3,20}$').hasMatch(normalizedCode)) {
      throw Exception(
        'Code must be 3-20 characters using letters, numbers, _ or -',
      );
    }

    if (type != 'percentage' && type != 'fixed') {
      throw Exception('Invalid coupon type');
    }

    if (value <= 0 || minOrder < 0) {
      throw Exception('Invalid coupon amount');
    }

    if (type == 'percentage' && value > 100) {
      throw Exception('Percentage cannot exceed 100');
    }

    if (!expiresAt.isAfter(DateTime.now())) {
      throw Exception('Expiration date must be in the future');
    }

    final document = _couponsCollection.doc(normalizedCode);
    final existing = await document.get();

    if (existing.exists) {
      throw Exception('This coupon code already exists');
    }

    await document.set({
      'code': normalizedCode,
      'type': type,
      'value': value,
      'minOrder': minOrder,
      'expiresAt': Timestamp.fromDate(expiresAt),
      'isActive': true,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateCouponStatus({
    required String code,
    required bool isActive,
  }) async {
    await _couponsCollection.doc(code).update({
      'isActive': isActive,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteCoupon(String code) async {
    await _couponsCollection.doc(code).delete();
  }
}
