import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../data/api/order_api.dart';

import '../widgets/admin_order_card.dart';
import 'manage_products_screen.dart';
import 'manage_coupons_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() =>
      _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final OrderApi _orderApi = OrderApi();

  late Future<bool> _adminAccessFuture;

  @override
  void initState() {
    super.initState();
    _adminAccessFuture = _checkAdminAccess();
  }

  // Check whether the current user is an admin.
  Future<bool> _checkAdminAccess() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final token = await user.getIdTokenResult(true);
    final claims = token.claims;

    return claims != null && claims['admin'] == true;
  }

  // Update order status.
  Future<void> _updateStatus(
    Map<String, dynamic> order,
    String status,
  ) async {
    try {
      final userId = order['userId']?.toString();
      final orderId = order['id']?.toString();

      if (userId == null ||
          userId.isEmpty ||
          orderId == null ||
          orderId.isEmpty) {
        throw Exception('Order information is missing');
      }

      await _orderApi.updateOrderStatus(
        userId: userId,
        orderId: orderId,
        status: status,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Order status updated to $status'),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to update order: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // Open products management screen.
  void _openManageProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ManageProductsScreen(),
      ),
    );
  }

  // Open coupons management screen.
  void _openManageCoupons() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => const ManageCouponsScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Admin Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<bool>(
        future: _adminAccessFuture,
        builder: (context, accessSnapshot) {
          if (accessSnapshot.connectionState ==
              ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (accessSnapshot.hasError) {
            return Center(
              child: Text(
                'Failed to verify admin access:\n'
                '${accessSnapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (accessSnapshot.data != true) {
            return const Center(
              child: Text(
                'Access Denied\n'
                'Admin privileges are required.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            );
          }

          return _buildDashboard();
        },
      ),
    );
  }

  Widget _buildDashboard() {
    final colors = Theme.of(context).colorScheme;

    return Column(
      children: [
        // Manage Products Button.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Card(
            elevation: 0,
            color: primaryColor.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: primaryColor.withValues(alpha: 0.2),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.inventory_2_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              title: const Text(
                'Manage Products',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Add, edit and delete products',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: primaryColor,
                size: 18,
              ),
              onTap: _openManageProducts,
            ),
          ),
        ),

        // Manage Coupons Button.
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Card(
            elevation: 0,
            color: Colors.orange.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Colors.orange.withValues(alpha: 0.2),
              ),
            ),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.discount_outlined,
                  color: Colors.white,
                  size: 26,
                ),
              ),
              title: const Text(
                'Manage Coupons',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                'Create and manage discount codes',
                style: TextStyle(
                  color: colors.onSurfaceVariant,
                  fontSize: 12,
                ),
              ),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: Colors.orange,
                size: 18,
              ),
              onTap: _openManageCoupons,
            ),
          ),
        ),

        // Orders Dashboard.
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _orderApi.watchAllOrders(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      'Failed to load orders:\n${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (snapshot.connectionState ==
                  ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              final orders = snapshot.data ?? [];

              final pending = orders
                  .where((order) => order['status'] == 'Pending')
                  .length;

              final processing = orders
                  .where((order) => order['status'] == 'Processing')
                  .length;

              final delivered = orders
                  .where((order) => order['status'] == 'Delivered')
                  .length;

              return RefreshIndicator(
                onRefresh: () async {
                  setState(() {
                    _adminAccessFuture = _checkAdminAccess();
                  });
                },
                child: ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    const Text(
                      'Overview',
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    GridView.count(
                      shrinkWrap: true,
                      physics:
                          const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildStatCard(
                          title: 'Total Orders',
                          value: orders.length,
                          icon: Icons.shopping_bag_outlined,
                          color: primaryColor,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: 'Pending',
                          value: pending,
                          icon: Icons.pending_actions,
                          color: Colors.orange,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: 'Processing',
                          value: processing,
                          icon: Icons.inventory_2_outlined,
                          color: Colors.blue,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: 'Delivered',
                          value: delivered,
                          icon: Icons.check_circle_outline,
                          color: Colors.green,
                          colors: colors,
                        ),
                      ],
                    ),

                    const SizedBox(height: 28),

                    Row(
                      mainAxisAlignment:
                          MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'All Orders',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${orders.length} Orders',
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    if (orders.isEmpty)
                      const Padding(
                        padding: EdgeInsets.symmetric(
                          vertical: 45,
                        ),
                        child: Column(
                          children: [
                            Icon(
                              Icons.receipt_long_outlined,
                              size: 65,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 12),
                            Text(
                              'No Orders Yet',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                              ),
                            ),
                          ],
                        ),
                      )
                    else
                      ...orders.map(
                        (order) => AdminOrderCard(
                          order: order,
                          onStatusChanged: (status) {
                            _updateStatus(order, status);
                          },
                        ),
                      ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  // Dashboard statistic card.
  Widget _buildStatCard({
    required String title,
    required int value,
    required IconData icon,
    required Color color,
    required ColorScheme colors,
  }) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: colors.outline.withValues(alpha: 0.15),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(
            icon,
            color: color,
            size: 26,
          ),
          Text(
            '$value',
            style: const TextStyle(
              fontSize: 23,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
