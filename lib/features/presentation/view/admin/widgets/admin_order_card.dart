import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../screens/admin_order_details_screen.dart';

class AdminOrderCard extends StatelessWidget {
  final Map<String, dynamic> order;
  final ValueChanged<String> onStatusChanged;

  const AdminOrderCard({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  static const Color primaryColor = Color(0xFF385CF2);

  static const List<String> statuses = [
    'Pending',
    'Processing',
    'Shipped',
    'Delivered',
    'Cancelled',
  ];

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'pending':
        return Colors.orange;
      case 'processing':
        return Colors.blue;
      case 'shipped':
        return Colors.purple;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  String _getLocalizedStatus(String status, AppLocalizations l) {
    switch (status.toLowerCase()) {
      case 'pending':
        return l.pendingStatus;
      case 'processing':
        return l.processingStatus;
      case 'shipped':
        return l.shippedStatus;
      case 'delivered':
        return l.deliveredStatus;
      case 'cancelled':
        return l.cancelledStatus;
      default:
        return status;
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    final status = order['status']?.toString() ?? 'Pending';

    final total = order['totalPrice'] is num
        ? (order['totalPrice'] as num).toDouble()
        : double.tryParse(order['totalPrice']?.toString() ?? '') ?? 0.0;

    final products = order['products'] is List
        ? order['products'] as List
        : [];

    final createdAt = order['createdAt'];
    final date = createdAt is Timestamp ? createdAt.toDate() : null;

    final availableStatuses = [
      ...statuses,
      if (!statuses.contains(status)) status,
    ];

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 0,
      color: colors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(
          color: colors.outline.withValues(alpha: 0.15),
        ),
      ),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => AdminOrderDetailsScreen(order: order),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.receipt_long,
                    color: primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      '${l.orderLabel} #${order['id'] ?? '--'}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  PopupMenuButton<String>(
                    tooltip: l.updateOrderStatus,
                    onSelected: onStatusChanged,
                    itemBuilder: (context) {
                      return availableStatuses.map((item) {
                        return PopupMenuItem<String>(
                          value: item,
                          child: Text(_getLocalizedStatus(item, l)),
                        );
                      }).toList();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 7,
                      ),
                      decoration: BoxDecoration(
                        color: _getStatusColor(status).withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            _getLocalizedStatus(status, l),
                            style: TextStyle(
                              color: _getStatusColor(status),
                              fontSize: 11,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.keyboard_arrow_down,
                            size: 16,
                            color: _getStatusColor(status),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 25),
              Text(
                order['customerName']?.toString() ?? l.unknownCustomer,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              _infoRow(
                Icons.phone_outlined,
                order['phone']?.toString() ?? '',
              ),
              const SizedBox(height: 7),
              _infoRow(
                Icons.location_on_outlined,
                order['address']?.toString() ?? '',
              ),
              const SizedBox(height: 7),
              _infoRow(
                Icons.payment_outlined,
                order['paymentMethod']?.toString() ?? '',
              ),
              if (date != null) ...[
                const SizedBox(height: 7),
                _infoRow(
                  Icons.calendar_today_outlined,
                  '${date.day}/${date.month}/${date.year}',
                ),
              ],
              const Divider(height: 25),
              Text(
                l.productsLabel,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 10),
              ...products.map((product) {
                if (product is! Map) {
                  return const SizedBox.shrink();
                }

                final quantity = product['quantity'] is num
                    ? (product['quantity'] as num).toInt()
                    : int.tryParse(
                        product['quantity']?.toString() ?? '',
                      ) ?? 1;

                final price = product['price'] is num
                    ? (product['price'] as num).toDouble()
                    : double.tryParse(
                        product['price']?.toString() ?? '',
                      ) ?? 0.0;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          product['title']?.toString() ?? l.unknownProduct,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(fontSize: 13),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'x$quantity',
                        style: TextStyle(
                          color: colors.onSurfaceVariant,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        '\$${(price * quantity).toStringAsFixed(2)}',
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                );
              }),
              const Divider(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    l.totalAmount,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  Text(
                    '\$${total.toStringAsFixed(2)}',
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    l.viewDetails,
                    style: const TextStyle(
                      color: primaryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(width: 5),
                  const Icon(
                    Icons.arrow_forward_ios,
                    color: primaryColor,
                    size: 13,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    if (text.isEmpty) return const SizedBox.shrink();

    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: Colors.grey,
        ),
        const SizedBox(width: 9),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 12),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}