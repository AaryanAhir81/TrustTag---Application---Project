import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/common_widgets.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onNavigateToSignUp;
  final VoidCallback onNavigateToForgotPassword;
  final VoidCallback? onLoginSuccess;

  const LoginScreen({
    super.key,
    required this.onNavigateToSignUp,
    required this.onNavigateToForgotPassword,
    this.onLoginSuccess,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isPasswordObscured = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() {
    if (_formKey.currentState?.validate() ?? false) {
      if (widget.onLoginSuccess != null) {
        widget.onLoginSuccess!();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Logging in...'),
            backgroundColor: AppColors.primary,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // Top Header Bar
          Container(
            height: 64,
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.xl),
            color: AppColors.surface,
            alignment: Alignment.centerLeft,
            child: const TrustTagBrandHeader(),
          ),

          // Main Centered Content
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(AppSizes.xl),
                child: SizedBox(
                  width: AppSizes.authCardWidth,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.xl),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Top Icon Shield Badge
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.verified_user_outlined,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: AppSizes.md),

                            // Welcome Back Title & Subtitle
                            const Text(
                              AppStrings.welcomeBack,
                              style: AppStyles.headingLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xs),
                            const Text(
                              AppStrings.loginSubtitle,
                              style: AppStyles.subtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xl),

                            // Email Input with Validation
                            CustomInputField(
                              label: AppStrings.email,
                              hintText: AppStrings.emailHint,
                              controller: _emailController,
                              prefixIcon: Icons.mail_outline,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppStrings.valEmailRequired;
                                }
                                final emailRegex =
                                    RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                if (!emailRegex.hasMatch(value.trim())) {
                                  return AppStrings.valEmailInvalid;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.md),

                            // Password Input with Validation
                            CustomInputField(
                              label: AppStrings.password,
                              hintText: AppStrings.passwordHint,
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _isPasswordObscured,
                              topTrailingWidget: InkWell(
                                onTap: widget.onNavigateToForgotPassword,
                                child: const Text(
                                  AppStrings.forgotPassword,
                                  style: AppStyles.link,
                                ),
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _isPasswordObscured
                                      ? Icons.visibility_outlined
                                      : Icons.visibility_off_outlined,
                                  size: AppSizes.iconMd,
                                  color: AppColors.textMuted,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _isPasswordObscured = !_isPasswordObscured;
                                  });
                                },
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return AppStrings.valPasswordRequired;
                                }
                                if (value.length < 6) {
                                  return AppStrings.valPasswordTooShort;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.xl),

                            // Login Button
                            PrimaryButton(
                              text: AppStrings.loginBtn,
                              onPressed: _handleLogin,
                            ),
                            const SizedBox(height: AppSizes.lg),

                            // OR Divider
                            Row(
                              children: [
                                const Expanded(
                                  child: Divider(color: AppColors.divider),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: AppSizes.md,
                                  ),
                                  child: Text(
                                    AppStrings.or,
                                    style: AppStyles.subtitle.copyWith(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(color: AppColors.divider),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.lg),

                            // Switch to Sign Up
                            Wrap(
                              alignment: WrapAlignment.center,
                              crossAxisAlignment: WrapCrossAlignment.center,
                              children: [
                                const Text(
                                  AppStrings.dontHaveAccount,
                                  style: AppStyles.subtitle,
                                ),
                                InkWell(
                                  onTap: widget.onNavigateToSignUp,
                                  child: const Text(
                                    AppStrings.signUpLink,
                                    style: AppStyles.link,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Bottom Footer
          const AuthFooterWidget(),
        ],
      ),
    );
  }
}
