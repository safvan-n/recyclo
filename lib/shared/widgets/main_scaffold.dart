import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/recyclo_icons.dart';

/// Main Application Shell with 5 bottom navigation destinations
/// Exactly: Home, Requests, Add Waste (prominent), Collectors, Profile
class MainScaffold extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onNavigationChanged;
  final Widget body;

  const MainScaffold({
    super.key,
    required this.currentIndex,
    required this.onNavigationChanged,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      body: body,
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: ReCycloColors.border, width: 1.0)),
          boxShadow: [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 16,
              offset: Offset(0, -4),
            ),
          ],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 66,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(
                  index: 0,
                  label: 'Home',
                  iconName: 'home',
                  isActive: currentIndex == 0,
                ),
                _buildNavItem(
                  index: 1,
                  label: 'Requests',
                  iconName: 'requests',
                  isActive: currentIndex == 1,
                ),
                _buildProminentAddWasteButton(),
                _buildNavItem(
                  index: 3,
                  label: 'Collectors',
                  iconName: 'collectors',
                  isActive: currentIndex == 3,
                ),
                _buildNavItem(
                  index: 4,
                  label: 'Profile',
                  iconName: 'profile',
                  isActive: currentIndex == 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required String label,
    required String iconName,
    required bool isActive,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () => onNavigationChanged(index),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
              decoration: BoxDecoration(
                color: isActive ? ReCycloColors.primaryLight : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: ReCycloIcon(
                iconName,
                size: 22,
                color: isActive ? ReCycloColors.primary : ReCycloColors.textSecondary,
                active: isActive,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: ReCycloTypography.labelSmall.copyWith(
                fontSize: 11,
                color: isActive ? ReCycloColors.primaryActive : ReCycloColors.textMuted,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProminentAddWasteButton() {
    final isActive = currentIndex == 2;
    return Expanded(
      child: InkWell(
        onTap: () => onNavigationChanged(2),
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: ReCycloColors.primary,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: ReCycloColors.primaryGlow,
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: const Center(
                child: ReCycloIcon(
                  'plus',
                  size: 22,
                  color: Colors.white,
                  active: true,
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              'Add Waste',
              style: ReCycloTypography.labelSmall.copyWith(
                fontSize: 10.5,
                color: isActive ? ReCycloColors.primaryActive : ReCycloColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
