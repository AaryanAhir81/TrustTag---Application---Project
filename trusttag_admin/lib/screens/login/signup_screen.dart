import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';
import 'package:trusttag_admin/widgets/common_widgets.dart';

class SignUpScreen extends StatefulWidget {
  final VoidCallback onNavigateToLogin;

  const SignUpScreen({
    super.key,
    required this.onNavigateToLogin,
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _workEmailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isPasswordObscured = true;
  bool _isConfirmObscured = true;
  bool _agreeToTerms = false;

  @override
  void dispose() {
    _fullNameController.dispose();
    _workEmailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _handleRegister() {
    if (!_agreeToTerms) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(AppStrings.valTermsRequired),
          backgroundColor: AppColors.error,
        ),
      );
      return;
    }

    if (_formKey.currentState?.validate() ?? false) {
      // Registration validation passed
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Creating account...'),
          backgroundColor: AppColors.success,
        ),
      );
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
                  width: AppSizes.authCardWidth + 20,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSizes.xl),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Create Your Admin Account Title & Subtitle
                            const Text(
                              AppStrings.createAccountTitle,
                              style: AppStyles.headingLarge,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xs + 2),
                            const Text(
                              AppStrings.signUpSubtitle,
                              style: AppStyles.subtitle,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: AppSizes.xl),

                            // Full Name Input
                            CustomInputField(
                              label: AppStrings.fullName,
                              hintText: AppStrings.fullNameHint,
                              controller: _fullNameController,
                              prefixIcon: Icons.person_outline,
                              validator: (value) {
                                if (value == null || value.trim().isEmpty) {
                                  return AppStrings.valFullNameRequired;
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: AppSizes.md),

                            // Work Email Input
                            CustomInputField(
                              label: AppStrings.workEmail,
                              hintText: AppStrings.workEmailHint,
                              controller: _workEmailController,
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

                            // Password & Confirm Password Row
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: CustomInputField(
                                    label: AppStrings.password,
                                    hintText: AppStrings.passwordHint,
                                    controller: _passwordController,
                                    prefixIcon: Icons.lock_outline,
                                    obscureText: _isPasswordObscured,
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
                                          _isPasswordObscured =
                                              !_isPasswordObscured;
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
                                ),
                                const SizedBox(width: AppSizes.md),
                                Expanded(
                                  child: CustomInputField(
                                    label: AppStrings.confirmPassword,
                                    hintText: AppStrings.passwordHint,
                                    controller: _confirmPasswordController,
                                    prefixIcon:
                                        Icons.history_toggle_off_outlined,
                                    obscureText: _isConfirmObscured,
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isConfirmObscured
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        size: AppSizes.iconMd,
                                        color: AppColors.textMuted,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmObscured =
                                              !_isConfirmObscured;
                                        });
                                      },
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return AppStrings
                                            .valConfirmPasswordRequired;
                                      }
                                      if (value != _passwordController.text) {
                                        return AppStrings
                                            .valPasswordsDoNotMatch;
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSizes.md),

                            // Terms & Conditions Checkbox Row
                            InkWell(
                              onTap: () {
                                setState(() {
                                  _agreeToTerms = !_agreeToTerms;
                                });
                              },
                              borderRadius:
                                  BorderRadius.circular(AppSizes.radiusSm),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 4.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: Checkbox(
                                        value: _agreeToTerms,
                                        activeColor: AppColors.primary,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(4),
                                        ),
                                        side: const BorderSide(
                                          color: AppColors.inputBorder,
                                          width: 1.5,
                                        ),
                                        onChanged: (val) {
                                          setState(() {
                                            _agreeToTerms = val ?? false;
                                          });
                                        },
                                      ),
                                    ),
                                    const SizedBox(width: AppSizes.sm + 2),
                                    Expanded(
                                      child: RichText(
                                        text: const TextSpan(
                                          style: TextStyle(
                                            fontSize: 12.0,
                                            color: AppColors.textSecondary,
                                          ),
                                          children: [
                                            TextSpan(
                                                text: AppStrings.agreeToTerms),
                                            TextSpan(
                                              text: AppStrings.termsOfService,
                                              style: AppStyles.link,
                                            ),
                                            TextSpan(text: AppStrings.and),
                                            TextSpan(
                                              text: AppStrings.privacyPolicy,
                                              style: AppStyles.link,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: AppSizes.xl),

                            // Create Account Button (Enabled ONLY when checkbox is ticked)
                            PrimaryButton(
                              text: AppStrings.createAccountBtn,
                              isEnabled: _agreeToTerms,
                              onPressed: _handleRegister,
                            ),
                            const SizedBox(height: AppSizes.lg),

                            // Already have an account? Login Link
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  AppStrings.alreadyHaveAccount,
                                  style: AppStyles.subtitle,
                                ),
                                InkWell(
                                  onTap: widget.onNavigateToLogin,
                                  child: const Text(
                                    AppStrings.loginLink,
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
