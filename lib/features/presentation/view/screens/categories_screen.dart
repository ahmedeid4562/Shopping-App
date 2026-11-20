import 'package:flutter/material.dart';
import 'package:shopping_app/l10n/app_localizations.dart';

import '../../../data/api/category_api.dart';
import '../../../data/api/admin_product_api.dart';
import '../../../data/model/category_model.dart';
import '../../../data/model/product_model.dart';

import 'category_products_screen.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final CategoryApi _categoryApi = CategoryApi();
  final AdminProductApi _adminProductApi = AdminProductApi();

  late final Stream<List<ProductModel>> _storeProductsStream;

  List<CategoryModel> _categories = [];

  bool _isLoading = true;
  String? _errorMessage;

  static const Color primaryColor = Color(0xFF385CF2);

  AppLocalizations get l => AppLocalizations.of(context)!;

  @override
  void initState() {
    super.initState();

    _storeProductsStream = _adminProductApi.watchProducts();

    _loadCategories();
  }

  Future<void> _loadCategories() async {
    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      final categories = await _categoryApi.getCategories();

      if (!mounted) return;

      setState(() {
        _categories = categories;
        _isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;

      setState(() {
        _errorMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  String _normalizeCategory(String value) {
    return value.trim().toLowerCase().replaceAll(
          RegExp(r'[\s_]+'),
          '-',
        );
  }

  String _localizedCategoryName(String slug) {
    switch (slug) {
      case 'men':
        return l.categoryMen;
      case 'women':
        return l.categoryWomen;
      case 'kids':
        return l.categoryKids;
      case 'watches':
        return l.categoryWatches;
      case 'bags':
        return l.categoryBags;
      case 'jewelry':
        return l.categoryJewelry;
      case 'sunglasses':
        return l.categorySunglasses;
      case 'belts':
        return l.categoryBelts;
      case 'wallets':
        return l.categoryWallets;
      default:
        return slug;
    }
  }

  IconData _categoryIcon(String slug) {
    switch (slug) {
      case 'men':
        return Icons.man_outlined;
      case 'women':
        return Icons.woman_outlined;
      case 'kids':
        return Icons.child_care_outlined;
      case 'watches':
        return Icons.watch_outlined;
      case 'bags':
        return Icons.shopping_bag_outlined;
      case 'jewelry':
        return Icons.diamond_outlined;
      case 'sunglasses':
        return Icons.visibility_outlined;
      case 'belts':
        return Icons.checkroom_outlined;
      case 'wallets':
        return Icons.account_balance_wallet_outlined;
      default:
        return Icons.category_outlined;
    }
  }

  List<String> _categoryAliases(String slug) {
    switch (slug) {
      case 'men':
        return ['men', "men's clothing", 'mens clothing'];
      case 'women':
        return ['women', "women's clothing", 'womens clothing'];
      case 'kids':
        return ['kids', 'children', "children's clothing"];
      case 'watches':
        return ['watches', 'watch'];
      case 'bags':
        return ['bags', 'bag'];
      case 'jewelry':
        return ['jewelry', 'jewellery'];
      case 'sunglasses':
        return ['sunglasses', 'sunglass'];
      case 'belts':
        return ['belts', 'belt'];
      case 'wallets':
        return ['wallets', 'wallet'];
      default:
        return [slug];
    }
  }

  int _productCount(
    List<ProductModel> products,
    String slug,
  ) {
    final aliases = _categoryAliases(slug);

    return products.where((product) {
      final productCategory = _normalizeCategory(product.category);

      return aliases.any(
        (alias) => _normalizeCategory(alias) == productCategory,
      );
    }).length;
  }

  Widget _buildSectionHeader({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    final colors = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 14, top: 12),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Icon(
              icon,
              color: primaryColor,
              size: 25,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
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

  Widget _buildCategoryCard(
    CategoryModel category,
    List<ProductModel> products,
  ) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;

    final name = _localizedCategoryName(category.slug);
    final count = _productCount(products, category.slug);

    return Material(
      color: theme.cardColor,
      borderRadius: BorderRadius.circular(20),
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => CategoryProductsScreen(
                categorySlug: category.slug,
                categoryName: name,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: colors.outlineVariant.withValues(alpha: 0.5),
            ),
          ),
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  _categoryIcon(category.slug),
                  color: primaryColor,
                  size: 25,
                ),
              ),
              const Spacer(),
              Text(
                name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      l.categoryItemsCount(count),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colors.onSurfaceVariant,
                      ),
                    ),
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 13,
                    color: primaryColor,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryGrid(
    List<CategoryModel> categories,
    List<ProductModel> products,
  ) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 220,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
        mainAxisExtent: 145,
      ),
      itemBuilder: (context, index) {
        return _buildCategoryCard(
          categories[index],
          products,
        );
      },
    );
  }

  Widget _buildBody(
    List<ProductModel> products,
    bool hasStreamError,
  ) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(
          color: primaryColor,
        ),
      );
    }

    if (_errorMessage != null && _categories.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 60,
                color: Colors.grey,
              ),
              const SizedBox(height: 16),
              Text(
                l.couldNotLoadCategories,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                _errorMessage!,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _loadCategories,
                icon: const Icon(Icons.refresh),
                label: Text(l.tryAgain),
              ),
            ],
          ),
        ),
      );
    }

    final clothing = _categories
        .where(
          (category) => ['men', 'women', 'kids'].contains(category.slug),
        )
        .toList();

    final accessories = _categories
        .where(
          (category) => [
            'watches',
            'bags',
            'jewelry',
            'sunglasses',
            'belts',
            'wallets',
          ].contains(category.slug),
        )
        .toList();

    if (_categories.isEmpty) {
      return Center(
        child: Text(l.noCategoriesAvailable),
      );
    }

    return RefreshIndicator(
      onRefresh: _loadCategories,
      color: primaryColor,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(20, 12, 20, 30),
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [
                  Color(0xFF385CF2),
                  Color(0xFF7189FF),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(23),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l.categoriesTitle,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 23,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        l.exploreProducts,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.shopping_bag_outlined,
                  color: Colors.white,
                  size: 55,
                ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          _buildSectionHeader(
            title: l.categoryClothing,
            subtitle: l.categoryClothingSubtitle,
            icon: Icons.checkroom_outlined,
          ),
          _buildCategoryGrid(clothing, products),
          const SizedBox(height: 20),
          _buildSectionHeader(
            title: l.categoryAccessories,
            subtitle: l.categoryAccessoriesSubtitle,
            icon: Icons.watch_outlined,
          ),
          _buildCategoryGrid(accessories, products),
          if (hasStreamError)
            Padding(
              padding: const EdgeInsets.only(top: 16),
              child: Text(
                l.failedToLoadStoreProducts,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          l.categoriesTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<ProductModel>>(
        stream: _storeProductsStream,
        builder: (context, snapshot) {
          return _buildBody(
            snapshot.data ?? [],
            snapshot.hasError,
          );
        },
      ),
    );
  }
}