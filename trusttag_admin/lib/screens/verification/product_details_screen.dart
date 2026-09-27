import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/product_verification_model.dart';
import 'package:trusttag_admin/resource/resource.dart';

class ProductDetailsScreen extends StatelessWidget {
  final ProductVerificationModel product;
  final VoidCallback onBack;

  const ProductDetailsScreen({
    super.key,
    required this.product,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header with Back Button
        Container(
          height: AppSizes.headerHeight,
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
          decoration: const BoxDecoration(
            color: AppColors.surface,
            border: Border(
              bottom: BorderSide(color: AppColors.border, width: 1.0),
            ),
          ),
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.textPrimary),
                onPressed: onBack,
              ),
              const SizedBox(width: AppSizes.xs),
              Text(
                AppStrings.productDetailsTitle,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),

        // Body Content
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSizes.xl),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(AppSizes.xl),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Top Product Summary Header Card
                    _buildTopHeaderCard(),
                    const Divider(height: AppSizes.xxl, color: AppColors.border),

                    // Section 1: Product Information
                    _buildSectionHeader(
                      icon: Icons.info_outline,
                      title: AppStrings.productInformation,
                    ),
                    const SizedBox(height: AppSizes.md),
                    _buildInfoRow(AppStrings.labelProductName, product.productName),
                    _buildInfoRow(AppStrings.labelBrand, product.brand),
                    _buildInfoRow(AppStrings.labelModel, product.model),
                    _buildInfoRow(AppStrings.labelSerialNumber, product.serialNumber),
                    _buildInfoRow(AppStrings.labelPurchaseDate, product.purchaseDate),
                    const Divider(height: AppSizes.xxl, color: AppColors.border),

                    // Section 2: Documents
                    _buildSectionHeader(
                      icon: Icons.description_outlined,
                      title: AppStrings.documents,
                    ),
                    const SizedBox(height: AppSizes.md),
                    ...product.documents.map((doc) => _buildDocumentTile(context, doc)),
                    const Divider(height: AppSizes.xxl, color: AppColors.border),

                    // Section 3: Owner Details
                    _buildSectionHeader(
                      icon: Icons.person_outline,
                      title: AppStrings.ownerDetails,
                    ),
                    const SizedBox(height: AppSizes.md),
                    _buildInfoRow(AppStrings.labelName, product.registeredBy),
                    _buildInfoRow(AppStrings.labelEmail, product.registeredEmail),
                    _buildInfoRow(AppStrings.labelPhone, product.registeredPhone),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTopHeaderCard() {
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

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Product Thumbnail Image
        Container(
          width: 90,
          height: 90,
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
              size: 48,
              color: AppColors.primary,
            ),
          ),
        ),
        const SizedBox(width: AppSizes.lg),

        // Product Summary Metadata
        Expanded(
          child: Wrap(
            spacing: AppSizes.xl,
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
        if (isTitle && title != null)
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          )
        else if (titleKey != null && titleVal != null)
          RichText(
            text: TextSpan(
              style: const TextStyle(fontSize: 13),
              children: [
                TextSpan(
                  text: '$titleKey\n',
                  style: const TextStyle(color: AppColors.textMuted),
                ),
                TextSpan(
                  text: titleVal,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 6),
        RichText(
          text: TextSpan(
            style: const TextStyle(fontSize: 13),
            children: [
              TextSpan(
                text: '$subKey\n',
                style: const TextStyle(color: AppColors.link),
              ),
              TextSpan(
                text: subVal,
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSectionHeader({required IconData icon, required String title}) {
    return Row(
      children: [
        Icon(icon, size: 20, color: AppColors.textPrimary),
        const SizedBox(width: AppSizes.sm),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.xs + 2),
      child: SizedBox(
        width: 450,
        child: Row(
          children: [
            SizedBox(
              width: 140,
              child: Text(
                label,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.link,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Text(':', style: TextStyle(color: AppColors.link)),
            const SizedBox(width: AppSizes.lg),
            Expanded(
              child: Text(
                value,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDocumentTile(BuildContext context, VerificationDocument doc) {
    final bool isPdf = doc.type == 'pdf';

    return Container(
      margin: const EdgeInsets.only(bottom: AppSizes.md),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.md,
        vertical: AppSizes.sm + 2,
      ),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
      ),
      child: Row(
        children: [
          // Icon Container
          Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: isPdf ? const Color(0xFFFEE2E2) : const Color(0xFFDCFCE7),
              borderRadius: BorderRadius.circular(AppSizes.radiusSm),
            ),
            child: Icon(
              isPdf ? Icons.picture_as_pdf : Icons.image,
              color: isPdf ? AppColors.error : AppColors.success,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // File Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  doc.name,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  doc.subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: AppColors.textMuted,
                  ),
                ),
              ],
            ),
          ),

          // View Document Action Button
          OutlinedButton.icon(
            style: OutlinedButton.styleFrom(
              side: BorderSide.none,
              foregroundColor: AppColors.primary,
            ),
            icon: const Icon(Icons.visibility_outlined, size: 18),
            label: const Text(AppStrings.btnView),
            onPressed: () {
              _showDocumentPreviewDialog(context, doc);
            },
          ),
        ],
      ),
    );
  }

  void _showDocumentPreviewDialog(
      BuildContext context, VerificationDocument doc) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(doc.name),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 320,
                height: 220,
                decoration: BoxDecoration(
                  color: AppColors.background,
                  borderRadius: BorderRadius.circular(AppSizes.radiusMd),
                  border: Border.all(color: AppColors.border),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        doc.type == 'pdf'
                            ? Icons.picture_as_pdf
                            : Icons.image_outlined,
                        size: 50,
                        color: AppColors.primary,
                      ),
                      const SizedBox(height: AppSizes.sm),
                      Text(
                        'Preview for ${doc.name}',
                        style: const TextStyle(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
