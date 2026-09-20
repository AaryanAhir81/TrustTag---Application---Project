import 'package:trusttag_application/src/core/resources/resources.dart';

class LicensesScreen extends StatelessWidget {
  const LicensesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

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
        padding: const EdgeInsets.all(20),
        children: [
          _buildLicenseItem(
            context,
            'Flutter',
            'BSD 3-Clause License',
          ),
          _buildLicenseItem(
            context,
            'Cupertino Icons',
            'MIT License',
          ),
          _buildLicenseItem(
            context,
            'Flutter Launcher Icons',
            'MIT License',
          ),
          _buildLicenseItem(
            context,
            'Flutter Native Splash',
            'MIT License',
          ),
          const SizedBox(height: 20),
          const Center(
            child: Text(
              'TrustTag Application Prototype v1.0.0\nCreated for College Project',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey, fontSize: 12, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLicenseItem(BuildContext context, String title, String subtitle) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: isDark ? AppColors.darkSurface : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black87),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 12),
        ),
        trailing: const Icon(Icons.description_outlined, size: 20, color: Colors.blue),
        onTap: () {
          // In a real app, this would show the full license text
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Viewing full license for $title')),
          );
        },
      ),
    );
  }
}
