import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/screens/dashboard/dashboard_screen.dart';
import 'package:trusttag_admin/screens/login/forgot_password_screen.dart';
import 'package:trusttag_admin/screens/login/login_screen.dart';
import 'package:trusttag_admin/screens/login/signup_screen.dart';
import 'package:trusttag_admin/screens/notifications/notifications_screen.dart';
import 'package:trusttag_admin/screens/products/products_screen.dart';
import 'package:trusttag_admin/screens/service_history/service_history_screen.dart';
import 'package:trusttag_admin/screens/users/users_screen.dart';
import 'package:trusttag_admin/screens/verification/product_verification_screen.dart';
import 'package:trusttag_admin/widgets/sidebar_widget.dart';

enum AuthView {
  login,
  signUp,
  forgotPassword,
  dashboard,
  verification,
  products,
  users,
  serviceHistory,
  notifications,
}

class TrustTagAdminApp extends StatefulWidget {
  const TrustTagAdminApp({super.key});

  @override
  State<TrustTagAdminApp> createState() => _TrustTagAdminAppState();
}

class _TrustTagAdminAppState extends State<TrustTagAdminApp> {
  AuthView _currentView = AuthView.login; // Entry point is Login Screen first

  void _navigateTo(AuthView view) {
    setState(() {
      _currentView = view;
    });
  }

  void _handleSidebarSelection(NavItem item) {
    switch (item) {
      case NavItem.dashboard:
        _navigateTo(AuthView.dashboard);
        break;
      case NavItem.verification:
        _navigateTo(AuthView.verification);
        break;
      case NavItem.products:
        _navigateTo(AuthView.products);
        break;
      case NavItem.users:
        _navigateTo(AuthView.users);
        break;
      case NavItem.serviceHistory:
        _navigateTo(AuthView.serviceHistory);
        break;
      case NavItem.logout:
        _navigateTo(AuthView.login);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activeScreen;

    switch (_currentView) {
      case AuthView.signUp:
        activeScreen = SignUpScreen(
          onNavigateToLogin: () => _navigateTo(AuthView.login),
        );
        break;
      case AuthView.forgotPassword:
        activeScreen = ForgotPasswordScreen(
          onNavigateToLogin: () => _navigateTo(AuthView.login),
        );
        break;
      case AuthView.dashboard:
        activeScreen = DashboardScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.verification:
        activeScreen = ProductVerificationScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.products:
        activeScreen = ProductsScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.users:
        activeScreen = UsersScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.serviceHistory:
        activeScreen = ServiceHistoryScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.notifications:
        activeScreen = NotificationsScreen(
          onItemSelected: _handleSidebarSelection,
          onNotificationTap: () => _navigateTo(AuthView.notifications),
        );
        break;
      case AuthView.login:
        activeScreen = LoginScreen(
          onNavigateToSignUp: () => _navigateTo(AuthView.signUp),
          onNavigateToForgotPassword: () =>
              _navigateTo(AuthView.forgotPassword),
          onLoginSuccess: () => _navigateTo(AuthView.dashboard),
        );
        break;
    }

    return MaterialApp(
      title: AppStrings.appName,
      debugShowCheckedModeBanner: false,
      theme: AppThemes.lightTheme,
      home: activeScreen,
    );
  }
}
