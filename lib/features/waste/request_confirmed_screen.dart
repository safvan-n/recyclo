import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/custom_buttons.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../models/collector_model.dart';
import '../../models/waste_category_model.dart';
import '../../app/routes.dart';
import '../chat/chat_screen.dart';

/// Booking Confirmation Celebration Screen
class RequestConfirmedScreen extends StatefulWidget {
  final CollectorModel collector;
  final WasteCategory category;
  final String quantity;
  final String date;
  final String time;
  final String address;
  final String paymentMethod;
  final String estimatedAmount;

  const RequestConfirmedScreen({
    super.key,
    required this.collector,
    required this.category,
    required this.quantity,
    required this.date,
    required this.time,
    required this.address,
    required this.paymentMethod,
    required this.estimatedAmount,
  });

  @override
  State<RequestConfirmedScreen> createState() => _RequestConfirmedScreenState();
}

class _RequestConfirmedScreenState extends State<RequestConfirmedScreen> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _scaleAnim = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Animated Success Check Circle
              ScaleTransition(
                scale: _scaleAnim,
                child: Container(
                  width: 84,
                  height: 84,
                  decoration: BoxDecoration(
                    color: ReCycloColors.primary,
                    shape: BoxShape.circle,
                    boxShadow: const [
                      BoxShadow(
                        color: ReCycloColors.primaryGlow,
                        blurRadius: 20,
                        offset: Offset(0, 8),
                      ),
                    ],
                  ),
                  child: const Center(
                    child: ReCycloIcon('check', size: 40, color: Colors.white, active: true),
                  ),
                ),
              ),
              const SizedBox(height: 24),

              Text(
                'Pickup Request Confirmed!',
                style: ReCycloTypography.displayMedium.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                'Your request has been dispatched to ${widget.collector.name}. You can track collector progress live.',
                style: ReCycloTypography.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 28),

              // Summary Breakdown Card
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: ReCycloColors.bgApp,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: ReCycloColors.border),
                ),
                child: Column(
                  children: [
                    _buildRow('Assigned Collector', widget.collector.name, isBold: true),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Waste Category', widget.category.name),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Approx. Quantity', widget.quantity),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Scheduled Time', '${widget.date} at ${widget.time}'),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Pickup Address', widget.address),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Payout Method', widget.paymentMethod),
                    const Divider(height: 20, color: ReCycloColors.divider),
                    _buildRow('Estimated Payout', widget.estimatedAmount, isHighlight: true),
                  ],
                ),
              ),
              const SizedBox(height: 32),

              // Actions
              PrimaryButton(
                text: 'Track Live Request',
                icon: const Icon(Icons.navigation_outlined, size: 18),
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.main,
                    (route) => false,
                  );
                },
              ),
              const SizedBox(height: 12),

              SecondaryButton(
                text: 'Message Collector',
                icon: const ReCycloIcon('chat', size: 18, color: ReCycloColors.primaryActive),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(collector: widget.collector),
                    ),
                  );
                },
              ),
              const SizedBox(height: 12),

              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    AppRoutes.main,
                    (route) => false,
                  );
                },
                child: Text(
                  'Back to Home',
                  style: ReCycloTypography.titleMedium.copyWith(
                    color: ReCycloColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isBold = false, bool isHighlight = false}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: ReCycloTypography.bodySmall.copyWith(
            color: ReCycloColors.textMuted,
            fontSize: 12.5,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            value,
            textAlign: TextAlign.right,
            style: ReCycloTypography.bodyMedium.copyWith(
              fontWeight: (isBold || isHighlight) ? FontWeight.w800 : FontWeight.w600,
              color: isHighlight ? ReCycloColors.primaryActive : ReCycloColors.textPrimary,
              fontSize: isHighlight ? 15 : 13,
            ),
          ),
        ),
      ],
    );
  }
}
