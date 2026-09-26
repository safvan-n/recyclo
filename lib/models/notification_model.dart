/// App Notification model
class AppNotification {
  final String id;
  final String title;
  final String desc;
  final String time;
  final String type;
  final bool unread;
  final String? actionScreen;

  const AppNotification({
    required this.id,
    required this.title,
    required this.desc,
    required this.time,
    required this.type,
    this.unread = true,
    this.actionScreen,
  });

  AppNotification copyWith({
    bool? unread,
  }) {
    return AppNotification(
      id: id,
      title: title,
      desc: desc,
      time: time,
      type: type,
      unread: unread ?? this.unread,
      actionScreen: actionScreen,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'title': title,
    'desc': desc,
    'time': time,
    'type': type,
    'unread': unread,
    'actionScreen': actionScreen,
  };

  factory AppNotification.fromMap(Map<String, dynamic> map) => AppNotification(
    id: map['id'] ?? '',
    title: map['title'] ?? '',
    desc: map['desc'] ?? '',
    time: map['time'] ?? '',
    type: map['type'] ?? 'bell',
    unread: map['unread'] ?? true,
    actionScreen: map['actionScreen'],
  );
}
