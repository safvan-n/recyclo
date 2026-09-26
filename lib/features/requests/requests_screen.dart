import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/empty_state.dart';
import '../../data/repositories/request_repository.dart';
import '../../shared/widgets/request_card.dart';
import '../../shared/widgets/custom_bottom_sheet.dart';
import '../tracking/live_tracking_screen.dart';

/// Requests Screen with Current & History tabs
class RequestsScreen extends StatefulWidget {
  final ValueChanged<int>? onTabChange;

  const RequestsScreen({super.key, this.onTabChange});

  @override
  State<RequestsScreen> createState() => _RequestsScreenState();
}

class _RequestsScreenState extends State<RequestsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showRequestDetails(BuildContext context, dynamic req) {
    CustomBottomSheet.show(
      context: context,
      title: 'Booking Details',
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                req.id,
                style: ReCycloTypography.headingLarge.copyWith(fontWeight: FontWeight.w800),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: ReCycloColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  req.status.toString().toUpperCase(),
                  style: TextStyle(
                    color: ReCycloColors.primaryActive,
                    fontWeight: FontWeight.w800,
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Waste Details', req.wasteType),
          _buildInfoRow('Quantity', req.quantity),
          _buildInfoRow('Collector', req.collectorName),
          _buildInfoRow('Phone', req.collectorPhone),
          _buildInfoRow('Pickup Schedule', '${req.scheduledDate} • ${req.scheduledTime}'),
          _buildInfoRow('Address', req.pickupAddress),
          _buildInfoRow('Payment Method', req.paymentMethod),
          _buildInfoRow('Amount', req.estimatedAmount, isHighlight: true),
          const SizedBox(height: 24),
          if (req.status != 'completed')
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => LiveTrackingScreen(request: req)),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: ReCycloColors.primary,
                foregroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 48),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              ),
              child: const Text('Open Live Tracker', style: TextStyle(fontWeight: FontWeight.w700)),
            ),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isHighlight = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 12.5, color: ReCycloColors.textMuted)),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              value,
              textAlign: TextAlign.right,
              style: TextStyle(
                fontWeight: isHighlight ? FontWeight.w800 : FontWeight.w600,
                fontSize: isHighlight ? 15 : 13,
                color: isHighlight ? ReCycloColors.primaryActive : ReCycloColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final requestRepo = context.watch<RequestProvider>();
    final activeRequest = requestRepo.activeRequest;
    final pastRequests = requestRepo.pastRequests;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('My Requests'),
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: ReCycloColors.primary,
          indicatorWeight: 3,
          labelColor: ReCycloColors.primaryActive,
          unselectedLabelColor: ReCycloColors.textSecondary,
          labelStyle: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
          tabs: [
            Tab(text: 'Current (${activeRequest != null ? 1 : 0})'),
            Tab(text: 'History (${pastRequests.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // Current Tab
          activeRequest == null
              ? EmptyState(
                  iconName: 'requests',
                  title: 'No active waste requests yet.',
                  description: 'Schedule a doorstep collection and turn your everyday recyclables into cash.',
                  buttonText: 'Add Waste',
                  onButtonPressed: () => widget.onTabChange?.call(2),
                )
              : ListView(
                  padding: const EdgeInsets.all(20),
                  children: [
                    RequestCard(
                      request: activeRequest,
                      onTap: () => _showRequestDetails(context, activeRequest),
                      onTrack: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => LiveTrackingScreen(request: activeRequest),
                          ),
                        );
                      },
                    ),
                  ],
                ),

          // History Tab
          pastRequests.isEmpty
              ? const EmptyState(
                  iconName: 'requests',
                  title: 'No Past Requests',
                  description: 'Your completed recycling collections will appear here.',
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: pastRequests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 14),
                  itemBuilder: (context, index) {
                    final req = pastRequests[index];
                    return RequestCard(
                      request: req,
                      onTap: () => _showRequestDetails(context, req),
                    );
                  },
                ),
        ],
      ),
    );
  }
}
