import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';

enum NavItem {
  dashboard,
  verification,
  products,
  users,
  serviceHistory,
  logout,
}

class SidebarWidget extends StatelessWidget {
  final NavItem activeItem;
  final ValueChanged<NavItem> onItemSelected;

  const SidebarWidget({
    super.key,
    required this.activeItem,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: AppSizes.sidebarWidth,
      color: AppColors.sidebarBg,
      child: Column(
        children: [
          // Top Brand Header
          Container(
            height: 70,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.lg),
            alignment: Alignment.centerLeft,
            child: Row(
              children: [
                // Tag Shield Logo Icon
                Container(
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        const Icon(
                          Icons.shield_outlined,
                          color: Colors.white,
                          size: 22,
                        ),
                        Container(
                          padding: const EdgeInsets.all(1.5),
                          decoration: const BoxDecoration(
                            color: AppColors.success,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.check,
                            color: Colors.white,
                            size: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.sm + 2),
                Expanded(
                  child: RichText(
                    overflow: TextOverflow.ellipsis,
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        letterSpacing: -0.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Trust ',
                          style: TextStyle(color: Colors.white),
                        ),
                        TextSpan(
                          text: 'Tag',
                          style: TextStyle(color: AppColors.primary),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSizes.md),

          // Navigation Items List
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.md),
              children: [
                _buildNavItem(
                  item: NavItem.dashboard,
                  label: AppStrings.navDashboard,
                  icon: Icons.grid_view_rounded,
                ),
                const SizedBox(height: AppSizes.xs + 2),
                _buildNavItem(
                  item: NavItem.verification,
                  label: AppStrings.navVerification,
                  icon: Icons.verified_user_outlined,
                ),
                const SizedBox(height: AppSizes.xs + 2),
                _buildNavItem(
                  item: NavItem.products,
                  label: AppStrings.navProducts,
                  icon: Icons.inventory_2_outlined,
                ),
                const SizedBox(height: AppSizes.xs + 2),
                _buildNavItem(
                  item: NavItem.users,
                  label: AppStrings.navUsers,
                  icon: Icons.people_outline,
                ),
                const SizedBox(height: AppSizes.xs + 2),
                _buildNavItem(
                  item: NavItem.serviceHistory,
                  label: AppStrings.navServiceHistory,
                  icon: Icons.history_outlined,
                ),
              ],
            ),
          ),

          // Bottom Logout Button
          Padding(
            padding: const EdgeInsets.all(AppSizes.md),
            child: _buildNavItem(
              item: NavItem.logout,
              label: AppStrings.navLogout,
              icon: Icons.power_settings_new,
              isLogout: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem({
    required NavItem item,
    required String label,
    required IconData icon,
    bool isLogout = false,
  }) {
    final bool isActive = activeItem == item;

    Color iconColor;
    Color textColor;
    Color bgColor;

    if (isLogout) {
      iconColor = AppColors.error;
      textColor = AppColors.sidebarText;
      bgColor = Colors.transparent;
    } else if (isActive) {
      iconColor = AppColors.sidebarActiveText;
      textColor = AppColors.sidebarActiveText;
      bgColor = AppColors.sidebarActiveBg;
    } else {
      iconColor = AppColors.sidebarText;
      textColor = AppColors.sidebarText;
      bgColor = Colors.transparent;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onItemSelected(item),
        borderRadius: BorderRadius.circular(AppSizes.radiusMd),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSizes.md,
            vertical: AppSizes.sm + 4,
          ),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
          child: Row(
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: AppSizes.md),
              Expanded(
                child: Text(
                  label,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
