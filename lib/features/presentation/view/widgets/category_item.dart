import 'package:flutter/material.dart';

import '../../../data/model/category_model.dart';

class CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final VoidCallback onTap;

  const CategoryItem({super.key, required this.category, required this.onTap});

  static const Color primaryColor = Color(0xFF385CF2);

  IconData _getCategoryIcon() {
    final slug = category.slug.toLowerCase();

    if (slug.contains('beauty')) {
      return Icons.face_retouching_natural;
    } else if (slug.contains('fragrance')) {
      return Icons.spa_outlined;
    } else if (slug.contains('furniture')) {
      return Icons.chair_outlined;
    } else if (slug.contains('groceries')) {
      return Icons.local_grocery_store_outlined;
    } else if (slug.contains('decoration')) {
      return Icons.home_outlined;
    } else if (slug.contains('kitchen')) {
      return Icons.kitchen_outlined;
    } else if (slug.contains('laptop') || slug.contains('computer')) {
      return Icons.laptop_outlined;
    } else if (slug.contains('phone') || slug.contains('mobile')) {
      return Icons.smartphone_outlined;
    } else if (slug.contains('shirt') || slug.contains('clothing')) {
      return Icons.checkroom_outlined;
    } else if (slug.contains('shoe')) {
      return Icons.shopping_bag_outlined;
    } else if (slug.contains('watch')) {
      return Icons.watch_outlined;
    } else if (slug.contains('automotive')) {
      return Icons.directions_car_outlined;
    }

    return Icons.category_outlined;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: colors.outline.withValues(alpha: 0.15)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(_getCategoryIcon(), color: primaryColor, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                category.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: colors.onSurface,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
