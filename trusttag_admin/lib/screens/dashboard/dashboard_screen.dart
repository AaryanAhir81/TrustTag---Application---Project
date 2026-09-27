import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/header_widget.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

class DashboardScreen extends StatelessWidget {
  final ValueChanged<NavItem> onItemSelected;
  final VoidCallback? onNotificationTap;

  const DashboardScreen({
    super.key,
    required this.onItemSelected,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Row(
        children: [
          // Left Navigation Sidebar
          SidebarWidget(
            activeItem: NavItem.dashboard,
            onItemSelected: onItemSelected,
          ),

          // Main Dashboard Content Area
          Expanded(
            child: Column(
              children: [
                // Top Header Bar
                HeaderWidget(
                  title: AppStrings.dashboardTitle,
                  subtitle: AppStrings.welcomeBackAdmin,
                  onNotificationTap: onNotificationTap,
                ),

                // Scrollable Dashboard Body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSizes.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // 1. Metric Stat Cards Grid
                        LayoutBuilder(
                          builder: (context, constraints) {
                            final isWide = constraints.maxWidth > 900;
                            return GridView.count(
                              crossAxisCount: isWide ? 4 : 2,
                              crossAxisSpacing: AppSizes.lg,
                              mainAxisSpacing: AppSizes.lg,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              childAspectRatio: isWide ? 2.0 : 1.4,
                              children: [
                                _StatCard(
                                  icon: Icons.groups_rounded,
                                  iconBgColor: AppColors.statUsersBg,
                                  value: '2,847',
                                  label: AppStrings.statTotalUsers,
                                  onTap: () => onItemSelected(NavItem.users),
                                ),
                                _StatCard(
                                  icon: Icons.inventory_2,
                                  iconBgColor: AppColors.statProductsBg,
                                  value: '8,341',
                                  label: AppStrings.statTotalProducts,
                                  onTap: () => onItemSelected(NavItem.products),
                                ),
                                _StatCard(
                                  icon: Icons.access_time_filled,
                                  iconBgColor: AppColors.statPendingBg,
                                  value: '47',
                                  label: AppStrings.statPendingReview,
                                  onTap: () =>
                                      onItemSelected(NavItem.verification),
                                ),
                                _StatCard(
                                  icon: Icons.verified,
                                  iconBgColor: AppColors.statVerifiedBg,
                                  value: '100',
                                  label: AppStrings.statVerified,
                                  onTap: () =>
                                      onItemSelected(NavItem.verification),
                                ),
                              ],
                            );
                          },
                        ),
                        const SizedBox(height: AppSizes.xl),

                        // 2. Recent Verification Requests Card & Table
                        Card(
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.lg),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Expanded(
                                      child: Text(
                                        AppStrings.recentRequestsTitle,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                          color: AppColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () =>
                                          onItemSelected(NavItem.verification),
                                      child: const Text('View All'),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: AppSizes.md),

                                // Data Table Container
                                Container(
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: AppColors.border,
                                      width: 1.0,
                                    ),
                                    borderRadius: BorderRadius.circular(
                                      AppSizes.radiusMd,
                                    ),
                                  ),
                                  child: Column(
                                    children: [
                                      // Table Header Row
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: AppSizes.lg,
                                          vertical: AppSizes.md,
                                        ),
                                        decoration: const BoxDecoration(
                                          color: AppColors.background,
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(
                                                AppSizes.radiusMd),
                                            topRight: Radius.circular(
                                                AppSizes.radiusMd),
                                          ),
                                        ),
                                        child: const Row(
                                          children: [
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                AppStrings.colProduct,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 2,
                                              child: Text(
                                                AppStrings.colOwner,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                            Expanded(
                                              flex: 1,
                                              child: Text(
                                                AppStrings.colStatus,
                                                style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13,
                                                  color: AppColors.textPrimary,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Divider(
                                          height: 1, color: AppColors.border),

                                      // Table Row 1
                                      _TableRowWidget(
                                        product: 'Iphone 15 Pro',
                                        owner: 'Aaryan Bharvadiya',
                                        status: 'Verified',
                                        isVerified: true,
                                        onTap: () => onItemSelected(
                                            NavItem.verification),
                                      ),
                                      const Divider(
                                          height: 1, color: AppColors.border),

                                      // Table Row 2
                                      _TableRowWidget(
                                        product: 'Dell Latitude 7490',
                                        owner: 'Aaryan Bharvadiya',
                                        status: 'Pending',
                                        isVerified: false,
                                        onTap: () => onItemSelected(
                                            NavItem.verification),
                                      ),
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Single Metric Stat Card Widget
class _StatCard extends StatelessWidget {
  final IconData icon;
  final Color iconBgColor;
  final String value;
  final String label;
  final VoidCallback? onTap;

  const _StatCard({
    required this.icon,
    required this.iconBgColor,
    required this.value,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppSizes.radiusLg),
        child: Padding(
          padding: const EdgeInsets.all(AppSizes.md),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  color: Colors.white,
                  size: 20,
                ),
              ),
              const SizedBox(height: AppSizes.xs),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 11,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Table Row Widget
class _TableRowWidget extends StatelessWidget {
  final String product;
  final String owner;
  final String status;
  final bool isVerified;
  final VoidCallback? onTap;

  const _TableRowWidget({
    required this.product,
    required this.owner,
    required this.status,
    required this.isVerified,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.lg,
          vertical: AppSizes.md + 2,
        ),
        child: Row(
          children: [
            Expanded(
              flex: 2,
              child: Text(
                product,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textPrimary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Text(
                owner,
                style: const TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  status,
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: isVerified ? AppColors.success : AppColors.warning,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
