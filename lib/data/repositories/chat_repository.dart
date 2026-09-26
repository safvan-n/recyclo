import 'package:flutter/foundation.dart';
import '../../models/message_model.dart';
import '../mock/mock_data.dart';

/// Chat Repository & Messaging Provider
class ChatProvider extends ChangeNotifier {
  final List<ChatMessage> _messages = List.from(MockData.initialChatHistory);

  List<ChatMessage> get messages => _messages;

  void sendMessage(
    String text, {
    bool isPickupDetails = false,
    Map<String, dynamic>? pickupDetails,
    String? imageUrl,
  }) {
    final newMsg = ChatMessage(
      id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
      sender: 'user',
      text: text,
      time: 'Just now',
      isPickupDetails: isPickupDetails,
      pickupDetails: pickupDetails,
      imageUrl: imageUrl,
    );

    _messages.add(newMsg);
    notifyListeners();

    // Simulated realistic collector response
    if (!isPickupDetails && imageUrl == null) {
      Future.delayed(const Duration(milliseconds: 1400), () {
        _simulateCollectorReply(text);
      });
    } else if (isPickupDetails) {
      Future.delayed(const Duration(milliseconds: 1200), () {
        _messages.add(
          ChatMessage(
            id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
            sender: 'collector',
            text: 'Got your pickup details! Everything looks good. I will be there as scheduled.',
            time: 'Just now',
          ),
        );
        notifyListeners();
      });
    }
  }

  void _simulateCollectorReply(String userText) {
    String reply;
    final lower = userText.toLowerCase();

    if (lower.contains('scale') || lower.contains('weigh')) {
      reply = 'Yes, I bring a certified digital scale and will show you the exact reading before confirming the payout!';
    } else if (lower.contains('when') || lower.contains('time') || lower.contains('reach')) {
      reply = 'I am currently on my way and should arrive right on time according to the GPS route.';
    } else if (lower.contains('rate') || lower.contains('price') || lower.contains('pay')) {
      reply = 'Our rates are fixed as per standard municipal board guidelines. Payout is processed instantly on the spot via UPI or Cash!';
    } else {
      reply = 'Understood! Looking forward to helping you recycle your waste responsibly.';
    }

    _messages.add(
      ChatMessage(
        id: 'msg-${DateTime.now().millisecondsSinceEpoch}',
        sender: 'collector',
        text: reply,
        time: 'Just now',
      ),
    );
    notifyListeners();
  }
}
