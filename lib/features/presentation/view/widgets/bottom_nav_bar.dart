import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

class BottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;

  const BottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  Widget build(BuildContext context) {
    final l = AppLocalizations.of(context)!;

    return NavigationBar(
      selectedIndex: currentIndex,
      onDestinationSelected: onTap,
      backgroundColor: Theme.of(context).colorScheme.surface,
      indicatorColor: primaryColor.withValues(alpha: 0.12),
      elevation: 3,
      destinations: [
        NavigationDestination(
          icon: const Icon(Icons.home_outlined),
          selectedIcon: const Icon(Icons.home),
          label: l.home,
        ),
        NavigationDestination(
          icon: const Icon(Icons.category_outlined),
          selectedIcon: const Icon(Icons.category),
          label: l.categories,
        ),
        NavigationDestination(
          icon: const Icon(Icons.favorite_border),
          selectedIcon: const Icon(Icons.favorite),
          label: l.favorites,
        ),
        NavigationDestination(
          icon: const Icon(Icons.shopping_cart_outlined),
          selectedIcon: const Icon(Icons.shopping_cart),
          label: l.cart,
        ),
        NavigationDestination(
          icon: const Icon(Icons.person_outline),
          selectedIcon: const Icon(Icons.person),
          label: l.profile,
        ),
      ],
    );
  }
}
