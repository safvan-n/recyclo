import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/constants/colors.dart';
import '../../core/theme/typography.dart';
import '../../core/widgets/recyclo_icons.dart';
import '../../data/repositories/chat_repository.dart';
import '../../data/repositories/request_repository.dart';
import '../../models/collector_model.dart';
import '../../models/pickup_request_model.dart';

/// Chat Screen with collector
class ChatScreen extends StatefulWidget {
  final CollectorModel? collector;
  final PickupRequestModel? activeRequest;

  const ChatScreen({
    super.key,
    this.collector,
    this.activeRequest,
  });

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _textController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _textController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  void _sendMessage(ChatProvider chat) {
    final text = _textController.text.trim();
    if (text.isEmpty) return;

    chat.sendMessage(text);
    _textController.clear();
    _scrollToBottom();
  }

  void _sharePickupDetails(ChatProvider chat, PickupRequestModel? req) {
    final details = {
      'requestId': req?.id ?? 'REQ-8492',
      'wasteType': req?.wasteType ?? 'Plastic & Paper Scrap',
      'quantity': req?.quantity ?? '8.5 kg',
      'address': req?.pickupAddress ?? '402 Oakwood Heights, Bengaluru',
      'time': '${req?.scheduledDate ?? 'Today'}, ${req?.scheduledTime ?? '02:00 PM'}',
    };

    chat.sendMessage(
      'Shared doorstep pickup details with collector.',
      isPickupDetails: true,
      pickupDetails: details,
    );
    _scrollToBottom();
  }

  @override
  Widget build(BuildContext context) {
    final chat = context.watch<ChatProvider>();
    final requestRepo = context.watch<RequestProvider>();
    final activeReq = widget.activeRequest ?? requestRepo.activeRequest;
    final collectorName = widget.collector?.name ?? activeReq?.collectorName ?? 'Rajesh Kumar';
    final collectorAvatar = widget.collector?.avatar ?? activeReq?.collectorAvatar ?? 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150&auto=format&fit=crop&q=80';

    return Scaffold(
      backgroundColor: ReCycloColors.bgApp,
      appBar: AppBar(
        titleSpacing: 0,
        title: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                collectorAvatar,
                width: 36,
                height: 36,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 36,
                  height: 36,
                  color: ReCycloColors.primaryLight,
                  child: const Icon(Icons.person, color: ReCycloColors.primary, size: 20),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    collectorName,
                    style: ReCycloTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                  ),
                  Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: const BoxDecoration(
                          color: Color(0xFF10B981),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 5),
                      Text(
                        'Online • Assigned Collector',
                        style: ReCycloTypography.bodySmall.copyWith(fontSize: 10.5),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const ReCycloIcon('phone', size: 18, color: ReCycloColors.textPrimary),
            onPressed: () {
              Navigator.of(context).pushNamed(
                '/call',
                arguments: widget.collector,
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // "Share Pickup Details" Quick Action Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              color: Colors.white,
              child: Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _sharePickupDetails(chat, activeReq),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: ReCycloColors.primaryActive,
                        side: const BorderSide(color: ReCycloColors.primary),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                      ),
                      icon: const Icon(Icons.share_location_rounded, size: 16),
                      label: const Text(
                        'Share Pickup Details Card',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: ReCycloColors.divider),

            // Chat Messages List
            Expanded(
              child: ListView.builder(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                itemCount: chat.messages.length,
                itemBuilder: (context, index) {
                  final msg = chat.messages[index];
                  return _buildMessageBubble(msg);
                },
              ),
            ),

            // Message Composer Input
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: const BoxDecoration(
                color: Colors.white,
                border: Border(top: BorderSide(color: ReCycloColors.border)),
              ),
              child: Row(
                children: [
                  IconButton(
                    icon: const ReCycloIcon('camera', size: 20, color: ReCycloColors.textMuted),
                    onPressed: () {
                      chat.sendMessage(
                        'Attached photo of scrap bags in the lobby.',
                        imageUrl: 'https://images.unsplash.com/photo-1530587191325-3db32d826c18?w=400&auto=format&fit=crop&q=80',
                      );
                      _scrollToBottom();
                    },
                    tooltip: 'Share Photo',
                  ),
                  Expanded(
                    child: TextField(
                      controller: _textController,
                      style: const TextStyle(fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'Discuss waste, quantity or ETA...',
                        hintStyle: TextStyle(color: ReCycloColors.textMuted, fontSize: 13.5),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                        filled: true,
                        fillColor: ReCycloColors.bgApp,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(24),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(chat),
                    ),
                  ),
                  const SizedBox(width: 8),
                  IconButton.filled(
                    onPressed: () => _sendMessage(chat),
                    style: IconButton.styleFrom(
                      backgroundColor: ReCycloColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    icon: const Icon(Icons.send_rounded, size: 18),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(dynamic msg) {
    final isUser = msg.isUser;

    if (msg.isPickupDetails && msg.pickupDetails != null) {
      // Structured Pickup Summary Card inside Chat
      final pd = msg.pickupDetails as Map<String, dynamic>;
      return Align(
        alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 280,
          margin: const EdgeInsets.symmetric(vertical: 8),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: ReCycloColors.primary, width: 1.5),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1000A884),
                blurRadius: 8,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const ReCycloIcon('truck', size: 18, color: ReCycloColors.primary, active: true),
                  const SizedBox(width: 8),
                  Text(
                    'Pickup Summary Card',
                    style: ReCycloTypography.titleMedium.copyWith(
                      color: ReCycloColors.primaryActive,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              const Divider(height: 16, color: ReCycloColors.divider),
              _buildDetailRow('Booking ID', pd['requestId'] ?? ''),
              _buildDetailRow('Waste Type', pd['wasteType'] ?? ''),
              _buildDetailRow('Quantity', pd['quantity'] ?? ''),
              _buildDetailRow('Time', pd['time'] ?? ''),
              _buildDetailRow('Location', pd['address'] ?? ''),
              const SizedBox(height: 6),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  msg.time,
                  style: const TextStyle(fontSize: 10, color: ReCycloColors.textMuted),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Align(
      alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.78),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
        decoration: BoxDecoration(
          color: isUser ? ReCycloColors.primary : Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isUser ? 16 : 4),
            bottomRight: Radius.circular(isUser ? 4 : 16),
          ),
          border: isUser ? null : Border.all(color: ReCycloColors.border),
        ),
        child: Column(
          crossAxisAlignment: isUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            if (msg.imageUrl != null) ...[
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  msg.imageUrl!,
                  height: 140,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
            ],
            Text(
              msg.text,
              style: TextStyle(
                color: isUser ? Colors.white : ReCycloColors.textPrimary,
                fontSize: 13.5,
                height: 1.35,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              msg.time,
              style: TextStyle(
                color: isUser ? Colors.white.withValues(alpha: 0.7) : ReCycloColors.textMuted,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 75,
            child: Text(label, style: const TextStyle(fontSize: 11, color: ReCycloColors.textMuted)),
          ),
          Expanded(
            child: Text(value, style: const TextStyle(fontSize: 11.5, fontWeight: FontWeight.w600)),
          ),
        ],
      ),
    );
  }
}
