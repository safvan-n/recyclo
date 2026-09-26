import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/brand_logo.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../data/repositories/auth_repository.dart';
import '../../app/routes.dart';
import 'signup_screen.dart';

/// Login Screen
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController(text: 'alex.rivers@recyclo.eco');
  final _passwordController = TextEditingController(text: 'password123');
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final auth = context.read<AuthProvider>();
    final success = await auth.login(
      _emailController.text.trim(),
      _passwordController.text,
    );

    if (success && mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.main);
    }
  }

  void _handleGoogleLogin() async {
    final auth = context.read<AuthProvider>();
    await auth.login('alex.rivers@recyclo.eco', 'google_mock');
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.main);
    }
  }

  void _showForgotPasswordDialog() {
    final emailForgotController = TextEditingController(text: _emailController.text);
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Reset Password', style: ReCycloTypography.headingMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Enter your registered email address to receive password reset instructions.',
              style: ReCycloTypography.bodyMedium,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: emailForgotController,
              hint: 'you@example.com',
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Password reset link sent to your email.'),
                  backgroundColor: ReCycloColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ReCycloColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Send Link'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  const Center(
                    child: ReCycloLogo(height: 52),
                  ),
                  const SizedBox(height: 28),

                  // Welcome Heading
                  Text(
                    'Welcome back 👋',
                    style: ReCycloTypography.displayMedium.copyWith(
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    'Log in to request pickups, track waste, and get paid.',
                    style: ReCycloTypography.bodyMedium,
                  ),
                  const SizedBox(height: 28),

                  // Email or Phone Field
                  CustomTextField(
                    controller: _emailController,
                    label: 'Email or Phone Number',
                    hint: 'Enter your email or phone',
                    prefixIcon: const Icon(Icons.mail_outline_rounded, size: 20, color: ReCycloColors.textMuted),
                    keyboardType: TextInputType.emailAddress,
                    validator: (val) {
                      if (val == null || val.trim().isEmpty) {
                        return 'Please enter your email or phone number';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 18),

                  // Password Field
                  CustomTextField(
                    controller: _passwordController,
                    label: 'Password',
                    hint: 'Enter your password',
                    obscureText: _obscurePassword,
                    prefixIcon: const Icon(Icons.lock_outline_rounded, size: 20, color: ReCycloColors.textMuted),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        size: 20,
                        color: ReCycloColors.textMuted,
                      ),
                      onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (val.length < 6) {
                        return 'Password must be at least 6 characters';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 8),

                  // Forgot Password Link
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _showForgotPasswordDialog,
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        minimumSize: Size.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      child: Text(
                        'Forgot Password?',
                        style: ReCycloTypography.labelSmall.copyWith(
                          color: ReCycloColors.primaryActive,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // Login Button
                  PrimaryButton(
                    text: 'Login',
                    onPressed: _handleLogin,
                    isLoading: auth.isLoading,
                  ),
                  const SizedBox(height: 16),

                  // Divider with OR
                  Row(
                    children: [
                      const Expanded(child: Divider(color: ReCycloColors.divider)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 14),
                        child: Text(
                          'OR',
                          style: ReCycloTypography.bodySmall.copyWith(fontWeight: FontWeight.w600),
                        ),
                      ),
                      const Expanded(child: Divider(color: ReCycloColors.divider)),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Google Login Button
                  SecondaryButton(
                    text: 'Continue with Google',
                    isOutlined: true,
                    icon: const Icon(Icons.g_mobiledata_rounded, size: 24, color: ReCycloColors.danger),
                    onPressed: _handleGoogleLogin,
                  ),
                  const SizedBox(height: 24),

                  // Signup link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account? ",
                        style: ReCycloTypography.bodyMedium,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => const SignupScreen()),
                          );
                        },
                        child: Text(
                          'Create Account',
                          style: ReCycloTypography.titleMedium.copyWith(
                            color: ReCycloColors.primaryActive,
                            fontWeight: FontWeight.w800,
                          ),
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
    );
  }
}
