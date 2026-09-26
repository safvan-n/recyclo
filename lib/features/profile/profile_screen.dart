import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../data/repositories/auth_repository.dart';
import '../../app/routes.dart';
import '../payment/payment_history_screen.dart';
import '../settings/settings_screen.dart';
import '../help/help_screen.dart';

/// User Profile Screen
class ProfileScreen extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const ProfileScreen({super.key, this.onTabChange});

  void _showEditProfileDialog(BuildContext context, dynamic user, AuthProvider auth) {
    final nameCtrl = TextEditingController(text: user.name);
    final phoneCtrl = TextEditingController(text: user.phone);
    final locCtrl = TextEditingController(text: user.location);

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Edit Profile', style: ReCycloTypography.headingMedium),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomTextField(controller: nameCtrl, label: 'Full Name'),
              const SizedBox(height: 12),
              CustomTextField(controller: phoneCtrl, label: 'Phone Number'),
              const SizedBox(height: 12),
              CustomTextField(controller: locCtrl, label: 'Default Location'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              auth.updateProfile(
                name: nameCtrl.text.trim(),
                phone: phoneCtrl.text.trim(),
                location: locCtrl.text.trim(),
              );
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Profile updated successfully.'),
                  backgroundColor: ReCycloColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ReCycloColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  void _showSavedAddresses(BuildContext context, dynamic user) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Saved Addresses', style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 16),
              ...user.savedAddresses.map((addr) {
                return ListTile(
                  contentPadding: EdgeInsets.zero,
                  leading: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: ReCycloColors.primaryLight,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.home_outlined, color: ReCycloColors.primary),
                  ),
                  title: Text(addr.label, style: const TextStyle(fontWeight: FontWeight.w700)),
                  subtitle: Text(addr.address, style: const TextStyle(fontSize: 12)),
                  trailing: addr.isDefault
                      ? const Chip(
                          label: Text('Default', style: TextStyle(fontSize: 10, color: ReCycloColors.primaryActive)),
                          backgroundColor: ReCycloColors.primaryLight,
                          padding: EdgeInsets.zero,
                        )
                      : null,
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = context.watch<AuthProvider>();
    final user = auth.currentUser;

    if (user == null) {
      return const Scaffold(body: Center(child: Text('Please log in.')));
    }

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              // User Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 34,
                          backgroundImage: user.avatar != null ? NetworkImage(user.avatar!) : null,
                          backgroundColor: ReCycloColors.primaryLight,
                          child: user.avatar == null
                              ? const Icon(Icons.person, size: 36, color: ReCycloColors.primary)
                              : null,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user.name,
                                style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.email,
                                style: ReCycloTypography.bodySmall,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                user.phone,
                                style: ReCycloTypography.bodySmall.copyWith(color: ReCycloColors.textPrimary),
                              ),
                            ],
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit_outlined, size: 20, color: ReCycloColors.primary),
                          onPressed: () => _showEditProfileDialog(context, user, auth),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1, color: ReCycloColors.divider),
                    const SizedBox(height: 14),

                    // Stats Grid
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStat('Recycled', '${user.stats.totalRecycledKg} kg'),
                        Container(width: 1, height: 28, color: ReCycloColors.divider),
                        _buildStat('Collections', '${user.stats.collectionsCompleted}'),
                        Container(width: 1, height: 28, color: ReCycloColors.divider),
                        _buildStat('Earned', user.stats.moneyEarned),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Navigation Menu
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  children: [
                    _buildMenuItem(
                      icon: 'requests',
                      title: 'My Requests',
                      subtitle: 'Track current and past pickups',
                      onTap: () => onTabChange?.call(1),
                    ),
                    const Divider(height: 1, indent: 56, color: ReCycloColors.divider),
                    _buildMenuItem(
                      icon: 'card',
                      title: 'Payment History',
                      subtitle: 'UPI payouts and collection receipts',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, color: ReCycloColors.divider),
                    _buildMenuItem(
                      icon: 'location',
                      title: 'Saved Addresses',
                      subtitle: 'Manage home & work pickup locations',
                      onTap: () => _showSavedAddresses(context, user),
                    ),
                    const Divider(height: 1, indent: 56, color: ReCycloColors.divider),
                    _buildMenuItem(
                      icon: 'bell',
                      title: 'Settings',
                      subtitle: 'App preferences and notifications',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const SettingsScreen()),
                        );
                      },
                    ),
                    const Divider(height: 1, indent: 56, color: ReCycloColors.divider),
                    _buildMenuItem(
                      icon: 'other',
                      title: 'Help & Support',
                      subtitle: 'FAQs, contact support, guide',
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const HelpSupportScreen()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Logout Button
              OutlinedButton.icon(
                onPressed: () {
                  auth.logout();
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (r) => false);
                },
                style: OutlinedButton.styleFrom(
                  foregroundColor: ReCycloColors.danger,
                  side: const BorderSide(color: Color(0xFFFCA5A5)),
                  minimumSize: const Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                ),
                icon: const Icon(Icons.logout_rounded, size: 18),
                label: const Text('Logout from ReCyclo', style: TextStyle(fontWeight: FontWeight.w700)),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStat(String label, String value) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 14)),
        const SizedBox(height: 2),
        Text(label, style: ReCycloTypography.bodySmall.copyWith(fontSize: 11)),
      ],
    );
  }

  Widget _buildMenuItem({
    required String icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      onTap: onTap,
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: ReCycloColors.primaryLight,
          shape: BoxShape.circle,
        ),
        child: ReCycloIcon(icon, size: 18, color: ReCycloColors.primaryActive),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 14)),
      subtitle: Text(subtitle, style: ReCycloTypography.bodySmall),
      trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: ReCycloColors.textMuted),
    );
  }
}
