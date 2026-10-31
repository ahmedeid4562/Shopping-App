import 'package:flutter/material.dart';

import '../../../../data/api/coupon_api.dart';

class ManageCouponsScreen extends StatefulWidget {
  const ManageCouponsScreen({super.key});

  @override
  State<ManageCouponsScreen> createState() => _ManageCouponsScreenState();
}

class _ManageCouponsScreenState extends State<ManageCouponsScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final CouponApi _couponApi = CouponApi();

  Future<void> _showAddCouponDialog() async {
    final formKey = GlobalKey<FormState>();

    final codeController = TextEditingController();
    final valueController = TextEditingController();
    final minOrderController = TextEditingController(text: '0');

    String type = 'percentage';
    DateTime? expiresAt;
    bool isSaving = false;

    await showDialog<void>(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            Future<void> chooseDate() async {
              final picked = await showDatePicker(
                context: dialogContext,
                initialDate: DateTime.now().add(const Duration(days: 7)),
                firstDate: DateTime.now(),
                lastDate: DateTime.now().add(const Duration(days: 3650)),
              );

              if (picked != null && dialogContext.mounted) {
                setDialogState(() {
                  expiresAt = DateTime(
                    picked.year,
                    picked.month,
                    picked.day,
                    23,
                    59,
                    59,
                  );
                });
              }
            }

            Future<void> saveCoupon() async {
              if (!formKey.currentState!.validate()) return;

              if (expiresAt == null) {
                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  const SnackBar(
                    content: Text('Please choose an expiration date'),
                  ),
                );
                return;
              }

              setDialogState(() => isSaving = true);

              try {
                await _couponApi.createCoupon(
                  code: codeController.text,
                  type: type,
                  value: double.parse(valueController.text),
                  minOrder: double.parse(minOrderController.text),
                  expiresAt: expiresAt!,
                );

                if (!mounted || !dialogContext.mounted) return;

                Navigator.pop(dialogContext);

               ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Coupon created successfully'),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                if (!dialogContext.mounted) return;

                setDialogState(() => isSaving = false);

                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }

            return AlertDialog(
              title: const Text('Create Coupon'),
              content: SingleChildScrollView(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: codeController,
                        textCapitalization: TextCapitalization.characters,
                        enabled: !isSaving,
                        decoration: const InputDecoration(
                          labelText: 'Coupon Code',
                          hintText: 'SAVE20',
                          prefixIcon: Icon(Icons.confirmation_number_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 3) {
                            return 'Enter at least 3 characters';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: const InputDecoration(
                          labelText: 'Discount Type',
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: 'percentage',
                            child: Text('Percentage (%)'),
                          ),
                          DropdownMenuItem(
                            value: 'fixed',
                            child: Text('Fixed Amount'),
                          ),
                        ],
                        onChanged: isSaving
                            ? null
                            : (value) {
                                if (value != null) {
                                  setDialogState(() {
                                    type = value;
                                  });
                                }
                              },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: valueController,
                        enabled: !isSaving,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: InputDecoration(
                          labelText: type == 'percentage'
                              ? 'Discount Percentage'
                              : 'Discount Amount',
                        ),
                        validator: (value) {
                          final number = double.tryParse(value ?? '');

                          if (number == null || number <= 0) {
                            return 'Enter a valid discount';
                          }

                          if (type == 'percentage' && number > 100) {
                            return 'Maximum percentage is 100';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      TextFormField(
                        controller: minOrderController,
                        enabled: !isSaving,
                        keyboardType: const TextInputType.numberWithOptions(
                          decimal: true,
                        ),
                        decoration: const InputDecoration(
                          labelText: 'Minimum Order Amount',
                        ),
                        validator: (value) {
                          final number = double.tryParse(value ?? '');

                          if (number == null || number < 0) {
                            return 'Enter a valid amount';
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      OutlinedButton.icon(
                        onPressed: isSaving ? null : chooseDate,
                        icon: const Icon(Icons.calendar_month),
                        label: Text(
                          expiresAt == null
                              ? 'Choose Expiration Date'
                              : '${expiresAt!.year}-'
                                    '${expiresAt!.month.toString().padLeft(2, '0')}-'
                                    '${expiresAt!.day.toString().padLeft(2, '0')}',
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              actions: [
                TextButton(
                  onPressed: isSaving
                      ? null
                      : () => Navigator.pop(dialogContext),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: isSaving ? null : saveCoupon,
                  child: isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Create'),
                ),
              ],
            );
          },
        );
      },
    );

    codeController.dispose();
    valueController.dispose();
    minOrderController.dispose();
  }

  Future<void> _deleteCoupon(String code) async {
    try {
      await _couponApi.deleteCoupon(code);

      if (!mounted) return;

      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Coupon deleted')));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  Future<void> _toggleCoupon(CouponModel coupon) async {
    try {
      await _couponApi.updateCouponStatus(
        code: coupon.code,
        isActive: !coupon.isActive,
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            coupon.isActive ? 'Coupon deactivated' : 'Coupon activated',
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(e.toString()), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Manage Coupons',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCouponDialog,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: const Text('Add Coupon'),
      ),
      body: StreamBuilder<List<CouponModel>>(
        stream: _couponApi.watchCoupons(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Failed to load coupons: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final coupons = snapshot.data ?? [];

          if (coupons.isEmpty) {
            return const Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.discount_outlined, size: 65, color: Colors.grey),
                  SizedBox(height: 12),
                  Text('No coupons created yet'),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 90),
            itemCount: coupons.length,
            itemBuilder: (context, index) {
              final coupon = coupons[index];

              final discountText = coupon.type == 'percentage'
                  ? '${coupon.value.toStringAsFixed(0)}% OFF'
                  : '\$${coupon.value.toStringAsFixed(2)} OFF';

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                color: colors.surface,
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: primaryColor.withValues(alpha: 0.1),
                    child: const Icon(
                      Icons.local_offer_outlined,
                      color: primaryColor,
                    ),
                  ),
                  title: Text(
                    coupon.code,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '$discountText\n'
                    'Minimum order: \$${coupon.minOrder.toStringAsFixed(2)}\n'
                    'Expires: ${coupon.expiresAt.year}-'
                    '${coupon.expiresAt.month.toString().padLeft(2, '0')}-'
                    '${coupon.expiresAt.day.toString().padLeft(2, '0')}\n'
                    'Status: ${coupon.isActive ? 'Active' : 'Inactive'}',
                  ),
                  isThreeLine: true,
                  trailing: PopupMenuButton<String>(
                    onSelected: (action) {
                      if (action == 'toggle') {
                        _toggleCoupon(coupon);
                      } else if (action == 'delete') {
                        _deleteCoupon(coupon.code);
                      }
                    },
                    itemBuilder: (_) => [
                      PopupMenuItem(
                        value: 'toggle',
                        child: Text(
                          coupon.isActive ? 'Deactivate' : 'Activate',
                        ),
                      ),
                      const PopupMenuItem(
                        value: 'delete',
                        child: Text('Delete'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
