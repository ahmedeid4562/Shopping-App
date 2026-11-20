import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/api/order_api.dart';
import '../../../data/model/product_model.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  static const Color primaryColor = Color(0xFF385CF2);

  AppLocalizations getL(BuildContext context) {
    return AppLocalizations.of(context)!;
  }

  String _localizedStatus(String status, AppLocalizations l) {
    switch (status.toLowerCase()) {
      case 'pending':
        return l.pending;
      case 'processing':
        return l.processing;
      case 'shipped':
        return l.shipped;
      case 'delivered':
        return l.delivered;
      case 'cancelled':
        return l.cancelled;
      case 'completed':
        return l.completed;
      default:
        return status;
    }
  }

  Future<void> _cancelOrder(BuildContext context, String orderId) async {
    final l = getL(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l.cancelOrder),
          content: Text(l.cancelOrderConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l.no),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l.yesCancel,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true || !context.mounted) return;

    try {
      await OrderApi().cancelOrder(orderId);

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.orderCancelledSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.failedToCancelOrder}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _deleteOrder(BuildContext context, String orderId) async {
    final l = getL(context);

    final confirm = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          icon: const Icon(
            Icons.delete_forever,
            color: Colors.red,
            size: 45,
          ),
          title: Text(l.deleteOrder),
          content: Text(l.deleteOrderConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l.no),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l.yesDelete,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm != true || !context.mounted) return;

    try {
      final uid = FirebaseAuth.instance.currentUser?.uid;

      if (uid == null) {
        throw Exception(l.pleaseLoginFirst);
      }

      await FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .collection('orders')
          .doc(orderId)
          .delete();

      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.orderDeletedSuccessfully),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.failedToDeleteOrder}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = getL(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.myOrders,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: OrderApi().watchOrders(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.error_outline,
                      size: 55,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      l.failedToLoadOrders,
                      style: const TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      snapshot.error.toString(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          final orders = snapshot.data ?? [];

          if (orders.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.receipt_long_outlined,
                    size: 85,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l.noOrdersYet,
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.ordersWillAppearHere,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }

          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            separatorBuilder: (_, _) => const SizedBox(height: 16),
            itemBuilder: (context, index) {
              final order = orders[index];

              return _buildOrderCard(context, order);
            },
          );
        },
      ),
    );
  }

  Widget _buildOrderCard(
    BuildContext context,
    Map<String, dynamic> order,
  ) {
    final colors = Theme.of(context).colorScheme;
    final l = getL(context);

    final orderId = order['id']?.toString() ?? '';
    final status = order['status']?.toString() ?? 'Pending';
    final totalPrice = (order['totalPrice'] as num?)?.toDouble() ?? 0;

    final productsData = order['products'] as List? ?? [];

    final products = productsData
        .whereType<Map>()
        .map(
          (product) =>
              ProductModel.fromJson(Map<String, dynamic>.from(product)),
        )
        .toList();

    final createdAt = order['createdAt'];

    String orderDate = l.dateUnavailable;

    if (createdAt is Timestamp) {
      final date = createdAt.toDate();

      orderDate = '${date.day}/${date.month}/${date.year}';
    } else if (createdAt is DateTime) {
      orderDate = '${createdAt.day}/${createdAt.month}/${createdAt.year}';
    }

    final isCancelled = status.toLowerCase() == 'cancelled';

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.orderDetails,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isCancelled
                      ? Colors.red.withValues(alpha: 0.1)
                      : Colors.orange.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  _localizedStatus(status, l),
                  style: TextStyle(
                    color: isCancelled ? Colors.red : Colors.orange.shade800,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            '${l.orderId}: $orderId',
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            '${l.date}: $orderDate',
            style: TextStyle(
              color: colors.onSurfaceVariant,
              fontSize: 13,
            ),
          ),
          const Divider(height: 24),
          ...products.map((product) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      product.image,
                      width: 55,
                      height: 55,
                      fit: BoxFit.contain,
                      errorBuilder: (_, _, _) {
                        return Container(
                          width: 55,
                          height: 55,
                          color: colors.surfaceContainerHighest,
                          child: const Icon(
                            Icons.image_not_supported_outlined,
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      product.title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            );
          }),
          const Divider(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.totalAmount,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Text(
                '\$${totalPrice.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Row(
            children: [
              if (!isCancelled)
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: orderId.isEmpty
                        ? null
                        : () => _cancelOrder(context, orderId),
                    icon: const Icon(Icons.cancel_outlined, size: 18),
                    label: Text(l.cancelOrder),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.orange.shade800,
                      side: BorderSide(color: Colors.orange.shade800),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              if (!isCancelled) const SizedBox(width: 10),
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: orderId.isEmpty
                      ? null
                      : () => _deleteOrder(context, orderId),
                  icon: const Icon(Icons.delete_outline, size: 18),
                  label: Text(l.deleteOrder),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}