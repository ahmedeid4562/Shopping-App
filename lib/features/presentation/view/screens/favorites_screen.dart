import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/api/favorite_api.dart';
import '../../../data/model/product_model.dart';
import '../widgets/product_card.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final l = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.myFavorites,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: FavoriteApi().watchFavorites(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 55, color: Colors.red),
                  const SizedBox(height: 12),
                  Text(l.failedToLoadFavorites),
                  const SizedBox(height: 15),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const FavoritesScreen(),
                        ),
                      );
                    },
                    child: Text(l.tryAgain),
                  ),
                ],
              ),
            );
          }

          final favorites = snapshot.data ?? [];

          if (favorites.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_border,
                    size: 85,
                    color: colors.onSurfaceVariant,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l.noFavoritesYet,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l.addProductsToFavorites,
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favorites.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 15,
              crossAxisSpacing: 15,
              mainAxisExtent: 280,
            ),
            itemBuilder: (context, index) {
              return ProductCard(product: favorites[index]);
            },
          );
        },
      ),
    );
  }
}
