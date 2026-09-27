import 'package:trusttag_application/resource/resource.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final cardColor = isDark ? AppColors.darkSurface : Colors.white;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: isDark ? Colors.white : Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Licenses',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppLayout.screenPadding),
        children: [
          // TrustTag Header Card
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: cardColor,
              borderRadius: BorderRadius.circular(AppLayout.cardRadius),
              border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                Image.asset(
                  AppAssets.logo,
                  width: 60,
                  height: 60,
                  errorBuilder: (context, error, stackTrace) => const Icon(
                    Icons.verified_user_outlined,
                    color: AppColors.primaryBlue,
                    size: 60,
                  ),
                ),
                const SizedBox(height: 16),
                RichText(
                  text: TextSpan(
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    children: [
                      TextSpan(text: 'Trust ', style: TextStyle(color: isDark ? Colors.white : Colors.black)),
                      const TextSpan(text: 'Tag', style: TextStyle(color: AppColors.buttonBlue)),
                    ],
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Digital Product Passport',
                  style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: Colors.black12),
                const SizedBox(height: 16),
                const Text(
                  '© 2026 TrustTag',
                  style: TextStyle(color: Colors.grey, fontSize: 13, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 4),
                const Text(
                  'All Rights Reserved.',
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 12),
            child: Text(
              'OPEN SOURCE',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: isDark ? Colors.white60 : Colors.grey,
                letterSpacing: 1.1,
              ),
            ),
          ),
          _buildLicenseItem(context, 'Flutter', 'Google UI Framework'),
          const SizedBox(height: 12),
          _buildLicenseItem(context, 'Firebase', 'Google Backend Services'),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildLicenseItem(BuildContext context, String title, String subtitle) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(AppLayout.cardRadius - 4),
        border: Border.all(color: isDark ? Colors.white.withValues(alpha: 0.05) : Colors.black.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: const Icon(Icons.code_outlined, color: Colors.blue, size: 20),
        ),
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: isDark ? Colors.white : Colors.black87),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Icon(Icons.verified_outlined, size: 18, color: Colors.green),
      ),
    );
  }
}
