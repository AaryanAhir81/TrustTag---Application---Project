import 'package:flutter/material.dart';
import 'package:trusttag_admin/models/admin_profile_model.dart';
import 'package:trusttag_admin/resource/resource.dart';

class AdminProfileDialog extends StatefulWidget {
  final AdminProfileModel adminProfile;

  const AdminProfileDialog({
    super.key,
    required this.adminProfile,
  });

  @override
  State<AdminProfileDialog> createState() => _AdminProfileDialogState();
}

class _AdminProfileDialogState extends State<AdminProfileDialog> {
  late AdminProfileModel _profile;

  @override
  void initState() {
    super.initState();
    _profile = widget.adminProfile;
  }

  void _showEditProfileModal() {
    final nameController = TextEditingController(text: _profile.name);
    final emailController = TextEditingController(text: _profile.email);
    final phoneController = TextEditingController(text: _profile.phone);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Profile'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 380,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(labelText: 'Full Name'),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: 'Email'),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    controller: phoneController,
                    decoration: const InputDecoration(labelText: 'Phone'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  _profile.name = nameController.text;
                  _profile.email = emailController.text;
                  _profile.phone = phoneController.text;
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Profile updated successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: const Text('Save Changes'),
            ),
          ],
        );
      },
    );
  }

  void _showChangePasswordModal() {
    final currentPasswordController = TextEditingController();
    final newPasswordController = TextEditingController();
    final confirmPasswordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: SingleChildScrollView(
            child: SizedBox(
              width: 380,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: currentPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'Current Password'),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    controller: newPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: 'New Password'),
                  ),
                  const SizedBox(height: AppSizes.sm),
                  TextField(
                    controller: confirmPasswordController,
                    obscureText: true,
                    decoration:
                        const InputDecoration(labelText: 'Confirm New Password'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
              ),
              onPressed: () {
                if (newPasswordController.text !=
                    confirmPasswordController.text) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Passwords do not match!'),
                      backgroundColor: AppColors.error,
                    ),
                  );
                  return;
                }
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Password changed successfully!'),
                    backgroundColor: AppColors.success,
                  ),
                );
              },
              child: const Text('Update Password'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      child: Container(
        width: 440,
        padding: const EdgeInsets.all(AppSizes.xl),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSizes.radiusLg),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.08),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Large Avatar Icon
            Container(
              width: 80,
              height: 80,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFFDBEAFE), // Light blue background
              ),
              child: const Center(
                child: Icon(
                  Icons.person,
                  size: 48,
                  color: Color(0xFF1E293B), // Dark navy user icon
                ),
              ),
            ),
            const SizedBox(height: AppSizes.md),

            // Name
            Text(
              _profile.name,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 2),

            // Role Subtitle
            Text(
              _profile.role,
              style: const TextStyle(
                fontSize: 13,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w400,
              ),
            ),
            const SizedBox(height: AppSizes.lg),

            // Divider Line
            const Divider(height: 1, color: AppColors.border),
            const SizedBox(height: AppSizes.lg),

            // Info Items List
            _buildInfoItem(
              icon: Icons.email_outlined,
              label: 'Email',
              value: _profile.email,
            ),
            const SizedBox(height: AppSizes.md + 2),
            _buildInfoItem(
              icon: Icons.phone_outlined,
              label: 'Phone',
              value: _profile.phone,
            ),
            const SizedBox(height: AppSizes.md + 2),
            _buildInfoItem(
              icon: Icons.verified_user_outlined,
              label: 'Role',
              value: _profile.role,
            ),
            const SizedBox(height: AppSizes.xl),

            // Action Buttons Row
            Row(
              children: [
                // Edit Profile Button (Outline Blue)
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: OutlinedButton.icon(
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                        backgroundColor: AppColors.surface,
                        side: const BorderSide(color: AppColors.primary, width: 1.5),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                      ),
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text(
                        'Edit Profile',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _showEditProfileModal,
                    ),
                  ),
                ),
                const SizedBox(width: AppSizes.md),

                // Change Password Button (Solid Blue)
                Expanded(
                  child: SizedBox(
                    height: 44,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppSizes.radiusMd),
                        ),
                      ),
                      icon: const Icon(Icons.lock_outline, size: 18),
                      label: const Text(
                        'Change Password',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      onPressed: _showChangePasswordModal,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        // Left Icon Box
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(
            icon,
            size: 18,
            color: const Color(0xFF64748B),
          ),
        ),
        const SizedBox(width: AppSizes.md),

        // Text Info Column
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(
                fontSize: 11,
                color: Color(0xFF94A3B8),
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 1),
            Text(
              value,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1E293B),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
