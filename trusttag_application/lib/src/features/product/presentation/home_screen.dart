import 'package:flutter/material.dart';
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

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      DashboardScreen(
        onMyProductsTap: () {
          setState(() {
            _currentIndex = 1; // Switch to My Products tab
          });
        },
      ),
      const ProductsScreen(),
      const AlertsScreen(),
      const ProfileScreen(),
    ];

    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: _currentIndex == 0 
        ? AppBar(
            backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
            elevation: 0,
            title: const Text(
              'TrustTag',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_none, color: Colors.amber),
                onPressed: () {
                  setState(() {
                    _currentIndex = 2; // Go to Alerts tab
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.account_circle_outlined, color: isDark ? Colors.white : Colors.black),
                onPressed: () {
                  setState(() {
                    _currentIndex = 3; // Go to Profile tab
                  });
                },
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
          backgroundColor: isDark ? const Color(0xFF1E1E1E) : Colors.white,
          selectedItemColor: const Color(0xFF525CFF),
          unselectedItemColor: Colors.grey,
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
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
