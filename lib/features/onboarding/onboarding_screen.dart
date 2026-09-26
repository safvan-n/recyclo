import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/brand_logo.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../authentication/login_screen.dart';

/// Two-screen Onboarding Flow
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _navigateToLogin() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Align(
            alignment: Alignment.centerLeft,
            child: const ReCycloLogo(height: 28),
          ),
        ),
        leadingWidth: 100,
        actions: [
          if (_currentPage == 0)
            TextButton(
              onPressed: _navigateToLogin,
              child: Text(
                'Skip',
                style: ReCycloTypography.titleMedium.copyWith(
                  color: ReCycloColors.textMuted,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildPage(
                    iconName: 'plastic',
                    secondaryIcon: 'paper',
                    title: ReCycloStrings.onb1Title,
                    description: ReCycloStrings.onb1Desc,
                    badgeText: 'Doorstep Recycling',
                  ),
                  _buildPage(
                    iconName: 'truck',
                    secondaryIcon: 'cash',
                    title: ReCycloStrings.onb2Title,
                    description: ReCycloStrings.onb2Desc,
                    badgeText: 'Earn From Recyclables',
                  ),
                ],
              ),
            ),

            // Bottom Navigation & Controls
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  // Smooth animated page indicators
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(2, (index) {
                      final isSelected = index == _currentPage;
                      return AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        width: isSelected ? 24 : 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: isSelected ? ReCycloColors.primary : ReCycloColors.border,
                          borderRadius: BorderRadius.circular(4),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 32),

                  // Button Row
                  if (_currentPage == 0)
                    PrimaryButton(
                      text: 'Next',
                      onPressed: () {
                        _pageController.nextPage(
                          duration: const Duration(milliseconds: 350),
                          curve: Curves.easeInOutCubic,
                        );
                      },
                    )
                  else
                    PrimaryButton(
                      text: 'Get Started',
                      onPressed: _navigateToLogin,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPage({
    required String iconName,
    required String secondaryIcon,
    required String title,
    required String description,
    required String badgeText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Graphic container
          Container(
            width: 170,
            height: 170,
            decoration: BoxDecoration(
              color: ReCycloColors.primarySurface,
              shape: BoxShape.circle,
              border: Border.all(color: ReCycloColors.primaryLight, width: 2),
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                ReCycloIcon(
                  iconName,
                  size: 76,
                  color: ReCycloColors.primary,
                  active: true,
                ),
                Positioned(
                  bottom: 24,
                  right: 24,
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x14000000),
                          blurRadius: 8,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: ReCycloIcon(
                      secondaryIcon,
                      size: 24,
                      color: ReCycloColors.accentLeaf,
                      active: true,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),

          // Tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
            decoration: BoxDecoration(
              color: ReCycloColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              badgeText,
              style: ReCycloTypography.labelSmall.copyWith(
                color: ReCycloColors.primaryActive,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 16),

          // Title
          Text(
            title,
            textAlign: TextAlign.center,
            style: ReCycloTypography.displayMedium.copyWith(
              fontSize: 23,
              fontWeight: FontWeight.w800,
              height: 1.25,
            ),
          ),
          const SizedBox(height: 14),

          // Description
          Text(
            description,
            textAlign: TextAlign.center,
            style: ReCycloTypography.bodyLarge.copyWith(
              color: ReCycloColors.textSecondary,
              height: 1.45,
            ),
          ),
        ],
      ),
    );
  }
}
