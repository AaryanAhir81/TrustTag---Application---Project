import 'package:trusttag_application/src/core/resources/resources.dart';
import 'package:trusttag_application/src/features/product/presentation/dashboard_screen.dart';
import 'package:trusttag_application/src/features/product/presentation/products_screen.dart';
import 'package:trusttag_application/src/features/services/presentation/alerts_screen.dart';
import 'package:trusttag_application/src/features/auth/presentation/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(
        onViewAllTap: () => _changeTab(1),
        onAlertsTap: () => _changeTab(2),
        onProfileTap: () => _changeTab(3),
      ),
      const ProductsScreen(),
      const AlertsScreen(isTab: true),
      ProfileScreen(onTabChange: _changeTab),
    ];

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _currentIndex == 0 
        ? AppBar(
            backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
            elevation: 0,
            title: const Text(
              'TrustTag',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.amber),
                onPressed: () => _changeTab(2),
              ),
              IconButton(
                icon: Icon(Icons.account_circle_outlined, color: isDark ? Colors.white : Colors.black),
                onPressed: () => _changeTab(3),
              ),
              const SizedBox(width: 8),
            ],
          )
        : null,
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: isDark ? AppColors.darkSurface : Colors.white,
          selectedItemColor: AppColors.accentBlue,
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: _changeTab,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.inventory_2_outlined), label: 'Products'),
            BottomNavigationBarItem(icon: Icon(Icons.notifications_none), label: 'Alerts'),
            BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
