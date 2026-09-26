import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../theme/typography.dart';

/// Standardized ReCyclo Status Badges
class StatusBadge extends StatelessWidget {
  final String status;
  final String? customLabel;
  final double fontSize;

  const StatusBadge({
    super.key,
    required this.status,
    this.customLabel,
    this.fontSize = 11.5,
  });

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg;
    String label = customLabel ?? _formatStatus(status);

    switch (status.toLowerCase()) {
      case 'available':
        bg = ReCycloColors.badgeAvailableBg;
        fg = ReCycloColors.badgeAvailableText;
        label = customLabel ?? 'Available';
        break;
      case 'busy':
        bg = ReCycloColors.badgeBusyBg;
        fg = ReCycloColors.badgeBusyText;
        label = customLabel ?? 'Busy';
        break;
      case 'offline':
        bg = ReCycloColors.badgeOfflineBg;
        fg = ReCycloColors.badgeOfflineText;
        label = customLabel ?? 'Offline';
        break;
      case 'on_the_way':
      case 'on the way':
        bg = const Color(0xFFE0F2FE);
        fg = const Color(0xFF0369A1);
        label = customLabel ?? 'On The Way';
        break;
      case 'scheduled':
        bg = const Color(0xFFFEF3C7);
        fg = const Color(0xFFB45309);
        label = customLabel ?? 'Scheduled';
        break;
      case 'completed':
      case 'collected':
        bg = ReCycloColors.primaryLight;
        fg = ReCycloColors.primaryActive;
        label = customLabel ?? 'Completed';
        break;
      case 'pending':
      case 'placed':
        bg = const Color(0xFFF1F5F9);
        fg = const Color(0xFF475569);
        label = customLabel ?? 'Placed';
        break;
      default:
        bg = ReCycloColors.primaryLight;
        fg = ReCycloColors.primary;
        label = customLabel ?? status;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: ReCycloTypography.labelSmall.copyWith(
          color: fg,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _formatStatus(String s) {
    return s.replaceAll('_', ' ').split(' ').map((word) {
      if (word.isEmpty) return '';
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');
  }
}
