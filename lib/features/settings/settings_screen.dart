import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/brand_logo.dart';
import '../../data/repositories/auth_repository.dart';
import '../../app/routes.dart';

/// App Settings Screen
class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _pickupAlerts = true;
  bool _chatAlerts = true;
  bool _marketingAlerts = false;
  bool _locationTracking = true;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSectionTitle('Notifications'),
              _buildCard([
                SwitchListTile(
                  title: const Text('Pickup Status Alerts', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Notifications when collector accepts or arrives', style: TextStyle(fontSize: 12)),
                  value: _pickupAlerts,
                  activeThumbColor: ReCycloColors.primary,
                  activeTrackColor: ReCycloColors.primaryLight,
                  onChanged: (val) => setState(() => _pickupAlerts = val),
                ),
                const Divider(height: 1, color: ReCycloColors.divider),
                SwitchListTile(
                  title: const Text('Direct Messages', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Notifications for collector chat messages', style: TextStyle(fontSize: 12)),
                  value: _chatAlerts,
                  activeThumbColor: ReCycloColors.primary,
                  activeTrackColor: ReCycloColors.primaryLight,
                  onChanged: (val) => setState(() => _chatAlerts = val),
                ),
                const Divider(height: 1, color: ReCycloColors.divider),
                SwitchListTile(
                  title: const Text('Promotions & Rates', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Weekly municipal scrap rate updates and bonus rates', style: TextStyle(fontSize: 12)),
                  value: _marketingAlerts,
                  activeThumbColor: ReCycloColors.primary,
                  activeTrackColor: ReCycloColors.primaryLight,
                  onChanged: (val) => setState(() => _marketingAlerts = val),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionTitle('Preferences & Location'),
              _buildCard([
                ListTile(
                  title: const Text('Language', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: Text(_selectedLanguage, style: const TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (ctx) => SimpleDialog(
                        title: const Text('Select Language'),
                        children: ['English', 'Hindi', 'Kannada', 'Tamil'].map((lang) {
                          return SimpleDialogOption(
                            onPressed: () {
                              setState(() => _selectedLanguage = lang);
                              Navigator.pop(ctx);
                            },
                            child: Text(lang),
                          );
                        }).toList(),
                      ),
                    );
                  },
                ),
                const Divider(height: 1, color: ReCycloColors.divider),
                SwitchListTile(
                  title: const Text('Live Location Access', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Used for accurate collector distance calculation', style: TextStyle(fontSize: 12)),
                  value: _locationTracking,
                  activeThumbColor: ReCycloColors.primary,
                  activeTrackColor: ReCycloColors.primaryLight,
                  onChanged: (val) => setState(() => _locationTracking = val),
                ),
              ]),
              const SizedBox(height: 20),

              _buildSectionTitle('Legal & About'),
              _buildCard([
                ListTile(
                  title: const Text('Terms & Conditions', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  onTap: () => _showTextDialog(context, 'Terms & Conditions', 'By using ReCyclo, you agree to transparent weighing, standard municipal rates, and respectful community conduct.'),
                ),
                const Divider(height: 1, color: ReCycloColors.divider),
                ListTile(
                  title: const Text('Privacy Policy', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  trailing: const Icon(Icons.arrow_forward_ios_rounded, size: 14),
                  onTap: () => _showTextDialog(context, 'Privacy Policy', 'ReCyclo values your privacy. Doorstep addresses and phone numbers are encrypted and only shared with assigned verified collectors during active collection hours.'),
                ),
                const Divider(height: 1, color: ReCycloColors.divider),
                ListTile(
                  title: const Text('About ReCyclo', style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14)),
                  subtitle: const Text('Version 1.0.0 (Production Build)', style: TextStyle(fontSize: 12)),
                  trailing: const Icon(Icons.info_outline_rounded, size: 18),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: ReCycloStrings.appName,
                      applicationVersion: '1.0.0',
                      applicationIcon: const ReCycloLogo(height: 40),
                      children: const [
                        Text('ReCyclo – Turning Waste into Worth.\nConnecting households with certified waste collectors for doorstep recycling and instant payouts.'),
                      ],
                    );
                  },
                ),
              ]),
              const SizedBox(height: 28),

              // Logout Button
              Center(
                child: TextButton(
                  onPressed: () {
                    context.read<AuthProvider>().logout();
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.login, (r) => false);
                  },
                  child: const Text(
                    'Logout from ReCyclo',
                    style: TextStyle(color: ReCycloColors.danger, fontWeight: FontWeight.w700),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 4, bottom: 8),
      child: Text(
        title,
        style: ReCycloTypography.titleMedium.copyWith(
          color: ReCycloColors.textMuted,
          fontWeight: FontWeight.w700,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _buildCard(List<Widget> children) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ReCycloColors.border),
      ),
      child: Column(children: children),
    );
  }

  void _showTextDialog(BuildContext context, String title, String body) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(title, style: ReCycloTypography.headingMedium),
        content: Text(body, style: ReCycloTypography.bodyMedium),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.pop(ctx),
            style: ElevatedButton.styleFrom(backgroundColor: ReCycloColors.primary, foregroundColor: Colors.white),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }
}
