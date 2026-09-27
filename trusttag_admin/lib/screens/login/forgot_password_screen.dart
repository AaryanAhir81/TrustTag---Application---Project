import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/common_widgets.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final VoidCallback onNavigateToLogin;

  const ForgotPasswordScreen({
    super.key,
    required this.onNavigateToLogin,
  });

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  bool _isSubmitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _handleReset() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        _isSubmitted = true;
      });
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
                            // Key Reset Badge Icon
                            Container(
                              width: 52,
                              height: 52,
                              decoration: BoxDecoration(
                                color: AppColors.primaryLight,
                                borderRadius: BorderRadius.circular(14),
                              ),
                              child: const Icon(
                                Icons.lock_reset_outlined,
                                color: AppColors.primary,
                                size: 28,
                              ),
                            ),
                            const SizedBox(height: AppSizes.md),

                            // Title & Subtitle
                            Text(
                              _isSubmitted
                                  ? AppStrings.resetLinkSentTitle
                                  : AppStrings.forgotPasswordTitle,
                              style: AppStyles.headingLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xs + 2),
                            Text(
                              _isSubmitted
                                  ? AppStrings.resetLinkSentSubtitle
                                  : AppStrings.forgotPasswordSubtitle,
                              style: AppStyles.subtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xl),

                            if (!_isSubmitted) ...[
                              // Email Input Field
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
                              const SizedBox(height: AppSizes.xl),

                              // Send Reset Link Button
                              PrimaryButton(
                                text: AppStrings.sendResetLinkBtn,
                                onPressed: _handleReset,
                              ),
                              const SizedBox(height: AppSizes.lg),
                            ],

                            // Back to Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  size: AppSizes.iconSm,
                                  color: AppColors.link,
                                ),
                                const SizedBox(width: AppSizes.xs),
                                InkWell(
                                  onTap: widget.onNavigateToLogin,
                                  child: const Text(
                                    AppStrings.backToLogin,
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
