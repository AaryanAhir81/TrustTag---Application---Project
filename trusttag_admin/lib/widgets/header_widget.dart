import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/admin_profile_model.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/screens/profile/admin_profile_dialog.dart';

class HeaderWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback? onNotificationTap;

  const HeaderWidget({
    super.key,
    required this.title,
    required this.subtitle,
    this.onNotificationTap,
  });

  void _openAdminProfileDialog(BuildContext context) {
    final mockProfile = AdminProfileModel(
      name: 'Aaryan Ahir',
      email: 'admin@gmail.com',
      phone: '+91 XXXXX XXXXX',
      role: 'Administrator',
    );

    showDialog(
      context: context,
      builder: (context) {
        return AdminProfileDialog(
          adminProfile: mockProfile,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.headerHeight,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.border, width: 1.0),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Left Page Title & Subtitle
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textMuted,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSizes.md),

          // Right Notification & Profile Avatar
          Row(
            children: [
              // Notification Bell Button
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColors.background,
                  border: Border.all(color: AppColors.border, width: 1.0),
                ),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  icon: const Icon(
                    Icons.notifications_none_outlined,
                    size: 20,
                    color: AppColors.textSecondary,
                  ),
                  onPressed: () {
                    if (onNotificationTap != null) {
                      onNotificationTap!();
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Opening Notifications...'),
                          duration: Duration(seconds: 1),
                        ),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: AppSizes.md),

              // Interactive Admin Avatar Button
              InkWell(
                onTap: () => _openAdminProfileDialog(context),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primaryLight,
                    border: Border.all(color: AppColors.primary, width: 1.5),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.person,
                      size: 22,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
