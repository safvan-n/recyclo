import 'package:flutter/material.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/empty_state.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../data/mock/mock_data.dart';
import '../../shared/widgets/custom_bottom_sheet.dart';

/// Payment History Screen
class PaymentHistoryScreen extends StatelessWidget {
  const PaymentHistoryScreen({super.key});

  void _showReceipt(BuildContext context, dynamic txn) {
    CustomBottomSheet.show(
      context: context,
      title: 'Payment Receipt',
      content: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: ReCycloColors.primaryLight,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                const ReCycloIcon('check', size: 28, color: ReCycloColors.primary, active: true),
                const SizedBox(height: 8),
                Text('Payment Credited', style: TextStyle(color: ReCycloColors.primaryActive, fontWeight: FontWeight.bold)),
                const SizedBox(height: 4),
                Text(txn.amount, style: ReCycloTypography.displayMedium.copyWith(fontWeight: FontWeight.w800, color: ReCycloColors.primaryActive)),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildRow('Transaction ID', txn.id),
          _buildRow('Reference', txn.reference),
          _buildRow('Collector', txn.collector),
          _buildRow('Waste Type', txn.wasteType),
          _buildRow('Payment Mode', txn.method),
          _buildRow('Date & Time', txn.date),
          _buildRow('Status', txn.status, isSuccess: true),
          const SizedBox(height: 20),
          OutlinedButton.icon(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Receipt downloaded as PDF (Simulated).'),
                  backgroundColor: ReCycloColors.primary,
                ),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: ReCycloColors.primaryActive,
              side: const BorderSide(color: ReCycloColors.primary),
              minimumSize: const Size(double.infinity, 44),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            icon: const Icon(Icons.download_rounded, size: 18),
            label: const Text('Download PDF Receipt', style: TextStyle(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }

  Widget _buildRow(String label, String value, {bool isSuccess = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 12.5, color: ReCycloColors.textMuted)),
          Text(
            value,
            style: TextStyle(
              fontWeight: isSuccess ? FontWeight.w800 : FontWeight.w600,
              fontSize: 13,
              color: isSuccess ? ReCycloColors.primaryActive : ReCycloColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final list = MockData.paymentHistory;

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        title: const Text('Payment History'),
      ),
      body: SafeArea(
        child: list.isEmpty
            ? const EmptyState(
                iconName: 'card',
                title: 'No Payment History',
                description: 'Completed payouts and cash receipts will be recorded here.',
              )
            : ListView.separated(
                padding: const EdgeInsets.all(20),
                itemCount: list.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final txn = list[index];
                  return InkWell(
                    onTap: () => _showReceipt(context, txn),
                    borderRadius: BorderRadius.circular(16),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: ReCycloColors.border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: ReCycloColors.primaryLight,
                              shape: BoxShape.circle,
                            ),
                            child: const ReCycloIcon('card', size: 20, color: ReCycloColors.primaryActive),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  txn.wasteType,
                                  style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  '${txn.collector} • ${txn.method}',
                                  style: ReCycloTypography.bodySmall,
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  txn.date,
                                  style: ReCycloTypography.bodySmall.copyWith(fontSize: 11, color: ReCycloColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                txn.amount,
                                style: ReCycloTypography.titleMedium.copyWith(
                                  fontWeight: FontWeight.w800,
                                  color: ReCycloColors.primaryActive,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: const Color(0xFFD1FAE5),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'Completed',
                                  style: TextStyle(
                                    color: Color(0xFF047857),
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
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
