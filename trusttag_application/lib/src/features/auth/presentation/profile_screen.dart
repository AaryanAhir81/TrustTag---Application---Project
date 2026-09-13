import 'package:flutter/material.dart';
import 'package:trusttag_application/src/features/auth/presentation/login_screen.dart';
import 'package:trusttag_application/src/features/auth/presentation/edit_profile_screen.dart';
import 'package:trusttag_application/src/features/auth/presentation/settings_screen.dart';
import 'package:trusttag_application/src/features/services/presentation/alerts_screen.dart';
import 'package:trusttag_application/src/features/services/presentation/help_support_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          'Profile',
          style: TextStyle(color: isDark ? Colors.white : Colors.black, fontWeight: FontWeight.bold, fontSize: 24),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: isDark ? Colors.white : Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsScreen()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // Profile Header with Edit
            Center(
              child: Stack(
                children: [
                  Container(
                    width: 110,
                    height: 110,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: isDark ? Colors.white10 : Colors.white, width: 4),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 12,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: ClipOval(
                      child: Image.asset(
                        'assets/images/profile.png',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: isDark ? Colors.white10 : Colors.blue.shade50,
                          child: Icon(Icons.person, size: 60, color: isDark ? Colors.white70 : Colors.blue),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: const BoxDecoration(
                          color: Color(0xFF525CFF),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.edit, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Aaryan Bharvadiya',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black),
            ),
            const SizedBox(height: 6),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              decoration: BoxDecoration(
                color: Colors.green.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  Icon(Icons.verified, color: Colors.green, size: 14),
                  SizedBox(width: 4),
                  Text(
                    'ID Verified',
                    style: TextStyle(color: Colors.green, fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            
            // Role Badge
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.blue.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: isDark ? Colors.white10 : Colors.blue.withValues(alpha: 0.1)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shield_outlined, color: isDark ? Colors.white70 : Colors.blue, size: 18),
                  const SizedBox(width: 8),
                  Text(
                    'Standard Account',
                    style: TextStyle(color: isDark ? Colors.white70 : Colors.blue, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Quick Stats
            Row(
              children: [
                _buildStatItem(context, '12', 'Products'),
                const SizedBox(width: 12),
                _buildStatItem(context, '5', 'Transfers'),
                const SizedBox(width: 12),
                _buildStatItem(context, '9', 'Verified'),
              ],
            ),
            const SizedBox(height: 28),

            // Account Sections
            _buildSectionHeader('ACCOUNT SECURITY'),
            _buildActionItem(context, Icons.lock_reset_outlined, 'Two-Factor Auth', sub: 'Highly Recommended'),
            
            const SizedBox(height: 20),
            _buildSectionHeader('PREFERENCES'),
            _buildActionItem(
              context,
              Icons.person_outline, 
              'Personal Details',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const EditProfileScreen()),
                );
              },
            ),
            _buildActionItem(
              context,
              Icons.notifications_none_outlined, 
              'Notifications',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const AlertsScreen()),
                );
              },
            ),
            _buildActionItem(
              context,
              Icons.help_outline, 
              'Help & Support',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
                );
              },
            ),
            
            const SizedBox(height: 20),
            _buildActionItem(
              context,
              Icons.logout, 
              'Logout', 
              color: Colors.red, 
              isLast: true,
              onTap: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(BuildContext context, String count, String label) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Text(count, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: isDark ? Colors.white : const Color(0xFF1A237E))),
            const SizedBox(height: 4),
            Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(left: 4, bottom: 12),
        child: Text(
          title,
          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
        ),
      ),
    );
  }

  Widget _buildActionItem(BuildContext context, IconData icon, String title, {String? sub, Widget? trailing, Color? color, bool isLast = false, VoidCallback? onTap}) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final defaultTitleColor = isDark ? Colors.white : Colors.black87;
    
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1E1E1E) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color == Colors.red ? Colors.red.withValues(alpha: 0.1) : (isDark ? Colors.white.withValues(alpha: 0.05) : Colors.blue.withValues(alpha: 0.05)),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color ?? (isDark ? Colors.white70 : Colors.blue), size: 20),
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: color ?? defaultTitleColor)),
        subtitle: sub != null ? Text(sub, style: const TextStyle(fontSize: 12, color: Colors.orange, fontWeight: FontWeight.w500)) : null,
        trailing: trailing ?? const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        onTap: onTap,
      ),
    );
  }
}
