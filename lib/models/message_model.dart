/// Chat message model
class ChatMessage {
  final String id;
  final String sender; // 'collector' | 'user'
  final String text;
  final String time;
  final bool isPickupDetails;
  final Map<String, dynamic>? pickupDetails;
  final String? imageUrl;

  const ChatMessage({
    required this.id,
    required this.sender,
    required this.text,
    required this.time,
    this.isPickupDetails = false,
    this.pickupDetails,
    this.imageUrl,
  });

  bool get isUser => sender == 'user';

  Map<String, dynamic> toMap() => {
    'id': id,
    'sender': sender,
    'text': text,
    'time': time,
    'isPickupDetails': isPickupDetails,
    'pickupDetails': pickupDetails,
    'imageUrl': imageUrl,
  };

  factory ChatMessage.fromMap(Map<String, dynamic> map) => ChatMessage(
    id: map['id'] ?? '',
    sender: map['sender'] ?? 'user',
    text: map['text'] ?? '',
    time: map['time'] ?? '',
    isPickupDetails: map['isPickupDetails'] ?? false,
    pickupDetails: map['pickupDetails'],
    imageUrl: map['imageUrl'],
  );
}
