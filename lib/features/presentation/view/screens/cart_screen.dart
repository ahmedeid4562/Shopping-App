import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../view_model/cart_cubit.dart';
import '../../view_model/cart_state.dart';
import '../../../data/model/product_model.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.myCart,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is! CartLoaded || state.products.isEmpty) {
                return const SizedBox.shrink();
              }

              return IconButton(
                onPressed: () => _showClearConfirmation(context, l),
                icon: const Icon(Icons.delete_outline),
                tooltip: l.clearCart,
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          if (state is CartLoading || state is CartInitial) {
            return const Center(
              child: CircularProgressIndicator(color: primaryColor),
            );
          }

          if (state is CartError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 55),
                  const SizedBox(height: 12),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(state.message, textAlign: TextAlign.center),
                  ),
                  ElevatedButton(
                    onPressed: () => context.read<CartCubit>().loadCart(),
                    child: Text(l.retry),
                  ),
                ],
              ),
            );
          }

          if (state is CartLoaded) {
            if (state.products.isEmpty) {
              return _buildEmptyCart(context, l);
            }

            return _buildCartContent(context, state, l);
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Future<void> _showClearConfirmation(
    BuildContext context,
    AppLocalizations l,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: Text(l.clearCart),
          content: Text(l.clearCartConfirmation),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l.cancel),
            ),
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, true),
              child: Text(
                l.clearCart,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );

    if (confirmed == true && context.mounted) {
      await context.read<CartCubit>().clearCart();
    }
  }

  Widget _buildEmptyCart(BuildContext context, AppLocalizations l) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.shopping_cart_outlined,
              size: 90,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 20),
            Text(
              l.yourCartIsEmpty,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Text(
              l.emptyCartDescription,
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCartContent(
    BuildContext context,
    CartLoaded state,
    AppLocalizations l,
  ) {
    final products = state.products;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: products.length,
            separatorBuilder: (_, _) => const SizedBox(height: 14),
            itemBuilder: (context, index) {
              return _buildCartItem(context, products[index], l);
            },
          ),
        ),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 12,
                offset: const Offset(0, -3),
              ),
            ],
          ),
          child: SafeArea(
            top: false,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${state.totalQuantity} ${l.items}',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                    Text(
                      l.totalAmount,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '\$${state.totalPrice.toStringAsFixed(2)}',
                      style: const TextStyle(
                        color: primaryColor,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 18),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const CheckoutScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: Text(
                      l.proceedToCheckout,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCartItem(
    BuildContext context,
    ProductModel product,
    AppLocalizations l,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: colors.outlineVariant),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: product.image.isEmpty
                ? Container(
                    width: 85,
                    height: 85,
                    color: colors.surfaceContainerHighest,
                    child: const Icon(Icons.image_not_supported_outlined),
                  )
                : CachedNetworkImage(
                    imageUrl: product.image,
                    width: 85,
                    height: 85,
                    fit: BoxFit.contain,
                    placeholder: (_, _) => const SizedBox(
                      width: 85,
                      height: 85,
                      child: Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      ),
                    ),
                    errorWidget: (_, _, _) => const SizedBox(
                      width: 85,
                      height: 85,
                      child: Icon(Icons.image_not_supported_outlined),
                    ),
                  ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '\$${product.totalPrice.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onPressed: () {
                        context.read<CartCubit>().decreaseQuantity(product);
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      child: Text(
                        '${product.quantity}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    _quantityButton(
                      icon: Icons.add,
                      onPressed: product.quantity >= 999
                          ? null
                          : () {
                              context.read<CartCubit>().increaseQuantity(
                                product,
                              );
                            },
                    ),
                  ],
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {
              context.read<CartCubit>().removeProduct(product);
            },
            icon: const Icon(Icons.delete_outline, color: Colors.red),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback? onPressed,
  }) {
    return Material(
      color: primaryColor.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(8),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(8),
        child: SizedBox(
          width: 30,
          height: 30,
          child: Icon(
            icon,
            size: 17,
            color: onPressed == null ? Colors.grey : primaryColor,
          ),
        ),
      ),
    );
  }
}
