import 'package:flutter/material.dart';

import '../../../data/api/category_api.dart';
import '../../../data/api/admin_product_api.dart';
import '../../../data/model/product_model.dart';

import '../widgets/product_card.dart';

class CategoryProductsScreen extends StatefulWidget {
  final String categorySlug;
  final String categoryName;

  const CategoryProductsScreen({
    super.key,
    required this.categorySlug,
    required this.categoryName,
  });

  @override
  State<CategoryProductsScreen> createState() => _CategoryProductsScreenState();
}

class _CategoryProductsScreenState extends State<CategoryProductsScreen> {
  final CategoryApi _categoryApi = CategoryApi();
  final AdminProductApi _adminProductApi = AdminProductApi();

  late final Stream<List<ProductModel>> _storeProductsStream;

  List<ProductModel> _apiProducts = [];

  bool _isLoading = true;
  String? _errorMessage;

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  void initState() {
    super.initState();

    _storeProductsStream = _adminProductApi.watchProducts();

    _loadProducts();
  }

  String _normalizeCategory(String value) {
    return value.trim().toLowerCase().replaceAll(RegExp(r'[\s_]+'), '-');
  }

  Future<void> _loadProducts() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final products = await _categoryApi.getProductsByCategory(
        widget.categorySlug,
      );

      if (!mounted) return;

      setState(() {
        _apiProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _apiProducts = [];
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  List<ProductModel> _mergeProducts(List<ProductModel> storeProducts) {
    final selectedCategory = _normalizeCategory(widget.categorySlug);

    final matchingStoreProducts = storeProducts.where((product) {
      return _normalizeCategory(product.category) == selectedCategory;
    }).toList();

    final combined = <ProductModel>[];
    final identifiers = <String>{};

    for (final product in [..._apiProducts, ...matchingStoreProducts]) {
      final identifier = product.firestoreId != null
          ? 'store_${product.firestoreId}'
          : 'api_${product.id}';

      if (identifiers.add(identifier)) {
        combined.add(product);
      }
    }

    return combined;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _storeProductsStream,
        builder: (context, snapshot) {
          return _buildBody(
            theme,
            colors,
            snapshot.data ?? [],
            snapshot.hasError,
          );
        },
      ),
    );
  }

  Widget _buildBody(
    ThemeData theme,
    ColorScheme colors,
    List<ProductModel> storeProducts,
    bool hasStreamError,
  ) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    final products = _mergeProducts(storeProducts);

    if (products.isEmpty && _errorMessage != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Could not load products',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: TextStyle(color: colors.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadProducts,
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    if (products.isEmpty && hasStreamError) {
      return Center(
        child: Text(
          'Failed to load store products.',
          style: TextStyle(color: colors.onSurfaceVariant),
        ),
      );
    }

    if (products.isEmpty) {
      return const Center(child: Text('No products found in this category'));
    }

    return RefreshIndicator(
      onRefresh: _loadProducts,
      color: primaryColor,
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Explore Products',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${products.length} Items',
                    style: TextStyle(color: colors.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate((context, index) {
                return ProductCard(product: products[index]);
              }, childCount: products.length),
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 280,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
