import 'package:flutter/material.dart';
import 'package:trusttag_application/src/core/constants/app_colors.dart';
import 'package:trusttag_application/src/features/auth/presentation/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 3));
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundWhite,
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 3),
              Column(
                children: [
                  Image.asset(
                    'assets/images/logo.png',
                    width: 140,
                    height: 140,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          color: const Color(0xFF525CFF).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: const Icon(
                          Icons.verified_user_outlined,
                          size: 80,
                          color: Color(0xFF525CFF),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  RichText(
                    text: const TextSpan(
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.2,
                      ),
                      children: [
                        TextSpan(
                          text: 'Trust',
                          style: TextStyle(color: Color(0xFF1A237E)),
                        ),
                        TextSpan(
                          text: 'Tag',
                          style: TextStyle(color: Color(0xFF525CFF)),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('— ', style: TextStyle(color: Colors.grey, fontSize: 12)),
                      Text('Verify. ', style: TextStyle(color: const Color(0xFF1A237E).withValues(alpha: 0.7), fontWeight: FontWeight.w600, fontSize: 12)),
                      Text('Trust. ', style: TextStyle(color: const Color(0xFF525CFF).withValues(alpha: 0.7), fontWeight: FontWeight.w600, fontSize: 12)),
                      Text('Transfer.', style: TextStyle(color: Colors.green.withValues(alpha: 0.8), fontWeight: FontWeight.w600, fontSize: 12)),
                      const Text(' —', style: TextStyle(color: Colors.grey, fontSize: 12)),
                    ],
                  ),
                ],
              ),
              const Spacer(flex: 2),
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF525CFF)),
                  strokeWidth: 2.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                'Initializing Secure Passport...',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
