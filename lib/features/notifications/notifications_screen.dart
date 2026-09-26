import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../data/repositories/notification_repository.dart';
import '../payment/payment_history_screen.dart';
import '../rating/rating_screen.dart';

/// Notifications Center Screen
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final notifRepo = context.watch<NotificationProvider>();
    final list = notifRepo.notifications;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Notifications'),
        actions: [
          if (list.isNotEmpty)
            TextButton(
              onPressed: () => notifRepo.markAllAsRead(),
              child: const Text('Mark all read', style: TextStyle(color: ReCycloColors.primaryActive, fontSize: 12)),
            ),
        ],
      ),
      body: SafeArea(
        child: list.isEmpty
            ? const EmptyState(
                iconName: 'bell',
                title: 'No Notifications',
                description: 'You are all caught up! Updates regarding your pickups will appear here.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: list.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final notif = list[index];
                  return InkWell(
                    onTap: () {
                      notifRepo.markAsRead(notif.id);
                      if (notif.actionScreen == 'payment-history') {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const PaymentHistoryScreen()),
                        );
                      } else if (notif.actionScreen == 'rating') {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const RatingScreen(
                              collectorName: 'Priya Sharma',
                              requestId: 'REQ-8120',
                            ),
                          ),
                        );
                      }
                    },
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: notif.unread ? ReCycloColors.primary.withValues(alpha: 0.4) : ReCycloColors.border,
                          width: notif.unread ? 1.5 : 1.0,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: notif.unread ? ReCycloColors.primaryLight : ReCycloColors.bgApp,
                              shape: BoxShape.circle,
                            ),
                            child: ReCycloIcon(
                              notif.type,
                              size: 20,
                              color: notif.unread ? ReCycloColors.primaryActive : ReCycloColors.textSecondary,
                              active: notif.unread,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        notif.title,
                                        style: TextStyle(
                                          fontWeight: notif.unread ? FontWeight.w800 : FontWeight.w600,
                                          fontSize: 14,
                                          color: ReCycloColors.textPrimary,
                                        ),
                                      ),
                                    ),
                                    Text(
                                      notif.time,
                                      style: ReCycloTypography.bodySmall.copyWith(fontSize: 11),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  notif.desc,
                                  style: ReCycloTypography.bodySmall.copyWith(
                                    color: ReCycloColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (notif.unread) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 8,
                              height: 8,
                              decoration: const BoxDecoration(
                                color: ReCycloColors.primary,
                                shape: BoxShape.circle,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
    );
  }
}
