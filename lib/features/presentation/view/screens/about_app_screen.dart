import 'package:flutter/material.dart';

class AboutAppScreen extends StatelessWidget {
  const AboutAppScreen({super.key});

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'About App',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 30),

            Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(28),
              ),
              child: const Icon(
                Icons.shopping_bag_outlined,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              'Shopping App',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Version 1.0.0',
              style: TextStyle(fontSize: 14, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 30),

            Text(
              'About Us',
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),

            const SizedBox(height: 12),

            Text(
              'Shopping App is your simple and convenient shopping '
              'companion. Explore different products, discover categories, '
              'save your favorite items, and manage your shopping experience '
              'all in one place.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.7,
                color: colors.onSurfaceVariant,
              ),
            ),

            const SizedBox(height: 30),

            _buildInfoTile(
              context,
              icon: Icons.shopping_cart_outlined,
              title: 'Easy Shopping',
              subtitle: 'Browse and discover different products.',
            ),

            _buildInfoTile(
              context,
              icon: Icons.favorite_border,
              title: 'Favorites',
              subtitle: 'Save products you love.',
            ),

            _buildInfoTile(
              context,
              icon: Icons.security_outlined,
              title: 'Secure Experience',
              subtitle: 'Enjoy a simple and secure user experience.',
            ),

            const SizedBox(height: 30),

            Divider(color: colors.outline.withValues(alpha: 0.2)),

            const SizedBox(height: 15),

            Text(
              'Made with Flutter',
              style: TextStyle(fontSize: 13, color: colors.onSurfaceVariant),
            ),

            const SizedBox(height: 8),

            Text(
              '© 2026 Shopping App. All rights reserved.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: colors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: colors.outline.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: primaryColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: colors.onSurface,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12,
                    color: colors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
