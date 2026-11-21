import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../../data/api/coupon_api.dart';

class ManageCouponsScreen extends StatefulWidget {
  const ManageCouponsScreen({super.key});

  @override
  State<ManageCouponsScreen> createState() => _ManageCouponsScreenState();
}

class _ManageCouponsScreenState extends State<ManageCouponsScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final CouponApi _couponApi = CouponApi();

  AppLocalizations get l => AppLocalizations.of(context)!;

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
            final dialogL = AppLocalizations.of(dialogContext)!;

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
                  SnackBar(content: Text(dialogL.chooseExpirationDateFirst)),
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
                  SnackBar(
                    content: Text(l.couponCreatedSuccessfully),
                    backgroundColor: Colors.green,
                  ),
                );
              } catch (e) {
                if (!dialogContext.mounted) return;

                setDialogState(() => isSaving = false);

                ScaffoldMessenger.of(dialogContext).showSnackBar(
                  SnackBar(
                    content: Text('${dialogL.failedToCreateCoupon}: $e'),
                    backgroundColor: Colors.red,
                  ),
                );
              }
            }

            return AlertDialog(
              title: Text(dialogL.createCoupon),
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
                        decoration: InputDecoration(
                          labelText: dialogL.couponCode,
                          hintText: 'SAVE20',
                          prefixIcon: const Icon(
                            Icons.confirmation_number_outlined,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.trim().length < 3) {
                            return dialogL.enterAtLeast3Characters;
                          }

                          return null;
                        },
                      ),

                      const SizedBox(height: 16),

                      DropdownButtonFormField<String>(
                        initialValue: type,
                        decoration: InputDecoration(
                          labelText: dialogL.discountType,
                        ),
                        items: [
                          DropdownMenuItem(
                            value: 'percentage',
                            child: Text(dialogL.percentage),
                          ),
                          DropdownMenuItem(
                            value: 'fixed',
                            child: Text(dialogL.fixedAmount),
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
                              ? dialogL.discountPercentage
                              : dialogL.discountAmount,
                        ),
                        validator: (value) {
                          final number = double.tryParse(value ?? '');

                          if (number == null || number <= 0) {
                            return dialogL.enterValidDiscount;
                          }

                          if (type == 'percentage' && number > 100) {
                            return dialogL.maximumPercentageIs100;
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
                        decoration: InputDecoration(
                          labelText: dialogL.minimumOrderAmount,
                        ),
                        validator: (value) {
                          final number = double.tryParse(value ?? '');

                          if (number == null || number < 0) {
                            return dialogL.enterValidAmount;
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
                              ? dialogL.chooseExpirationDate
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
                  child: Text(dialogL.cancel),
                ),
                ElevatedButton(
                  onPressed: isSaving ? null : saveCoupon,
                  child: isSaving
                      ? const SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(dialogL.create),
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
          .showSnackBar(SnackBar(content: Text(l.couponDeleted)));
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.failedToDeleteCoupon}: $e'),
          backgroundColor: Colors.red,
        ),
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
            coupon.isActive ? l.couponDeactivated : l.couponActivated,
          ),
        ),
      );
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('${l.failedToUpdateCoupon}: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.manageCoupons,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddCouponDialog,
        backgroundColor: primaryColor,
        foregroundColor: Colors.white,
        icon: const Icon(Icons.add),
        label: Text(l.addCoupon),
      ),
      body: StreamBuilder<List<CouponModel>>(
        stream: _couponApi.watchCoupons(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Text(
                  '${l.failedToLoadCoupons}: ${snapshot.error}',
                  textAlign: TextAlign.center,
                ),
              ),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final coupons = snapshot.data ?? [];

          if (coupons.isEmpty) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.discount_outlined,
                    size: 65,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 12),
                  Text(l.noCouponsCreatedYet),
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
                  ? '${coupon.value.toStringAsFixed(0)}% ${l.off}'
                  : '\$${coupon.value.toStringAsFixed(2)} ${l.off}';

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
                    '${l.minimumOrder}: \$${coupon.minOrder.toStringAsFixed(2)}\n'
                    '${l.expires}: ${coupon.expiresAt.year}-'
                    '${coupon.expiresAt.month.toString().padLeft(2, '0')}-'
                    '${coupon.expiresAt.day.toString().padLeft(2, '0')}\n'
                    '${l.status}: ${coupon.isActive ? l.active : l.inactive}',
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
                          coupon.isActive ? l.deactivate : l.activate,
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        child: Text(l.deleteAction),
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
