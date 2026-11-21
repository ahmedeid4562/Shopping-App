import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../../data/api/order_api.dart';

import '../widgets/admin_order_card.dart';
import 'manage_products_screen.dart';
import 'manage_coupons_screen.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final OrderApi _orderApi = OrderApi();

  late Future<bool> _adminAccessFuture;
  late final Stream<List<Map<String, dynamic>>> _ordersStream;

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();
    _adminAccessFuture = _checkAdminAccess();
    _ordersStream = _orderApi.watchAllOrders();
  }

  Future<bool> _checkAdminAccess() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) return false;

    final token = await user.getIdTokenResult(true);
    final claims = token.claims;

    return claims != null && claims['admin'] == true;
  }

  String _getLocalizedStatus(String status) {
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

  Future<void> _changeAdminPassword() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null || user.email == null) {
      return;
    }

    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    bool isLoading = false;
    bool obscureCurrent = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    await showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) {
        final dialogL = AppLocalizations.of(dialogContext)!;

        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return AlertDialog(
              title: Text(
                dialogL.changePassword,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      controller: currentPasswordController,
                      obscureText: obscureCurrent,
                      decoration: InputDecoration(
                        labelText: dialogL.currentPassword,
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureCurrent
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscureCurrent = !obscureCurrent;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: newPasswordController,
                      obscureText: obscureNew,
                      decoration: InputDecoration(
                        labelText: dialogL.newPassword,
                        prefixIcon: const Icon(Icons.lock_reset),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureNew
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscureNew = !obscureNew;
                            });
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: confirmPasswordController,
                      obscureText: obscureConfirm,
                      decoration: InputDecoration(
                        labelText: dialogL.confirmNewPassword,
                        prefixIcon: const Icon(Icons.verified_user_outlined),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscureConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setDialogState(() {
                              obscureConfirm = !obscureConfirm;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: Text(dialogL.cancel),
                ),
                ElevatedButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                          final currentPassword =
                              currentPasswordController.text;
                          final newPassword = newPasswordController.text;
                          final confirmPassword =
                              confirmPasswordController.text;

                          if (currentPassword.isEmpty ||
                              newPassword.isEmpty ||
                              confirmPassword.isEmpty) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(content: Text(dialogL.fillAllFields)),
                            );
                            return;
                          }

                          if (newPassword.length < 6) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(dialogL.passwordMinLength),
                              ),
                            );
                            return;
                          }

                          if (newPassword != confirmPassword) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(dialogL.passwordsDoNotMatch),
                              ),
                            );
                            return;
                          }

                          if (currentPassword == newPassword) {
                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(dialogL.newPasswordDifferent),
                              ),
                            );
                            return;
                          }

                          setDialogState(() {
                            isLoading = true;
                          });

                          try {
                            final credential = EmailAuthProvider.credential(
                              email: user.email!,
                              password: currentPassword,
                            );

                            await user.reauthenticateWithCredential(credential);

                            await user.updatePassword(newPassword);

                            if (!dialogContext.mounted) return;

                            Navigator.pop(dialogContext);

                            if (!mounted) return;

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(l.passwordChangedSuccessfully),
                                backgroundColor: Colors.green,
                              ),
                            );
                          } on FirebaseAuthException catch (e) {
                            if (!dialogContext.mounted) return;

                            setDialogState(() {
                              isLoading = false;
                            });

                            String message;

                            switch (e.code) {
                              case 'wrong-password':
                              case 'invalid-credential':
                                message = dialogL.incorrectCurrentPassword;
                                break;
                              case 'weak-password':
                                message = dialogL.chooseStrongerPassword;
                                break;
                              case 'requires-recent-login':
                                message = dialogL.pleaseLoginAgain;
                                break;
                              default:
                                message = dialogL.somethingWentWrong;
                            }

                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(message),
                                backgroundColor: Colors.red,
                              ),
                            );
                          } catch (e) {
                            if (!dialogContext.mounted) return;

                            setDialogState(() {
                              isLoading = false;
                            });

                            ScaffoldMessenger.of(dialogContext).showSnackBar(
                              SnackBar(
                                content: Text(dialogL.somethingWentWrong),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primaryColor,
                    foregroundColor: Colors.white,
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Text(dialogL.changePassword),
                ),
              ],
            );
          },
        );
      },
    );

    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> _updateStatus(Map<String, dynamic> order, String status) async {
    try {
      final userId = order['userId']?.toString();
      final orderId = order['id']?.toString();

      if (userId == null ||
          userId.isEmpty ||
          orderId == null ||
          orderId.isEmpty) {
        throw Exception(l.orderInformationMissing);
      }

      await _orderApi.updateOrderStatus(
        userId: userId,
        orderId: orderId,
        status: status,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${l.orderStatusUpdatedTo} ${_getLocalizedStatus(status)}',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(l.failedToUpdateOrder),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _openManageProducts() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ManageProductsScreen()),
    );
  }

  void _openManageCoupons() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const ManageCouponsScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.adminDashboard,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            tooltip: l.changePassword,
            onPressed: _changeAdminPassword,
            icon: const Icon(Icons.lock_reset),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: FutureBuilder<bool>(
        future: _adminAccessFuture,
        builder: (context, accessSnapshot) {
          if (accessSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (accessSnapshot.hasError) {
            return Center(
              child: Text(
                '${l.failedToVerifyAdminAccess}:\n'
                '${accessSnapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          if (accessSnapshot.data != true) {
            return Center(
              child: Text(
                '${l.accessDenied}\n'
                '${l.adminPrivilegesRequired}',
                textAlign: TextAlign.center,
                style: const TextStyle(
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
    final localizations = l;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: Card(
            elevation: 0,
            color: primaryColor.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: primaryColor.withValues(alpha: 0.2)),
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
              title: Text(
                localizations.manageProducts,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                localizations.manageProductsSubtitle,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
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
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Card(
            elevation: 0,
            color: Colors.orange.withValues(alpha: 0.08),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(color: Colors.orange.withValues(alpha: 0.2)),
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
              title: Text(
                localizations.manageCoupons,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Text(
                localizations.manageCouponsSubtitle,
                style: TextStyle(color: colors.onSurfaceVariant, fontSize: 12),
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
        Expanded(
          child: StreamBuilder<List<Map<String, dynamic>>>(
            stream: _ordersStream,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      '${localizations.failedToLoadOrders}:\n'
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
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
                    Text(
                      localizations.overview,
                      style: const TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.5,
                      children: [
                        _buildStatCard(
                          title: localizations.totalOrders,
                          value: orders.length,
                          icon: Icons.shopping_bag_outlined,
                          color: primaryColor,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: localizations.pendingStatus,
                          value: pending,
                          icon: Icons.pending_actions,
                          color: Colors.orange,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: localizations.processingStatus,
                          value: processing,
                          icon: Icons.inventory_2_outlined,
                          color: Colors.blue,
                          colors: colors,
                        ),
                        _buildStatCard(
                          title: localizations.deliveredStatus,
                          value: delivered,
                          icon: Icons.check_circle_outline,
                          color: Colors.green,
                          colors: colors,
                        ),
                      ],
                    ),
                    const SizedBox(height: 28),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.allOrders,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          localizations.ordersCount(orders.length),
                          style: TextStyle(
                            color: colors.onSurfaceVariant,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    if (orders.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 45),
                        child: Column(
                          children: [
                            const Icon(
                              Icons.receipt_long_outlined,
                              size: 65,
                              color: Colors.grey,
                            ),
                            const SizedBox(height: 12),
                            Text(
                              localizations.noOrdersYet,
                              style: const TextStyle(
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
        border: Border.all(color: colors.outline.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(icon, color: color, size: 26),
          Text(
            '$value',
            style: const TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
          ),
          Text(
            title,
            style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
