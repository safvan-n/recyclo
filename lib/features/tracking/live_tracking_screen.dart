import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../core/widgets/status_badge.dart';
import '../../models/pickup_request_model.dart';
import '../../data/repositories/request_repository.dart';
import '../../data/repositories/collector_repository.dart';
import '../chat/chat_screen.dart';
import '../rating/rating_screen.dart';

/// Interactive Live Tracking Screen
class LiveTrackingScreen extends StatelessWidget {
  final PickupRequestModel? request;

  const LiveTrackingScreen({
    super.key,
    this.request,
  });

  @override
  Widget build(BuildContext context) {
    final requestRepo = context.watch<RequestProvider>();
    final liveReq = requestRepo.activeRequest ?? request;

    if (liveReq == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Live Tracking')),
        body: const Center(child: Text('No active request to track.')),
      );
    }

    final isCompleted = liveReq.status == 'completed';
    final collectorRepo = context.read<CollectorProvider>();
    final collector = collectorRepo.getById(liveReq.collectorId);

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: Text('Track ${liveReq.id}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Tracking link copied to clipboard.'),
                  backgroundColor: ReCycloColors.primary,
                ),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ETA Card (if not completed)
              if (!isCompleted) ...[
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ReCycloColors.brandDark, Color(0xFF00765C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Estimated Arrival',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.8),
                              fontSize: 12,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${liveReq.etaMinutes} Minutes',
                            style: ReCycloTypography.headingLarge.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w800,
                              fontSize: 24,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Collector is in transit to your address',
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.85),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.15),
                          shape: BoxShape.circle,
                        ),
                        child: const Center(
                          child: ReCycloIcon('truck', size: 26, color: Colors.white, active: true),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ] else ...[
                // Completed Banner
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: ReCycloColors.primaryLight,
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: ReCycloColors.primary.withValues(alpha: 0.3)),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: ReCycloColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.check, color: Colors.white, size: 20),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Collection Completed!',
                              style: ReCycloTypography.titleMedium.copyWith(
                                color: ReCycloColors.brandDark,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${liveReq.estimatedAmount} credited via ${liveReq.paymentMethod}.',
                              style: ReCycloTypography.bodySmall,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
              ],

              // Collector Quick Contact Bar
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        liveReq.collectorAvatar,
                        width: 46,
                        height: 46,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 46,
                          height: 46,
                          color: ReCycloColors.primaryLight,
                          child: const Icon(Icons.person, color: ReCycloColors.primary),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            liveReq.collectorName,
                            style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            liveReq.collectorPhone,
                            style: ReCycloTypography.bodySmall,
                          ),
                        ],
                      ),
                    ),
                    IconButton.filledTonal(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => ChatScreen(
                              collector: collector,
                              activeRequest: liveReq,
                            ),
                          ),
                        );
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: ReCycloColors.primaryLight,
                      ),
                      icon: const ReCycloIcon('chat', size: 18, color: ReCycloColors.primaryActive),
                    ),
                    const SizedBox(width: 8),
                    IconButton.filledTonal(
                      onPressed: () {
                        Navigator.of(context).pushNamed(
                          '/call',
                          arguments: collector,
                        );
                      },
                      style: IconButton.styleFrom(
                        backgroundColor: ReCycloColors.primaryLight,
                      ),
                      icon: const ReCycloIcon('phone', size: 18, color: ReCycloColors.primaryActive),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Tracking Stages Timeline Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Live Progress',
                          style: ReCycloTypography.headingMedium.copyWith(fontWeight: FontWeight.w700),
                        ),
                        StatusBadge(status: liveReq.status),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Stage Items
                    ...List.generate(liveReq.stages.length, (index) {
                      final stage = liveReq.stages[index];
                      final isLast = index == liveReq.stages.length - 1;

                      return _buildTimelineItem(
                        stage: stage,
                        isLast: isLast,
                      );
                    }),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Demo Status Progression Controller
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.tune_rounded, size: 18, color: ReCycloColors.primary),
                            const SizedBox(width: 6),
                            Text(
                              'Demo Simulator',
                              style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                        Text(
                          'Simulation Tool',
                          style: TextStyle(
                            fontSize: 10,
                            color: ReCycloColors.textMuted,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Advance the live tracking lifecycle step-by-step to test real-world status updates.',
                      style: ReCycloTypography.bodySmall,
                    ),
                    const SizedBox(height: 12),
                    PrimaryButton(
                      text: isCompleted ? 'Reset Demo Progression' : 'Advance to Next Stage ⏩',
                      backgroundColor: isCompleted ? ReCycloColors.brandDark : ReCycloColors.primary,
                      height: 44,
                      onPressed: () {
                        requestRepo.advanceStatus();
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // If Completed -> Rate Experience Button
              if (isCompleted) ...[
                PrimaryButton(
                  text: 'Rate Collector Experience ⭐',
                  icon: const Icon(Icons.star_outline_rounded),
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => RatingScreen(
                          collectorName: liveReq.collectorName,
                          requestId: liveReq.id,
                        ),
                      ),
                    );
                  },
                ),
                const SizedBox(height: 14),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimelineItem({
    required TrackingStage stage,
    required bool isLast,
  }) {
    Color dotColor = stage.done ? ReCycloColors.primary : ReCycloColors.border;
    Color lineColor = stage.done ? ReCycloColors.primary : ReCycloColors.divider;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon and connecting vertical line
          Column(
            children: [
              Container(
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: stage.done ? dotColor : Colors.white,
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: dotColor,
                    width: 2.0,
                  ),
                ),
                child: stage.done
                    ? const Center(
                        child: Icon(Icons.check, size: 12, color: Colors.white),
                      )
                    : (stage.current
                        ? Center(
                            child: Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: ReCycloColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          )
                        : null),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 2,
                    color: lineColor,
                    margin: const EdgeInsets.symmetric(vertical: 4),
                  ),
                ),
            ],
          ),
          const SizedBox(width: 14),

          // Label & Timestamp
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    stage.label,
                    style: TextStyle(
                      fontWeight: stage.current ? FontWeight.w800 : (stage.done ? FontWeight.w600 : FontWeight.w500),
                      color: stage.done ? ReCycloColors.textPrimary : ReCycloColors.textMuted,
                      fontSize: 13.5,
                    ),
                  ),
                  Text(
                    stage.time,
                    style: TextStyle(
                      fontSize: 11,
                      color: stage.current ? ReCycloColors.primaryActive : ReCycloColors.textMuted,
                      fontWeight: stage.current ? FontWeight.w700 : FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
