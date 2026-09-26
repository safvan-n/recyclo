import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/custom_text_field.dart';
import '../../data/mock/mock_data.dart';

/// Help & Support Screen with expandable FAQ cards
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  void _showContactSupport(BuildContext context) {
    final queryController = TextEditingController();
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text('Contact Support', style: ReCycloTypography.headingMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Our eco-support champions are here to help with pickups, payments, and scrap rates.',
              style: TextStyle(fontSize: 13),
            ),
            const SizedBox(height: 14),
            CustomTextField(
              controller: queryController,
              label: 'How can we help?',
              hint: 'Describe your query...',
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Your message has been sent to ReCyclo Support.'),
                  backgroundColor: ReCycloColors.primary,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: ReCycloColors.primary,
              foregroundColor: Colors.white,
            ),
            child: const Text('Submit Ticket'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final faqs = MockData.faqs;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Help & Support'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Contact Banner
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: const BoxDecoration(
                        color: ReCycloColors.primaryLight,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.support_agent_rounded, size: 32, color: ReCycloColors.primary),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Need help with a pickup?',
                      style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w800),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Reach out directly to our dedicated support team or browse frequent questions below.',
                      textAlign: TextAlign.center,
                      style: ReCycloTypography.bodySmall,
                    ),
                    const SizedBox(height: 16),
                    PrimaryButton(
                      text: 'Contact Support Team',
                      height: 44,
                      onPressed: () => _showContactSupport(context),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Frequently Asked Questions',
                style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 12),

              // Expandable FAQ Accordion Cards
              ...faqs.map((faq) {
                return Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: ReCycloColors.border),
                  ),
                  child: Theme(
                    data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      tilePadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      childrenPadding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                      iconColor: ReCycloColors.primary,
                      collapsedIconColor: ReCycloColors.textMuted,
                      title: Text(
                        faq['q']!,
                        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13.5),
                      ),
                      children: [
                        Text(
                          faq['a']!,
                          style: ReCycloTypography.bodyMedium.copyWith(height: 1.45),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}
