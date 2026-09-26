import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/collector_model.dart';

/// Reusable Collector Card Component
class CollectorCard extends StatelessWidget {
  final CollectorModel collector;
  final VoidCallback? onTap;
  final VoidCallback? onMessage;
  final VoidCallback? onCall;
  final VoidCallback? onRequestPickup;

  const CollectorCard({
    super.key,
    required this.collector,
    this.onTap,
    this.onMessage,
    this.onCall,
    this.onRequestPickup,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: ReCycloColors.border, width: 1.2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(18),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row: Avatar + Name + Rating + Status
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar with verified badge
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(14),
                          child: Image.network(
                            collector.avatar,
                            width: 54,
                            height: 54,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 54,
                              height: 54,
                              color: ReCycloColors.primaryLight,
                              child: const Center(
                                child: ReCycloIcon('user', size: 28, color: ReCycloColors.primary),
                              ),
                            ),
                          ),
                        ),
                        if (collector.verified)
                          Positioned(
                            bottom: -2,
                            right: -2,
                            child: Container(
                              padding: const EdgeInsets.all(2),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: Container(
                                padding: const EdgeInsets.all(3),
                                decoration: const BoxDecoration(
                                  color: ReCycloColors.primary,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(Icons.check, size: 10, color: Colors.white),
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(width: 14),

                    // Name + Agency + Distance
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  collector.name,
                                  style: ReCycloTypography.titleMedium.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              StatusBadge(status: collector.availability),
                            ],
                          ),
                          const SizedBox(height: 3),
                          Text(
                            collector.agency,
                            style: ReCycloTypography.bodySmall.copyWith(
                              color: ReCycloColors.textSecondary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              // Rating
                              const Icon(Icons.star_rounded, size: 16, color: Color(0xFFF59E0B)),
                              const SizedBox(width: 3),
                              Text(
                                collector.rating.toStringAsFixed(1),
                                style: ReCycloTypography.labelSmall.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: ReCycloColors.textPrimary,
                                ),
                              ),
                              Text(
                                ' (${collector.reviewCount})',
                                style: ReCycloTypography.bodySmall,
                              ),
                              const SizedBox(width: 8),
                              const Text('•', style: TextStyle(color: ReCycloColors.textMuted)),
                              const SizedBox(width: 8),
                              // Distance
                              const Icon(Icons.location_on_outlined, size: 14, color: ReCycloColors.textMuted),
                              const SizedBox(width: 2),
                              Text(
                                '${collector.distanceKm} km away',
                                style: ReCycloTypography.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: ReCycloColors.divider),
                const SizedBox(height: 12),

                // Accepted categories tags
                Wrap(
                  spacing: 6,
                  runSpacing: 6,
                  children: collector.acceptedCategories.map((cat) {
                    return Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: ReCycloColors.bgApp,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ReCycloIcon(cat, size: 13, color: ReCycloColors.primaryActive),
                          const SizedBox(width: 4),
                          Text(
                            cat[0].toUpperCase() + cat.substring(1),
                            style: ReCycloTypography.bodySmall.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w600,
                              color: ReCycloColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 14),

                // Actions row
                Row(
                  children: [
                    if (onMessage != null) ...[
                      OutlinedButton(
                        onPressed: onMessage,
                        style: OutlinedButton.styleFrom(
                          foregroundColor: ReCycloColors.textPrimary,
                          side: const BorderSide(color: ReCycloColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          minimumSize: const Size(0, 36),
                        ),
                        child: const Row(
                          children: [
                            ReCycloIcon('chat', size: 16, color: ReCycloColors.textSecondary),
                            SizedBox(width: 6),
                            Text('Message', style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    if (onCall != null) ...[
                      IconButton.outlined(
                        onPressed: onCall,
                        style: IconButton.styleFrom(
                          side: const BorderSide(color: ReCycloColors.border),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.all(8),
                          minimumSize: const Size(36, 36),
                        ),
                        icon: const ReCycloIcon('phone', size: 16, color: ReCycloColors.textSecondary),
                        tooltip: 'Call Collector',
                      ),
                      const SizedBox(width: 8),
                    ],
                    const Spacer(),
                    ElevatedButton(
                      onPressed: onRequestPickup ?? onTap,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ReCycloColors.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                        minimumSize: const Size(0, 36),
                      ),
                      child: const Text(
                        'Request Pickup',
                        style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
