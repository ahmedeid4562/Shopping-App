import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/api/order_api.dart';
import '../../../data/api/coupon_api.dart';

import '../../view_model/cart_cubit.dart';
import '../../view_model/cart_state.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  static const Color primaryColor = Color(0xFF385CF2);

  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _couponController = TextEditingController();

  final CouponApi _couponApi = CouponApi();

  String _paymentMethod = 'Cash on Delivery';

  CouponModel? _appliedCoupon;
  double _discountAmount = 0;

  bool _isLoading = false;
  bool _isApplyingCoupon = false;

  @override
  void initState() {
    super.initState();

    final user = FirebaseAuth.instance.currentUser;
    _nameController.text = user?.displayName ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _couponController.dispose();
    super.dispose();
  }

  Future<void> _applyCoupon(double subtotal) async {
    if (_couponController.text.trim().isEmpty) {
      _showMessage('Enter a coupon code');
      return;
    }

    setState(() => _isApplyingCoupon = true);

    try {
      final coupon = await _couponApi.validateCoupon(
        code: _couponController.text,
        subtotal: subtotal,
      );

      if (!mounted) return;

      setState(() {
        _appliedCoupon = coupon;
        _discountAmount = coupon.calculateDiscount(subtotal);
      });

      _showMessage(
        'Coupon applied successfully!',
        isError: false,
      );
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _appliedCoupon = null;
        _discountAmount = 0;
      });

      _showMessage(e.toString());
    } finally {
      if (mounted) {
        setState(() => _isApplyingCoupon = false);
      }
    }
  }

  void _removeCoupon() {
    setState(() {
      _appliedCoupon = null;
      _discountAmount = 0;
      _couponController.clear();
    });
  }

  void _showMessage(String message, {bool isError = true}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
      ),
    );
  }

  Future<void> _placeOrder(CartLoaded state) async {
    if (!_formKey.currentState!.validate()) return;

    if (state.products.isEmpty) {
      _showMessage('Your cart is empty');
      return;
    }

    final cartCubit = context.read<CartCubit>();
    final navigator = Navigator.of(context);
    final messenger = ScaffoldMessenger.of(context);

    setState(() => _isLoading = true);

    try {
      final finalTotal = (state.totalPrice - _discountAmount)
          .clamp(0, state.totalPrice)
          .toDouble();

      await OrderApi().createOrder(
        products: state.products,
        subtotalPrice: state.totalPrice,
        discountAmount: _discountAmount,
        totalPrice: finalTotal,
        couponCode: _appliedCoupon?.code,
        customerName: _nameController.text.trim(),
        phone: _phoneController.text.trim(),
        address: _addressController.text.trim(),
        paymentMethod: _paymentMethod,
      );

      if (!mounted || !navigator.mounted) return;

      cartCubit.clearCart();

      await showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (dialogContext) {
          return AlertDialog(
            icon: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 55,
            ),
            title: const Text('Order Placed Successfully!'),
            content: const Text(
              'Your order has been saved successfully.',
              textAlign: TextAlign.center,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(dialogContext);
                  navigator.pop();
                },
                child: const Text('Continue Shopping'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      if (!mounted || !messenger.mounted) return;

      messenger.showSnackBar(
        SnackBar(
          content: Text('Failed to place order: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Widget _buildCouponSection(double subtotal) {
    final colors = Theme.of(context).colorScheme;

    if (_appliedCoupon != null) {
      return Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.green.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: Colors.green.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.check_circle,
              color: Colors.green,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _appliedCoupon!.code,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'Coupon applied successfully',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
            ),
            TextButton(
              onPressed: _isLoading ? null : _removeCoupon,
              child: const Text('Remove'),
            ),
          ],
        ),
      );
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _couponController,
            textCapitalization: TextCapitalization.characters,
            enabled: !_isLoading && !_isApplyingCoupon,
            decoration: InputDecoration(
              hintText: 'Enter promo code',
              prefixIcon: const Icon(Icons.discount_outlined),
              filled: true,
              fillColor: colors.surfaceContainerHighest,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          height: 52,
          child: ElevatedButton(
            onPressed: _isLoading || _isApplyingCoupon
                ? null
                : () => _applyCoupon(subtotal),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: _isApplyingCoupon
                ? const SizedBox(
                    width: 18,
                    height: 18,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text('Apply'),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Checkout',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is! CartLoaded || state.products.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          final subtotal = state.totalPrice;

          final finalTotal = (subtotal - _discountAmount)
              .clamp(0, subtotal)
              .toDouble();

          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Delivery Information',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),

                  _buildTextField(
                    controller: _nameController,
                    label: 'Full Name',
                    icon: Icons.person_outline,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _phoneController,
                    label: 'Phone Number',
                    icon: Icons.phone_outlined,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 16),

                  _buildTextField(
                    controller: _addressController,
                    label: 'Delivery Address',
                    icon: Icons.location_on_outlined,
                    maxLines: 3,
                  ),

                  const SizedBox(height: 28),

                  const Text(
                    'Payment Method',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  RadioGroup<String>(
                    groupValue: _paymentMethod,
                    onChanged: (String? value) {
                      if (value != null && !_isLoading) {
                        setState(() {
                          _paymentMethod = value;
                        });
                      }
                    },
                    child: RadioListTile<String>(
                      value: 'Cash on Delivery',
                      activeColor: primaryColor,
                      title: const Text('Cash on Delivery'),
                      secondary: const Icon(Icons.money),
                      enabled: !_isLoading,
                    ),
                  ),

                  const SizedBox(height: 24),

                  const Text(
                    'Promo Code',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),

                  _buildCouponSection(subtotal),

                  const SizedBox(height: 24),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: colors.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      children: [
                        _buildPriceRow(
                          'Subtotal',
                          subtotal,
                        ),
                        const SizedBox(height: 10),
                        _buildPriceRow(
                          'Discount',
                          -_discountAmount,
                          valueColor: Colors.green,
                        ),
                        const Divider(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total Amount',
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${finalTotal.toStringAsFixed(2)}',
                              style: const TextStyle(
                                color: primaryColor,
                                fontSize: 21,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),

                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading || _isApplyingCoupon
                          ? null
                          : () => _placeOrder(state),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: _isLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text(
                              'Place Order',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPriceRow(
    String title,
    double amount, {
    Color? valueColor,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Text(
          '${amount < 0 ? '-' : ''}\$${amount.abs().toStringAsFixed(2)}',
          style: TextStyle(
            color: valueColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter $label';
        }

        if (label == 'Phone Number' && value.trim().length < 7) {
          return 'Please enter a valid phone number';
        }

        return null;
      },
    );
  }
}