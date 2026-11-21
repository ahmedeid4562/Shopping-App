import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class AdminOrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;

  const AdminOrderDetailsScreen({
    super.key,
    required this.order,
  });

  static const Color primaryColor = Color(0xFF385CF2);

  double _toDouble(dynamic value) {
    if (value is num) return value.toDouble();
    return double.tryParse(value?.toString() ?? '') ?? 0.0;
  }

  int _toInt(dynamic value) {
    if (value is num) return value.toInt();
    return int.tryParse(value?.toString() ?? '') ?? 1;
  }

  String _formatDate(dynamic value) {
    DateTime? date;

    if (value is Timestamp) {
      date = value.toDate();
    } else if (value is DateTime) {
      date = value;
    }

    if (date == null) return '--';

    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  String _formatTime(dynamic value) {
    DateTime? date;

    if (value is Timestamp) {
      date = value.toDate();
    } else if (value is DateTime) {
      date = value;
    }

    if (date == null) return '--';

    final hour = date.hour > 12 ? date.hour - 12 : date.hour;
    final formattedHour = hour == 0 ? 12 : hour;
    final minute = date.minute.toString().padLeft(2, '0');
    final period = date.hour >= 12 ? 'PM' : 'AM';

    return '$formattedHour:$minute $period';
  }

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
    final l = AppLocalizations.of(context)!;
    final colors = Theme.of(context).colorScheme;

    final status = order['status']?.toString() ?? 'Pending';
    final products = order['products'] is List
        ? order['products'] as List
        : [];

    final subtotal = _toDouble(
      order['subtotalPrice'] ?? order['totalPrice'],
    );

    final discount = _toDouble(order['discountAmount']);
    final total = _toDouble(order['totalPrice']);

    final createdAt = order['createdAt'];

    return Scaffold(
      backgroundColor: colors.surface,
      appBar: AppBar(
        title: Text(l.orderLabel),
        centerTitle: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderHeader(
                context,
                l,
                status,
              ),
              const SizedBox(height: 20),
              _buildSection(
                context,
                title: l.customerName,
                icon: Icons.person_outline,
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.person_outline,
                      title: l.customerName,
                      value: order['customerName']?.toString() ??
                          l.unknownCustomer,
                    ),
                    _buildInfoTile(
                      icon: Icons.phone_outlined,
                      title: l.phoneNumber,
                      value: order['phone']?.toString() ?? '--',
                    ),
                    _buildInfoTile(
                      icon: Icons.location_on_outlined,
                      title: l.address,
                      value: order['address']?.toString() ?? '--',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: l.orderSummary,
                icon: Icons.shopping_bag_outlined,
                child: Column(
                  children: [
                    if (products.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Text(l.unknownProduct),
                      )
                    else
                      ...products.map((product) {
                        if (product is! Map) {
                          return const SizedBox.shrink();
                        }

                        final title =
                            product['title']?.toString() ?? l.unknownProduct;

                        final image = product['image']?.toString() ??
                            product['thumbnail']?.toString() ??
                            '';

                        final price = _toDouble(product['price']);
                        final quantity = _toInt(product['quantity']);
                        final productTotal = price * quantity;

                        return _buildProductTile(
                          context,
                          title: title,
                          image: image,
                          price: price,
                          quantity: quantity,
                          total: productTotal,
                          quantityLabel: l.quantity,
                        );
                      }),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildSection(
                context,
                title: l.paymentMethod,
                icon: Icons.payment_outlined,
                child: Column(
                  children: [
                    _buildInfoTile(
                      icon: Icons.payment_outlined,
                      title: l.paymentMethod,
                      value: order['paymentMethod']?.toString() ?? '--',
                    ),
                    if (order['couponCode'] != null &&
                        order['couponCode'].toString().isNotEmpty)
                      _buildInfoTile(
                        icon: Icons.discount_outlined,
                        title: l.couponCode,
                        value: order['couponCode'].toString(),
                      ),
                    _buildInfoTile(
                      icon: Icons.calendar_today_outlined,
                      title: l.orderDate,
                      value: _formatDate(createdAt),
                    ),
                    _buildInfoTile(
                      icon: Icons.access_time,
                      title: l.orderTime,
                      value: _formatTime(createdAt),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              _buildPriceSummary(
                context,
                l: l,
                subtotal: subtotal,
                discount: discount,
                total: total,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader(
    BuildContext context,
    AppLocalizations l,
    String status,
  ) {
    final colors = Theme.of(context).colorScheme;
    final statusColor = _getStatusColor(status);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: primaryColor.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: primaryColor.withValues(alpha: 0.12),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.receipt_long,
                  color: primaryColor,
                  size: 25,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l.orderLabel,
                      style: TextStyle(
                        color: colors.onSurfaceVariant,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '#${order['id'] ?? '--'}',
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 9,
            ),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: statusColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  _getLocalizedStatus(status, l),
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Widget child,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: primaryColor,
                size: 21,
              ),
              const SizedBox(width: 9),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const Divider(height: 25),
          child,
        ],
      ),
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: Colors.grey,
            size: 19,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? '--' : value,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductTile(
    BuildContext context, {
    required String title,
    required String image,
    required double price,
    required int quantity,
    required double total,
    required String quantityLabel,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 65,
              height: 70,
              child: image.isNotEmpty
                  ? Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return _imagePlaceholder();
                      },
                    )
                  : _imagePlaceholder(),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$quantityLabel: $quantity',
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Text(
            '\$${total.toStringAsFixed(2)}',
            style: const TextStyle(
              color: primaryColor,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: Colors.grey.withValues(alpha: 0.12),
      child: const Center(
        child: Icon(
          Icons.image_outlined,
          color: Colors.grey,
          size: 28,
        ),
      ),
    );
  }

  Widget _buildPriceSummary(
    BuildContext context, {
    required AppLocalizations l,
    required double subtotal,
    required double discount,
    required double total,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        children: [
          _priceRow(
            l.subtotal,
            '\$${subtotal.toStringAsFixed(2)}',
          ),
          const SizedBox(height: 12),
          _priceRow(
            l.discount,
            '-\$${discount.toStringAsFixed(2)}',
            valueColor: Colors.green,
          ),
          const Divider(height: 25),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l.totalAmount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: primaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _priceRow(
    String title,
    String value, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 13,
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: valueColor,
          ),
        ),
      ],
    );
  }
}