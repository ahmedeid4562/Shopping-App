import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/api/auth_api.dart';
import '../../../data/api/product_api.dart';

import '../../view_model/home_cubit.dart';
import '../../view_model/home_state.dart';

import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ShopHomeScreen extends StatelessWidget {
const ShopHomeScreen({super.key});

static const Color primaryColor = Color(0xFF385CF2);

@override
Widget build(BuildContext context) {
return BlocProvider(
create: (_) => HomeCubit(ProductApi())..getProducts(),
child: const _ShopHomeView(),
);
}
}

class _ShopHomeView extends StatefulWidget {
const _ShopHomeView();

@override
State<_ShopHomeView> createState() => _ShopHomeViewState();
}

class _ShopHomeViewState extends State<_ShopHomeView> {
final TextEditingController _searchController = TextEditingController();

String _selectedCategory = 'All';
String _searchQuery = '';

static const Color primaryColor = Color(0xFF385CF2);

// Clothing and fashion categories.
static const Set<String> clothingCategories = {
'mens-shirts',
'mens-shoes',
'mens-watches',
'tops',
'womens-bags',
'womens-dresses',
'womens-jewellery',
'womens-shoes',
'womens-watches',
};

@override
void dispose() {
_searchController.dispose();
super.dispose();
}

Future<void> _logout() async {
try {
await AuthApi().signOut();
  if (!mounted) return;

  Navigator.pushNamedAndRemoveUntil(
    context,
    '/login',
    (route) => false,
  );
} catch (e) {
  if (!mounted) return;

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(content: Text(e.toString())),
  );
}
}

@override
Widget build(BuildContext context) {
final theme = Theme.of(context);
final colors = theme.colorScheme;
return Scaffold(
  appBar: AppBar(
    title: const Text(
      'Shopping App',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    actions: [
      IconButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CartScreen(),
            ),
          );
        },
        icon: const Icon(Icons.shopping_cart_outlined),
        tooltip: 'My Cart',
      ),
      IconButton(
        onPressed: _logout,
        icon: const Icon(Icons.logout),
        tooltip: 'Logout',
      ),
      const SizedBox(width: 8),
    ],
  ),
  body: BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) {
      if (state is HomeLoading || state is HomeInitial) {
        return const Center(
          child: CircularProgressIndicator(
            color: primaryColor,
          ),
        );
      }

      if (state is HomeError) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.wifi_off_rounded,
                  size: 65,
                  color: Colors.grey,
                ),
                const SizedBox(height: 16),
                const Text(
                  'Something went wrong!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 20),
                ElevatedButton.icon(
                  onPressed: () {
                    context.read<HomeCubit>().getProducts();
                  },
                  icon: const Icon(Icons.refresh),
                  label: const Text('Try Again'),
                ),
              ],
            ),
          ),
        );
      }

      if (state is HomeSuccess) {
        debugPrint('TOTAL PRODUCTS: ${state.products.length}');

        debugPrint(
          'PRODUCT CATEGORIES: '
          '${state.products.map((p) => p.category).toSet()}',
        );

        // Show clothing products only.
        final products = state.products.where((product) {
          return clothingCategories.contains(product.category);
        }).toList();

        debugPrint('CLOTHING PRODUCTS: ${products.length}');

        final categories = [
          'All',
          ...products.map((product) => product.category).toSet().toList()
            ..sort(),
        ];

        // Filter by category and search.
        final filteredProducts = products.where((product) {
          final matchesCategory = _selectedCategory == 'All' ||
              product.category == _selectedCategory;

          final matchesSearch = product.title
              .toLowerCase()
              .contains(_searchQuery.toLowerCase());

          return matchesCategory && matchesSearch;
        }).toList();

        return RefreshIndicator(
          onRefresh: () {
            return context.read<HomeCubit>().refreshProducts();
          },
          color: primaryColor,
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hello, ${AuthApi().currentUser?.displayName ?? 'Shopper'} 👋',
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: colors.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Find Your Style',
                        style: theme.textTheme.headlineMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Search
                      TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            _searchQuery = value;
                          });
                        },
                        decoration: InputDecoration(
                          hintText: 'Search products...',
                          prefixIcon: const Icon(Icons.search),
                          filled: true,
                          fillColor: colors.surfaceContainerHighest,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),

                      // Banner
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(22),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF385CF2),
                              Color(0xFF7188FF),
                            ],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'NEW COLLECTION',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.2,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              'Discover Your\nOwn Style',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Text(
                              'Explore our latest fashion products.',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 15),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 9,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Text(
                                'Shop Now',
                                style: TextStyle(
                                  color: primaryColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Categories
                      Text(
                        'Categories',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 15),
                      SizedBox(
                        height: 42,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: categories.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 10),
                          itemBuilder: (context, index) {
                            final category = categories[index];

                            final isSelected =
                                _selectedCategory == category;

                            return ChoiceChip(
                              label: Text(
                                category == 'All'
                                    ? 'All'
                                    : category[0].toUpperCase() +
                                        category.substring(1),
                              ),
                              selected: isSelected,
                              selectedColor: primaryColor,
                              labelStyle: TextStyle(
                                color: isSelected
                                    ? Colors.white
                                    : colors.onSurface,
                                fontWeight: FontWeight.w600,
                              ),
                              onSelected: (_) {
                                setState(() {
                                  _selectedCategory = category;
                                });
                              },
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 28),

                      // Featured products title
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Featured Products',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '${filteredProducts.length} Items',
                            style: TextStyle(
                              color: colors.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),

              // Products Grid
              if (filteredProducts.isEmpty)
                const SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Text('No clothing products found'),
                  ),
                )
              else
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return ProductCard(
                          product: filteredProducts[index],
                        );
                      },
                      childCount: filteredProducts.length,
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 250,
                      mainAxisSpacing: 15,
                      crossAxisSpacing: 15,
                      mainAxisExtent: 280,
                    ),
                  ),
                ),

              const SliverToBoxAdapter(
                child: SizedBox(height: 25),
              ),
            ],
          ),
        );
      }

      return const SizedBox.shrink();
    },
  ),
);
}
}
