import 'dart:async';

import 'package:flutter/material.dart';

import '../../../data/api/product_api.dart';
import '../../../data/api/admin_product_api.dart';
import '../../../data/model/product_model.dart';
import '../widgets/product_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final ProductApi _productApi = ProductApi();
  final AdminProductApi _adminProductApi = AdminProductApi();
  final TextEditingController _searchController = TextEditingController();

  late final Stream<List<ProductModel>> _storeProductsStream;

  Timer? _debounce;

  List<ProductModel> _apiProducts = [];

  bool _isLoading = false;
  bool _hasSearched = false;

  String _searchQuery = '';
  String? _errorMessage;

  int _searchRequestId = 0;

  static const Color primaryColor = Color(0xFF385CF2);

  @override
  void initState() {
    super.initState();
    _storeProductsStream = _adminProductApi.watchProducts();
  }

  void _onSearchChanged(String query) {
    _debounce?.cancel();

    final searchQuery = query.trim();

    setState(() {
      _searchQuery = searchQuery;
      _apiProducts = [];
      _errorMessage = null;
      _isLoading = searchQuery.isNotEmpty;
      _hasSearched = searchQuery.isNotEmpty;
    });

    if (searchQuery.isEmpty) {
      _searchRequestId++;
      return;
    }

    _debounce = Timer(
      const Duration(milliseconds: 500),
      () => _searchProducts(searchQuery),
    );
  }

  Future<void> _searchProducts(String query) async {
    if (query.isEmpty) return;

    final requestId = ++_searchRequestId;

    setState(() {
      _searchQuery = query;
      _isLoading = true;
      _hasSearched = true;
      _errorMessage = null;
    });

    try {
      final products = await _productApi.searchProducts(query);

      if (!mounted || requestId != _searchRequestId) return;

      setState(() {
        _apiProducts = products;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted || requestId != _searchRequestId) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  void _clearSearch() {
    _debounce?.cancel();
    _searchRequestId++;
    _searchController.clear();

    setState(() {
      _apiProducts = [];
      _searchQuery = '';
      _isLoading = false;
      _hasSearched = false;
      _errorMessage = null;
    });
  }

  List<ProductModel> _mergeProducts(List<ProductModel> storeProducts) {
    final storeMatches = storeProducts.where((product) {
      return product.title.toLowerCase().contains(_searchQuery.toLowerCase());
    }).toList();

    final combined = <ProductModel>[];
    final identifiers = <String>{};

    for (final product in [..._apiProducts, ...storeMatches]) {
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
  void dispose() {
    _debounce?.cancel();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Search Products',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              textInputAction: TextInputAction.search,
              onSubmitted: (value) {
                _debounce?.cancel();
                _searchProducts(value.trim());
              },
              decoration: InputDecoration(
                hintText: 'Search for products...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchController.text.isNotEmpty
                    ? IconButton(
                        onPressed: _clearSearch,
                        icon: const Icon(Icons.close),
                      )
                    : null,
                filled: true,
                fillColor: colors.surfaceContainerHighest.withValues(
                  alpha: 0.5,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide(
                    color: colors.outline.withValues(alpha: 0.15),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(16),
                  borderSide: const BorderSide(color: primaryColor, width: 1.5),
                ),
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<ProductModel>>(
              stream: _storeProductsStream,
              builder: (context, snapshot) {
                final storeProducts = snapshot.data ?? [];

                return _buildSearchResults(
                  theme,
                  colors,
                  storeProducts,
                  snapshot,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults(
    ThemeData theme,
    ColorScheme colors,
    List<ProductModel> storeProducts,
    AsyncSnapshot<List<ProductModel>> snapshot,
  ) {
    if (!_hasSearched) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search,
              size: 75,
              color: colors.onSurfaceVariant.withValues(alpha: 0.4),
            ),
            const SizedBox(height: 16),
            Text(
              'Find Your Favorite Products',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Search by product name',
              style: TextStyle(color: colors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    final products = _mergeProducts(storeProducts);

    if (products.isNotEmpty && !_isLoading) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Search Results',
                  style: theme.textTheme.titleMedium?.copyWith(
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
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: products.length,
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 15,
                crossAxisSpacing: 15,
                mainAxisExtent: 280,
              ),
              itemBuilder: (context, index) {
                return ProductCard(product: products[index]);
              },
            ),
          ),
        ],
      );
    }

    if (_isLoading || snapshot.connectionState == ConnectionState.waiting) {
      return const Center(
        child: CircularProgressIndicator(color: primaryColor),
      );
    }

    if (_errorMessage != null && snapshot.hasError) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Text(
            'Failed to load search results:\n$_errorMessage\n${snapshot.error}',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }

    if (_errorMessage != null && products.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 60, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'Something went wrong',
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
                onPressed: () {
                  _searchProducts(_searchController.text.trim());
                },
                icon: const Icon(Icons.refresh),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
    }

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.inventory_2_outlined,
            size: 65,
            color: colors.onSurfaceVariant.withValues(alpha: 0.4),
          ),
          const SizedBox(height: 16),
          const Text(
            'No Products Found',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with another name',
            style: TextStyle(color: colors.onSurfaceVariant),
          ),
        ],
      ),
    );
  }
}
