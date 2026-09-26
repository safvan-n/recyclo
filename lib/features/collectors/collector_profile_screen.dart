import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/collector_model.dart';
import '../../data/repositories/waste_repository.dart';
import '../chat/chat_screen.dart';

/// Comprehensive Collector Profile Screen
class CollectorProfileScreen extends StatelessWidget {
  final CollectorModel collector;

  const CollectorProfileScreen({super.key, required this.collector});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: Text(collector.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Profile Header Card
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            collector.avatar,
                            width: 68,
                            height: 68,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 68,
                              height: 68,
                              color: ReCycloColors.primaryLight,
                              child: const Icon(Icons.person, size: 36, color: ReCycloColors.primary),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Text(
                                      collector.name,
                                      style: ReCycloTypography.headingMedium.copyWith(
                                        fontWeight: FontWeight.w800,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  StatusBadge(status: collector.availability),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                collector.agency,
                                style: ReCycloTypography.bodySmall.copyWith(
                                  color: ReCycloColors.textSecondary,
                                ),
                              ),
                              const SizedBox(height: 6),
                              if (collector.verified)
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                  decoration: BoxDecoration(
                                    color: ReCycloColors.primaryLight,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.verified_rounded, size: 13, color: ReCycloColors.primary),
                                      const SizedBox(width: 4),
                                      Text(
                                        'Verified Collector',
                                        style: TextStyle(
                                          color: ReCycloColors.primaryActive,
                                          fontSize: 10.5,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 18),
                    const Divider(height: 1, color: ReCycloColors.divider),
                    const SizedBox(height: 14),

                    // Quick Stats Row
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem('Rating', '⭐ ${collector.rating} (${collector.reviewCount})'),
                        Container(width: 1, height: 28, color: ReCycloColors.divider),
                        _buildStatItem('Collections', '${collector.completedCollections}+'),
                        Container(width: 1, height: 28, color: ReCycloColors.divider),
                        _buildStatItem('Distance', '${collector.distanceKm} km'),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Action Buttons Row (Message, Call)
              Row(
                children: [
                  Expanded(
                    child: SecondaryButton(
                      text: 'Message',
                      icon: const ReCycloIcon('chat', size: 18, color: ReCycloColors.primaryActive),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(collector: collector),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: SecondaryButton(
                      text: 'Call',
                      icon: const ReCycloIcon('phone', size: 18, color: ReCycloColors.primaryActive),
                      isOutlined: true,
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/call',
                          arguments: collector,
                        );
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Accepted Categories Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Accepted Waste Categories',
                      style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: collector.acceptedCategories.map((cat) {
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                          decoration: BoxDecoration(
                            color: ReCycloColors.primaryLight,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              ReCycloIcon(cat, size: 15, color: ReCycloColors.primaryActive, active: true),
                              const SizedBox(width: 6),
                              Text(
                                cat[0].toUpperCase() + cat.substring(1),
                                style: TextStyle(
                                  color: ReCycloColors.primaryActive,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Rate Card: ${collector.rateCard}',
                      style: ReCycloTypography.bodySmall.copyWith(
                        color: ReCycloColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Service Area & Hours Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Service Details',
                      style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.map_outlined, size: 18, color: ReCycloColors.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Area: ${collector.serviceArea}',
                            style: ReCycloTypography.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(Icons.access_time_rounded, size: 18, color: ReCycloColors.primary),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Working Hours: ${collector.workingHours}',
                            style: ReCycloTypography.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // About Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'About Collector',
                      style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      collector.about,
                      style: ReCycloTypography.bodyMedium.copyWith(height: 1.45),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 18),

              // Customer Reviews
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Customer Reviews (${collector.reviews.length})',
                      style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    const SizedBox(height: 12),
                    ...collector.reviews.map((r) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(r.author, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 13)),
                                Text(r.date, style: ReCycloTypography.bodySmall),
                              ],
                            ),
                            const SizedBox(height: 2),
                            Row(
                              children: List.generate(
                                r.rating,
                                (i) => const Icon(Icons.star_rounded, size: 14, color: Color(0xFFF59E0B)),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(r.text, style: ReCycloTypography.bodySmall.copyWith(color: ReCycloColors.textPrimary)),
                            const Divider(height: 16, color: ReCycloColors.divider),
                          ],
                        ),
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Bottom Request CTA
              PrimaryButton(
                text: 'Request Doorstep Pickup',
                onPressed: () {
                  context.read<WasteProvider>().setCollector(collector);
                  Navigator.of(context).pop();
                },
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13.5),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ReCycloTypography.bodySmall.copyWith(fontSize: 11),
        ),
      ],
    );
  }
}
