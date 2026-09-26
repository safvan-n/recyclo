import 'package:flutter/foundation.dart';
import '../../models/notification_model.dart';
import '../mock/mock_data.dart';

/// Notifications Repository & Provider
class NotificationProvider extends ChangeNotifier {
  final List<AppNotification> _notifications = List.from(MockData.notifications);

  List<AppNotification> get notifications => _notifications;
  int get unreadCount => _notifications.where((n) => n.unread).length;

  void markAsRead(String id) {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(unread: false);
      notifyListeners();
    }
  }

  void markAllAsRead() {
    for (int i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(unread: false);
    }
    notifyListeners();
  }

  void clearAll() {
    _notifications.clear();
    notifyListeners();
  }
}
