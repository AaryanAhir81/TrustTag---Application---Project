import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/product_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class ProductsScreen extends StatefulWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const ProductsScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  ProductStatus? _selectedStatusFilter;

  // Mock Products List (Backend Ready Model Structure)
  final List<ProductModel> _allProducts = [
    ProductModel(
      id: '1',
      name: 'Iphone 15 Pro',
      brand: 'Apple',
      category: 'Phone',
      serialNumber: 'X7Q2K9L3P4',
      status: ProductStatus.verified,
      ownersCount: 1,
      imageUrl: '',
    ),
    ProductModel(
      id: '2',
      name: 'Dell Latitude 7490',
      brand: 'Dell',
      category: 'Laptop',
      serialNumber: '9JLMT4C1..',
      status: ProductStatus.pending,
      ownersCount: 1,
      imageUrl: '',
    ),
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<ProductModel> get _filteredProducts {
    return _allProducts.where((product) {
      final matchesSearch = _searchQuery.isEmpty ||
          product.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.brand.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.category.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          product.serialNumber.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesFilter = _selectedStatusFilter == null ||
          product.status == _selectedStatusFilter;

      return matchesSearch && matchesFilter;
    }).toList();
  }

  void _deleteProduct(ProductModel product) {
    setState(() {
      _allProducts.removeWhere((item) => item.id == product.id);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Product "${product.name}" deleted successfully.'),
        backgroundColor: AppColors.error,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Left Sidebar Navigation
          SidebarWidget(
            activeItem: NavItem.products,
            onItemSelected: widget.onItemSelected,
          ),

          // Main Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                HeaderWidget(
                  title: 'Manage Products',
                  subtitle: 'All registered products across the platform',
                  onNotificationTap: widget.onNotificationTap,
                ),

                // Main Content
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    child: Column(
                      children: [
                        // Search Bar & Filter Row
                        Row(
                          children: [
                            // Search Field
                            Expanded(
                              child: SizedBox(
                                height: 44,
                                child: TextField(
                                  controller: _searchController,
                                  onChanged: (val) {
                                    setState(() {
                                      _searchQuery = val;
                                    });
                                  },
                                  style: AppStyles.body,
                                  decoration: InputDecoration(
                                    hintText: 'Search products...',
                                    hintStyle: const TextStyle(
                                      fontSize: 13,
                                      color: AppColors.textMuted,
                                    ),
                                    suffixIcon: const Icon(
                                      Icons.search,
                                      size: 20,
                                      color: AppColors.textMuted,
                                    ),
                                    filled: true,
                                    fillColor: AppColors.surface,
                                    contentPadding: const EdgeInsets.symmetric(
                                      horizontal: AppSizes.md,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusXl),
                                      borderSide: const BorderSide(
                                          color: AppColors.border),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          AppSizes.radiusXl),
                                      borderSide: const BorderSide(
                                          color: AppColors.primary, width: 1.5),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: AppSizes.md),

                            // Filter Button
                            SizedBox(
                              height: 44,
                              child: OutlinedButton.icon(
                                style: OutlinedButton.styleFrom(
                                  backgroundColor: AppColors.surface,
                                  foregroundColor: AppColors.textPrimary,
                                  side: const BorderSide(color: AppColors.border),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(AppSizes.radiusXl),
                                  ),
                                ),
                                icon: const Icon(Icons.filter_list_outlined,
                                    size: 18),
                                label: const Text('Filter'),
                                onPressed: _showFilterMenu,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: AppSizes.lg),

                        // Products Data Table Container
                        Container(
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius:
                                BorderRadius.circular(AppSizes.radiusLg),
                            border: Border.all(color: AppColors.border),
                          ),
                          child: Column(
                            children: [
                              // Table Header
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppSizes.lg,
                                  vertical: AppSizes.md,
                                ),
                                decoration: const BoxDecoration(
                                  color: AppColors.background,
                                  borderRadius: BorderRadius.only(
                                    topLeft:
                                        Radius.circular(AppSizes.radiusLg),
                                    topRight:
                                        Radius.circular(AppSizes.radiusLg),
                                  ),
                                ),
                                child: const Row(
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        'PRODUCT',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'CATEGORY',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'SERIAL',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'STATUS',
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: Text(
                                        'OWNERS',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'ACTION',
                                        textAlign: TextAlign.end,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textSecondary,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Divider(height: 1, color: AppColors.border),

                              // Table Rows List
                              if (_filteredProducts.isEmpty)
                                const Padding(
                                  padding: EdgeInsets.all(AppSizes.xxl),
                                  child: Text(
                                    'No products match your search.',
                                    style: TextStyle(color: AppColors.textMuted),
                                  ),
                                )
                              else
                                ..._filteredProducts.map((product) {
                                  return Column(
                                    children: [
                                      _buildProductRow(product),
                                      const Divider(
                                          height: 1, color: AppColors.border),
                                    ],
                                  );
                                }),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductRow(ProductModel product) {
    Color badgeBg;
    Color badgeText;
    String badgeLabel;

    switch (product.status) {
      case ProductStatus.verified:
        badgeBg = AppColors.approvedBg;
        badgeText = AppColors.approvedText;
        badgeLabel = 'Verified';
        break;
      case ProductStatus.pending:
        badgeBg = AppColors.pendingBg;
        badgeText = AppColors.pendingText;
        badgeLabel = 'Pending';
        break;
      case ProductStatus.rejected:
        badgeBg = AppColors.rejectedBg;
        badgeText = AppColors.rejectedText;
        badgeLabel = 'Rejected';
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.lg,
        vertical: AppSizes.md + 2,
      ),
      child: Row(
        children: [
          // Product Info (Image + Title + Subtitle)
          Expanded(
            flex: 3,
            child: Row(
              children: [
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: AppColors.background,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Icon(
                    product.category.toLowerCase() == 'laptop'
                        ? Icons.laptop_mac
                        : Icons.phone_iphone,
                    size: 22,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: AppSizes.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        product.brand,
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.textMuted,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Category
          Expanded(
            flex: 2,
            child: Text(
              product.category,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Serial
          Expanded(
            flex: 2,
            child: Text(
              product.serialNumber,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Status Badge Pill
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSizes.md,
                  vertical: AppSizes.xs,
                ),
                decoration: BoxDecoration(
                  color: badgeBg,
                  borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                ),
                child: Text(
                  badgeLabel,
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: badgeText,
                  ),
                ),
              ),
            ),
          ),

          // Owners Count
          Expanded(
            flex: 1,
            child: Text(
              '${product.ownersCount}',
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
          ),

          // Action Column (View & Delete)
          Expanded(
            flex: 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // View Details Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: AppColors.primaryLight,
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.visibility_outlined,
                      size: 16,
                      color: AppColors.primary,
                    ),
                    onPressed: () => _showProductDetailsDialog(product),
                  ),
                ),
                const SizedBox(width: AppSizes.xs),

                // Delete Button
                Container(
                  width: 32,
                  height: 32,
                  decoration: const BoxDecoration(
                    color: Color(0xFFFEE2E2),
                    shape: BoxShape.circle,
                  ),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    icon: const Icon(
                      Icons.delete_outline,
                      size: 16,
                      color: AppColors.error,
                    ),
                    onPressed: () => _confirmDeleteProductDialog(product),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showFilterMenu() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(AppSizes.lg),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Filter Products by Status',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: AppSizes.md),
              ListTile(
                title: const Text('All Products'),
                trailing: _selectedStatusFilter == null
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedStatusFilter = null);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Verified'),
                trailing: _selectedStatusFilter == ProductStatus.verified
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedStatusFilter = ProductStatus.verified);
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: const Text('Pending'),
                trailing: _selectedStatusFilter == ProductStatus.pending
                    ? const Icon(Icons.check, color: AppColors.primary)
                    : null,
                onTap: () {
                  setState(() => _selectedStatusFilter = ProductStatus.pending);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showProductDetailsDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(product.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Brand: ${product.brand}'),
              const SizedBox(height: AppSizes.xs),
              Text('Category: ${product.category}'),
              const SizedBox(height: AppSizes.xs),
              Text('Serial Number: ${product.serialNumber}'),
              const SizedBox(height: AppSizes.xs),
              Text('Owners: ${product.ownersCount}'),
              const SizedBox(height: AppSizes.xs),
              Text('Status: ${product.status.name.toUpperCase()}'),
            ],
          ),
          actions: [
            OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.error,
                side: const BorderSide(color: AppColors.border),
              ),
              icon: const Icon(Icons.delete_outline, size: 16),
              label: const Text('Delete'),
              onPressed: () {
                Navigator.of(context).pop();
                _confirmDeleteProductDialog(product);
              },
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  void _confirmDeleteProductDialog(ProductModel product) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product?'),
          content: Text(
            'Are you sure you want to delete "${product.name}" (Serial: ${product.serialNumber})? This action cannot be undone.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _deleteProduct(product);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
