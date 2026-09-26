import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/pickup_request_model.dart';

/// Reusable Request Card
class RequestCard extends StatelessWidget {
  final PickupRequestModel request;
  final VoidCallback? onTap;
  final VoidCallback? onTrack;

  const RequestCard({
    super.key,
    required this.request,
    this.onTap,
    this.onTrack,
  });

  @override
  Widget build(BuildContext context) {
    final isLive = request.status == 'on_the_way' || request.status == 'scheduled' || request.status == 'accepted' || request.status == 'placed';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: isLive ? ReCycloColors.primary.withValues(alpha: 0.35) : ReCycloColors.border,
          width: isLive ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: isLive ? ReCycloColors.primary.withValues(alpha: 0.08) : const Color(0x08000000),
            blurRadius: 12,
            offset: const Offset(0, 4),
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
                // Top row: ID + Status badge
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: ReCycloColors.primaryLight,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: ReCycloIcon(
                            request.wasteCategory.isNotEmpty ? request.wasteCategory : 'requests',
                            size: 16,
                            color: ReCycloColors.primaryActive,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          request.id,
                          style: ReCycloTypography.titleMedium.copyWith(
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ],
                    ),
                    StatusBadge(status: request.status),
                  ],
                ),

                const SizedBox(height: 12),

                // Waste Type & Quantity
                Text(
                  request.wasteType,
                  style: ReCycloTypography.titleMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),

                // Collector details & Schedule
                Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.network(
                        request.collectorAvatar,
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 26,
                          height: 26,
                          color: ReCycloColors.primaryLight,
                          child: const Icon(Icons.person, size: 16, color: ReCycloColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        request.collectorName,
                        style: ReCycloTypography.bodyMedium.copyWith(
                          color: ReCycloColors.textPrimary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${request.scheduledDate} • ${request.scheduledTime}',
                      style: ReCycloTypography.bodySmall,
                    ),
                  ],
                ),

                const SizedBox(height: 12),
                const Divider(height: 1, color: ReCycloColors.divider),
                const SizedBox(height: 12),

                // Bottom row: Estimated amount + Action
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Estimated Payout',
                          style: ReCycloTypography.bodySmall.copyWith(fontSize: 11),
                        ),
                        Text(
                          request.estimatedAmount,
                          style: ReCycloTypography.titleMedium.copyWith(
                            color: ReCycloColors.primaryActive,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                    if (isLive)
                      ElevatedButton.icon(
                        onPressed: onTrack ?? onTap,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: ReCycloColors.primary,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          minimumSize: const Size(0, 36),
                        ),
                        icon: const Icon(Icons.navigation_outlined, size: 14),
                        label: const Text(
                          'Live Track',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w700),
                        ),
                      )
                    else
                      TextButton.icon(
                        onPressed: onTap,
                        style: TextButton.styleFrom(
                          foregroundColor: ReCycloColors.primary,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                        ),
                        icon: const Icon(Icons.receipt_long_outlined, size: 16),
                        label: const Text(
                          'Receipt',
                          style: TextStyle(fontSize: 12.5, fontWeight: FontWeight.w600),
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
