import 'package:trusttag_application/src/core/resources/resources.dart';
import 'package:trusttag_application/src/features/auth/presentation/change_password_screen.dart';
import 'package:trusttag_application/src/features/auth/presentation/licenses_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  late bool _isDarkMode;

  @override
  void initState() {
    super.initState();
    _isDarkMode = AppTheme.themeNotifier.value == ThemeMode.dark;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).iconTheme.color),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Settings',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionHeader('ACCOUNT & SECURITY'),
            _buildSettingCard([
              _buildSettingItem(
                Icons.lock_outline,
                'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ChangePasswordScreen()),
                  );
                },
              ),
            ]),
            
            const SizedBox(height: 24),
            _buildSectionHeader('APP PREFERENCES'),
            _buildSettingCard([
              _buildSwitchItem(Icons.dark_mode_outlined, 'Dark Mode', _isDarkMode, (v) {
                setState(() {
                  _isDarkMode = v;
                  AppTheme.themeNotifier.value = v ? ThemeMode.dark : ThemeMode.light;
                });
              }),
            ]),

            const SizedBox(height: 24),
            _buildSectionHeader('ABOUT'),
            _buildSettingCard([
              _buildSettingItem(Icons.info_outline, 'App Version', trailingText: 'v1.0.0'),
              _buildSettingItem(
                Icons.description_outlined, 
                'Licenses',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LicensesScreen()),
                  );
                },
              ),
            ]),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 12),
      child: Text(
        title,
        style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 1.1),
      ),
    );
  }

  Widget _buildSettingCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardTheme.color ?? Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(children: children),
    );
  }

  Widget _buildSettingItem(IconData icon, String title, {Color? color, String? trailingText, VoidCallback? onTap}) {
    final defaultColor = Theme.of(context).textTheme.bodyLarge?.color ?? Colors.black87;
    return ListTile(
      leading: Icon(icon, color: color ?? defaultColor, size: 22),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15, color: color ?? defaultColor)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null) 
            Text(trailingText, style: const TextStyle(color: Colors.grey, fontSize: 13)),
          const SizedBox(width: 8),
          const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchItem(IconData icon, String title, bool value, ValueChanged<bool> onChanged) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).iconTheme.color ?? Colors.black87, size: 22),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15)),
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeThumbColor: const Color(0xFF525CFF),
      ),
    );
  }
}
