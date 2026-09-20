import 'package:trusttag_application/src/core/resources/resources.dart';
import 'package:trusttag_application/src/features/auth/presentation/splash_screen.dart';

class TrustTagApp extends StatelessWidget {
  const TrustTagApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: AppTheme.themeNotifier,
      builder: (context, ThemeMode currentMode, child) {
        return MaterialApp(
          title: 'TrustTag',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: currentMode,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
        );
      },
    );
  }
}
