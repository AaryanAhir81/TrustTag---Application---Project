import 'package:flutter/material.dart';
import 'package:trusttag_admin/resource/resource.dart';

/// TrustTag Admin Header Logo & Branding Widget
class TrustTagBrandHeader extends StatelessWidget {
  const TrustTagBrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Tag/Shield Icon with checkmark/package
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withValues(alpha: 0.2),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: Colors.white,
                  size: 24,
                ),
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: AppColors.success,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 10,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(width: AppSizes.sm + 4),
        RichText(
          text: const TextSpan(
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.3,
            ),
            children: [
              TextSpan(
                text: 'Trust',
                style: TextStyle(color: AppColors.textPrimary),
              ),
              TextSpan(
                text: 'Tag',
                style: TextStyle(color: AppColors.primary),
              ),
              TextSpan(
                text: ' Admin',
                style: TextStyle(color: AppColors.textPrimary),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Custom Labelled Text Input Field with Validation Support
class CustomInputField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final Widget? topTrailingWidget;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomInputField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.topTrailingWidget,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppStyles.label),
            if (topTrailingWidget != null) ...[topTrailingWidget!],
          ],
        ),
        const SizedBox(height: AppSizes.xs + 2),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          style: AppStyles.body,
          validator: validator,
          onChanged: onChanged,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          decoration: AppStyles.inputDecoration(
            hintText: hintText,
            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: AppSizes.iconMd,
                    color: AppColors.textMuted,
                  )
                : null,
            suffixIcon: suffixIcon,
          ),
        ),
      ],
    );
  }
}

/// Primary Button Widget (supports disabled state)
class PrimaryButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isEnabled;

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    final bool active = isEnabled && onPressed != null;

    return SizedBox(
      width: double.infinity,
      height: AppSizes.buttonHeight,
      child: ElevatedButton(
        onPressed: active ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: active ? AppColors.primary : AppColors.cardBorder,
          foregroundColor: active ? AppColors.textLight : AppColors.textMuted,
          disabledBackgroundColor: AppColors.cardBorder,
          disabledForegroundColor: AppColors.textMuted,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSizes.radiusMd),
          ),
        ),
        child: Text(
          text,
          style: AppStyles.button.copyWith(
            color: active ? AppColors.textLight : AppColors.textMuted,
          ),
        ),
      ),
    );
  }
}

/// Page Bottom Footer Widget (Responsive Layout)
class AuthFooterWidget extends StatelessWidget {
  const AuthFooterWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.xl,
        vertical: AppSizes.md,
      ),
      decoration: const BoxDecoration(
        color: AppColors.footerBackground,
        border: Border(
          top: BorderSide(color: AppColors.border, width: 1.0),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isNarrow = constraints.maxWidth < 640;
          return Wrap(
            alignment:
                isNarrow ? WrapAlignment.center : WrapAlignment.spaceBetween,
            runSpacing: AppSizes.sm,
            spacing: AppSizes.md,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              const Text(
                AppStrings.copyright,
                style: AppStyles.footer,
              ),
              Wrap(
                spacing: AppSizes.lg,
                runSpacing: AppSizes.xs,
                alignment: WrapAlignment.center,
                children: [
                  InkWell(
                    onTap: () {},
                    child: const Text(AppStrings.privacyPolicy,
                        style: AppStyles.footer),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(AppStrings.termsOfService,
                        style: AppStyles.footer),
                  ),
                  InkWell(
                    onTap: () {},
                    child: const Text(AppStrings.contactSupport,
                        style: AppStyles.footer),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
