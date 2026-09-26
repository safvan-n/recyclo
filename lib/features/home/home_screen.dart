import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/strings.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/repositories/waste_repository.dart';
import '../../data/repositories/collector_repository.dart';
import '../../data/repositories/request_repository.dart';
import '../../data/repositories/notification_repository.dart';
import '../../shared/widgets/collector_card.dart';
import '../../shared/widgets/request_card.dart';
import '../collectors/collector_profile_screen.dart';
import '../tracking/live_tracking_screen.dart';
import '../notifications/notifications_screen.dart';

/// Home Dashboard Screen
class HomeScreen extends StatelessWidget {
  final ValueChanged<int>? onTabChange;

  const HomeScreen({
    super.key,
    this.onTabChange,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthProvider>().currentUser;
    final wasteProvider = context.watch<WasteProvider>();
    final collectorProvider = context.watch<CollectorProvider>();
    final requestProvider = context.watch<RequestProvider>();
    final notifProvider = context.watch<NotificationProvider>();

    final firstName = user?.name.split(' ').first ?? 'Friend';
    final activeRequest = requestProvider.activeRequest;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      body: SafeArea(
        child: RefreshIndicator(
          color: ReCycloColors.primary,
          onRefresh: () async {
            await Future.delayed(const Duration(milliseconds: 500));
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Header Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Hello, $firstName 👋',
                              style: ReCycloTypography.headingLarge.copyWith(
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 2),
                        Text(
                          "Let's make your waste useful today.",
                          style: ReCycloTypography.bodyMedium,
                        ),
                      ],
                    ),

                    // Notification Bell with Badge
                    Stack(
                      children: [
                        IconButton.filledTonal(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => const NotificationsScreen()),
                            );
                          },
                          style: IconButton.styleFrom(
                            backgroundColor: Colors.white,
                            side: const BorderSide(color: ReCycloColors.border),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                          icon: const ReCycloIcon('bell', size: 20, color: ReCycloColors.textPrimary),
                        ),
                        if (notifProvider.unreadCount > 0)
                          Positioned(
                            top: 6,
                            right: 6,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: ReCycloColors.danger,
                                shape: BoxShape.circle,
                              ),
                              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                              child: Center(
                                child: Text(
                                  '${notifProvider.unreadCount}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 20),

                // Main CTA Banner: "Add Your Waste"
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [ReCycloColors.brandDark, Color(0xFF00765C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x2000A884),
                        blurRadius: 16,
                        offset: Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                const ReCycloIcon('truck', size: 14, color: Colors.white, active: true),
                                const SizedBox(width: 6),
                                Text(
                                  'Doorstep Pickup',
                                  style: ReCycloTypography.labelSmall.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Text(
                            ReCycloStrings.demoCalculation,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.6),
                              fontSize: 10,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Text(
                        'Ready to Recycle?',
                        style: ReCycloTypography.headingLarge.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        'Connect with certified local collectors and get instant cash/UPI payouts.',
                        style: ReCycloTypography.bodyMedium.copyWith(
                          color: Colors.white.withValues(alpha: 0.85),
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (onTabChange != null) {
                            onTabChange!(2); // Switch to Add Waste tab
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: ReCycloColors.primaryActive,
                          elevation: 0,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        ),
                        icon: const ReCycloIcon('plus', size: 18, color: ReCycloColors.primaryActive),
                        label: Text(
                          'Add Your Waste',
                          style: ReCycloTypography.titleMedium.copyWith(
                            color: ReCycloColors.primaryActive,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 22),

                // Waste Insights Stats Row
                _buildWasteInsights(user?.stats),
                const SizedBox(height: 24),

                // Quick Action Buttons Row
                Row(
                  children: [
                    _buildQuickAction(
                      icon: 'add-waste',
                      label: 'Add Waste',
                      onTap: () => onTabChange?.call(2),
                    ),
                    const SizedBox(width: 10),
                    _buildQuickAction(
                      icon: 'collectors',
                      label: 'Collectors',
                      onTap: () => onTabChange?.call(3),
                    ),
                    const SizedBox(width: 10),
                    _buildQuickAction(
                      icon: 'requests',
                      label: 'My Requests',
                      onTap: () => onTabChange?.call(1),
                    ),
                    const SizedBox(width: 10),
                    _buildQuickAction(
                      icon: 'card',
                      label: 'Payments',
                      onTap: () => onTabChange?.call(4),
                    ),
                  ],
                ),
                const SizedBox(height: 26),

                // Active Request Section (if available)
                if (activeRequest != null) ...[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Active Request',
                        style: ReCycloTypography.headingMedium.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => LiveTrackingScreen(request: activeRequest),
                            ),
                          );
                        },
                        child: Text(
                          'Track Live',
                          style: ReCycloTypography.labelSmall.copyWith(
                            color: ReCycloColors.primaryActive,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  RequestCard(
                    request: activeRequest,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LiveTrackingScreen(request: activeRequest),
                        ),
                      );
                    },
                    onTrack: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => LiveTrackingScreen(request: activeRequest),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                ],

                // Waste Categories Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Waste Categories',
                      style: ReCycloTypography.headingMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'Average Rates',
                      style: ReCycloTypography.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SizedBox(
                  height: 124,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: wasteProvider.categories.length,
                    separatorBuilder: (context, index) => const SizedBox(width: 12),
                    itemBuilder: (context, index) {
                      final cat = wasteProvider.categories[index];
                      return _buildCategoryCard(
                        category: cat,
                        onTap: () {
                          wasteProvider.setCategory(cat);
                          onTabChange?.call(2); // Jump to Add Waste
                        },
                      );
                    },
                  ),
                ),
                const SizedBox(height: 26),

                // Nearby Collectors Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Nearby Collectors',
                      style: ReCycloTypography.headingMedium.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextButton(
                      onPressed: () => onTabChange?.call(3),
                      child: Text(
                        'View All',
                        style: ReCycloTypography.labelSmall.copyWith(
                          color: ReCycloColors.primaryActive,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: collectorProvider.allCollectors.take(2).length,
                  separatorBuilder: (context, index) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final collector = collectorProvider.allCollectors[index];
                    return CollectorCard(
                      collector: collector,
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => CollectorProfileScreen(collector: collector),
                          ),
                        );
                      },
                      onMessage: () {
                        Navigator.of(context).pushNamed('/chat');
                      },
                      onCall: () {
                        Navigator.of(context).pushNamed(
                          '/call',
                          arguments: collector,
                        );
                      },
                      onRequestPickup: () {
                        wasteProvider.setCollector(collector);
                        onTabChange?.call(2);
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWasteInsights(dynamic stats) {
    final recycled = stats?.totalRecycledKg ?? 54.2;
    final earned = stats?.moneyEarned ?? '₹975.00';
    final co2 = stats?.co2SavedKg ?? 81.3;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: ReCycloColors.border),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildStatItem('Recycled', '$recycled kg', 'plastic'),
          Container(width: 1, height: 32, color: ReCycloColors.divider),
          _buildStatItem('Earned', earned, 'cash'),
          Container(width: 1, height: 32, color: ReCycloColors.divider),
          _buildStatItem('CO2 Saved', '$co2 kg', 'other'),
        ],
      ),
    );
  }

  Widget _buildStatItem(String label, String value, String icon) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            ReCycloIcon(icon, size: 14, color: ReCycloColors.primaryActive, active: true),
            const SizedBox(width: 4),
            Text(
              value,
              style: ReCycloTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w800,
                fontSize: 14,
              ),
            ),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: ReCycloTypography.bodySmall.copyWith(fontSize: 11),
        ),
      ],
    );
  }

  Widget _buildQuickAction({
    required String icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: ReCycloColors.border),
          ),
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: ReCycloColors.primaryLight,
                  shape: BoxShape.circle,
                ),
                child: ReCycloIcon(icon, size: 18, color: ReCycloColors.primaryActive),
              ),
              const SizedBox(height: 6),
              Text(
                label,
                style: ReCycloTypography.labelSmall.copyWith(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  color: ReCycloColors.textPrimary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryCard({
    required dynamic category,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        width: 108,
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ReCycloColors.border),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: const BoxDecoration(
                color: ReCycloColors.primaryLight,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: ReCycloIcon(category.icon, size: 22, color: ReCycloColors.primary, active: true),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              category.name,
              style: ReCycloTypography.labelSmall.copyWith(
                fontWeight: FontWeight.w700,
                color: ReCycloColors.textPrimary,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              category.avgRate,
              style: ReCycloTypography.bodySmall.copyWith(
                fontSize: 10,
                color: ReCycloColors.primaryActive,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
