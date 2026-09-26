import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/typography.dart';
import 'custom_buttons.dart';
import 'recyclo_icons.dart';

/// Reusable Empty State component with icon, message, and CTA
class EmptyState extends StatelessWidget {
  final String iconName;
  final String title;
  final String description;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyState({
    super.key,
    required this.iconName,
    required this.title,
    required this.description,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 48),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 76,
              height: 76,
              decoration: BoxDecoration(
                color: ReCycloColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ReCycloIcon(
                  iconName,
                  size: 36,
                  color: ReCycloColors.primary,
                  active: true,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              title,
              textAlign: TextAlign.center,
              style: ReCycloTypography.headingMedium.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              textAlign: TextAlign.center,
              style: ReCycloTypography.bodyMedium,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              PrimaryButton(
                text: buttonText!,
                onPressed: onButtonPressed,
                width: 200,
                height: 46,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
