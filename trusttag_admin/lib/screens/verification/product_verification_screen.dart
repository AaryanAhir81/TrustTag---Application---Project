import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/product_verification_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/screens/verification/product_details_screen.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class ProductVerificationScreen extends StatefulWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const ProductVerificationScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  State<ProductVerificationScreen> createState() =>
      _ProductVerificationScreenState();
}

class _ProductVerificationScreenState
    extends State<ProductVerificationScreen> {
  ProductVerificationModel? _selectedProductForDetails;

  // Mock Products List (Backend Ready Model Structure)
  final List<ProductVerificationModel> _products = [
    ProductVerificationModel(
      id: '1',
      productName: 'Iphone 15 Pro',
      brand: 'Apple',
      model: 'A3102',
      serialNumber: 'X7Q2K9L3P4',
      productId: 'TT-2025-10001',
      registeredBy: 'Aaryan Bharvadiya',
      registeredEmail: 'aaryanahir1010@gmail.com',
      registeredPhone: '+91 9510842042',
      registeredDate: '18 Jul 2026',
      purchaseDate: '18 Jul 2025',
      warranty: '1 year',
      category: 'Phone',
      imageUrl: '',
      status: VerificationStatus.pending,
      documents: const [
        VerificationDocument(
          id: 'doc1',
          name: 'Invoice.pdf',
          subtitle: 'Purchase Invoice',
          type: 'pdf',
          url: '',
        ),
        VerificationDocument(
          id: 'doc2',
          name: 'Warranty.pdf',
          subtitle: 'Warranty Card',
          type: 'pdf',
          url: '',
        ),
        VerificationDocument(
          id: 'doc3',
          name: 'Product Image 1.jpg',
          subtitle: 'Product Image',
          type: 'image',
          url: '',
        ),
        VerificationDocument(
          id: 'doc4',
          name: 'Product Image 2.jpg',
          subtitle: 'Product Image',
          type: 'image',
          url: '',
        ),
      ],
    ),
    ProductVerificationModel(
      id: '2',
      productName: 'Dell Latitude 7490',
      brand: 'Dell',
      model: 'Latitude 7490',
      serialNumber: 'DL-984321',
      productId: 'TT-2025-10002',
      registeredBy: 'Aaryan Bharvadiya',
      registeredEmail: 'aaryanahir1010@gmail.com',
      registeredPhone: '+91 9510842042',
      registeredDate: '19 Jul 2026',
      purchaseDate: '19 Jul 2025',
      warranty: '0 year',
      category: 'Laptop',
      imageUrl: '',
      status: VerificationStatus.pending,
      documents: const [
        VerificationDocument(
          id: 'doc5',
          name: 'Invoice.pdf',
          subtitle: 'Purchase Invoice',
          type: 'pdf',
          url: '',
        ),
        VerificationDocument(
          id: 'doc6',
          name: 'Warranty.pdf',
          subtitle: 'Warranty Card',
          type: 'pdf',
          url: '',
        ),
      ],
    ),
  ];

  void _updateStatus(ProductVerificationModel product, VerificationStatus newStatus) {
    setState(() {
      product.status = newStatus;
    });

    final String message = newStatus == VerificationStatus.approved
        ? '${product.productName} has been Approved!'
        : '${product.productName} has been Rejected!';

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: newStatus == VerificationStatus.approved
            ? AppColors.success
            : AppColors.error,
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
            activeItem: NavItem.verification,
            onItemSelected: widget.onItemSelected,
          ),

          // Main Area
          Expanded(
            child: _selectedProductForDetails != null
                ? ProductDetailsScreen(
                    product: _selectedProductForDetails!,
                    onBack: () {
                      setState(() {
                        _selectedProductForDetails = null;
                      });
                    },
                  )
                : Column(
                    children: [
                      // Top Header Bar
                      HeaderWidget(
                        title: AppStrings.productVerificationTitle,
                        subtitle: AppStrings.productVerificationSubtitle,
                        onNotificationTap: widget.onNotificationTap,
                      ),

                      // Verification Cards List
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.all(AppSizes.xl),
                          itemCount: _products.length,
                          itemBuilder: (context, index) {
                            final product = _products[index];
                            return _buildProductCard(product);
                          },
                        ),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductCard(ProductVerificationModel product) {
    Color badgeBg;
    Color badgeText;

    switch (product.status) {
      case VerificationStatus.approved:
        badgeBg = AppColors.approvedBg;
        badgeText = AppColors.approvedText;
        break;
      case VerificationStatus.rejected:
        badgeBg = AppColors.rejectedBg;
        badgeText = AppColors.rejectedText;
        break;
      case VerificationStatus.pending:
        badgeBg = AppColors.pendingBg;
        badgeText = AppColors.pendingText;
        break;
    }

    return Card(
      margin: const EdgeInsets.only(bottom: AppSizes.xl),
      child: Padding(
        padding: const EdgeInsets.all(AppSizes.xl),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Row 1: Image, Summary Details & Status Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image Thumbnail
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    color: AppColors.background,
                    border: Border.all(color: AppColors.border),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppSizes.radiusLg),
                    child: Icon(
                      product.category.toLowerCase() == 'laptop'
                          ? Icons.laptop_mac
                          : Icons.phone_iphone,
                      size: 52,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.xl),

                // Details Columns
                Expanded(
                  child: Wrap(
                    spacing: AppSizes.xxl,
                    runSpacing: AppSizes.md,
                    children: [
                      _buildMetaCol(
                        title: product.productName,
                        isTitle: true,
                        subKey: AppStrings.labelRegisteredBy,
                        subVal: product.registeredBy,
                      ),
                      _buildMetaCol(
                        titleKey: AppStrings.labelProductID,
                        titleVal: product.productId,
                        subKey: AppStrings.labelRegisteredOn,
                        subVal: product.registeredDate,
                      ),
                      _buildMetaCol(
                        titleKey: AppStrings.labelWarranty,
                        titleVal: product.warranty,
                        subKey: AppStrings.labelCategory,
                        subVal: product.category,
                      ),
                    ],
                  ),
                ),

                // Status Badge Pill
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSizes.md,
                    vertical: AppSizes.xs + 2,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBg,
                    borderRadius: BorderRadius.circular(AppSizes.radiusXl),
                  ),
                  child: Text(
                    product.status.label,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: badgeText,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSizes.xl),

            // Action Buttons / Status Banners Section
            _buildActionSection(product),
          ],
        ),
      ),
    );
  }

  Widget _buildMetaCol({
    String? title,
    bool isTitle = false,
    String? titleKey,
    String? titleVal,
    required String subKey,
    required String subVal,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (isTitle && title != null) ...[
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            'Serial :',
            style: TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
        ] else if (titleKey != null && titleVal != null) ...[
          Text(
            titleKey,
            style: const TextStyle(fontSize: 12, color: AppColors.textMuted),
          ),
          const SizedBox(height: 2),
          Text(
            titleVal,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
        const SizedBox(height: AppSizes.sm),
        Text(
          subKey,
          style: const TextStyle(fontSize: 12, color: AppColors.link),
        ),
        const SizedBox(height: 2),
        Text(
          subVal,
          style: const TextStyle(
            fontSize: 13,
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _buildActionSection(ProductVerificationModel product) {
    if (product.status == VerificationStatus.pending) {
      // Pending State: 3 Action Buttons (Reject | View Details | Approve)
      return Row(
        children: [
          // Reject Button
          Expanded(
            child: SizedBox(
              height: AppSizes.buttonHeight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.rejectedText,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                icon: const Icon(Icons.cancel_outlined, size: 18),
                label: const Text(AppStrings.btnReject),
                onPressed: () =>
                    _updateStatus(product, VerificationStatus.rejected),
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // View Details Button
          Expanded(
            child: SizedBox(
              height: AppSizes.buttonHeight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                icon: const Icon(Icons.visibility_outlined, size: 18),
                label: const Text(AppStrings.btnViewDetails),
                onPressed: () {
                  setState(() {
                    _selectedProductForDetails = product;
                  });
                },
              ),
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // Approve Button
          Expanded(
            child: SizedBox(
              height: AppSizes.buttonHeight,
              child: OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.approvedText,
                  side: const BorderSide(color: AppColors.border),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  ),
                ),
                icon: const Icon(Icons.check_circle_outline, size: 18),
                label: const Text(AppStrings.btnApprove),
                onPressed: () =>
                    _updateStatus(product, VerificationStatus.approved),
              ),
            ),
          ),
        ],
      );
    } else if (product.status == VerificationStatus.approved) {
      // Approved State: Centered View Details Button + Green Approved Banner (Image 3)
      return Column(
        children: [
          SizedBox(
            width: 280,
            height: AppSizes.buttonHeight,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
              icon: const Icon(Icons.visibility_outlined, size: 18),
              label: const Text(AppStrings.btnViewDetails),
              onPressed: () {
                setState(() {
                  _selectedProductForDetails = product;
                });
              },
            ),
          ),
          const SizedBox(height: AppSizes.md),

          // Green Approved Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm + 4),
            decoration: BoxDecoration(
              color: AppColors.approvedBannerBg,
              border: Border.all(color: AppColors.approvedBg),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle_outline,
                    color: AppColors.approvedText, size: 20),
                SizedBox(width: AppSizes.sm),
                Text(
                  'Approved',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.approvedText,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else {
      // Rejected State: Centered View Details Button + Red Rejected Banner (Image 4)
      return Column(
        children: [
          SizedBox(
            width: 280,
            height: AppSizes.buttonHeight,
            child: OutlinedButton.icon(
              style: OutlinedButton.styleFrom(
                foregroundColor: AppColors.primary,
                side: const BorderSide(color: AppColors.border),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                ),
              ),
              icon: const Icon(Icons.visibility_outlined, size: 18),
              label: const Text(AppStrings.btnViewDetails),
              onPressed: () {
                setState(() {
                  _selectedProductForDetails = product;
                });
              },
            ),
          ),
          const SizedBox(height: AppSizes.md),

          // Red Rejected Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: AppSizes.sm + 4),
            decoration: BoxDecoration(
              color: AppColors.rejectedBannerBg,
              border: Border.all(color: AppColors.rejectedBg),
              borderRadius: BorderRadius.circular(AppSizes.radiusMd),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.cancel_outlined,
                    color: AppColors.rejectedText, size: 20),
                SizedBox(width: AppSizes.sm),
                Text(
                  'Reject',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.rejectedText,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }
  }
}
