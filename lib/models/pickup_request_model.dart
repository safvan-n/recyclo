/// Tracking stage item
class TrackingStage {
  final String key;
  final String label;
  final String time;
  final bool done;
  final bool current;

  const TrackingStage({
    required this.key,
    required this.label,
    required this.time,
    required this.done,
    this.current = false,
  });

  TrackingStage copyWith({
    String? key,
    String? label,
    String? time,
    bool? done,
    bool? current,
  }) {
    return TrackingStage(
      key: key ?? this.key,
      label: label ?? this.label,
      time: time ?? this.time,
      done: done ?? this.done,
      current: current ?? this.current,
    );
  }

  Map<String, dynamic> toMap() => {
    'key': key,
    'label': label,
    'time': time,
    'done': done,
    'current': current,
  };

  factory TrackingStage.fromMap(Map<String, dynamic> map) => TrackingStage(
    key: map['key'] ?? '',
    label: map['label'] ?? '',
    time: map['time'] ?? '',
    done: map['done'] ?? false,
    current: map['current'] ?? false,
  );
}

/// Pickup Request Model
class PickupRequestModel {
  final String id;
  final String collectorId;
  final String collectorName;
  final String collectorPhone;
  final String collectorAvatar;
  final String wasteType;
  final String wasteCategory;
  final String quantity;
  final String scheduledDate;
  final String scheduledTime;
  final String pickupAddress;
  final String paymentMethod;
  final String estimatedAmount;
  final String status; // 'placed', 'accepted', 'scheduled', 'on_the_way', 'collected', 'completed'
  final String createdTimestamp;
  final int etaMinutes;
  final List<TrackingStage> stages;

  const PickupRequestModel({
    required this.id,
    required this.collectorId,
    required this.collectorName,
    required this.collectorPhone,
    required this.collectorAvatar,
    required this.wasteType,
    required this.wasteCategory,
    required this.quantity,
    required this.scheduledDate,
    required this.scheduledTime,
    required this.pickupAddress,
    required this.paymentMethod,
    required this.estimatedAmount,
    required this.status,
    required this.createdTimestamp,
    required this.etaMinutes,
    required this.stages,
  });

  PickupRequestModel copyWith({
    String? status,
    int? etaMinutes,
    List<TrackingStage>? stages,
  }) {
    return PickupRequestModel(
      id: id,
      collectorId: collectorId,
      collectorName: collectorName,
      collectorPhone: collectorPhone,
      collectorAvatar: collectorAvatar,
      wasteType: wasteType,
      wasteCategory: wasteCategory,
      quantity: quantity,
      scheduledDate: scheduledDate,
      scheduledTime: scheduledTime,
      pickupAddress: pickupAddress,
      paymentMethod: paymentMethod,
      estimatedAmount: estimatedAmount,
      status: status ?? this.status,
      createdTimestamp: createdTimestamp,
      etaMinutes: etaMinutes ?? this.etaMinutes,
      stages: stages ?? this.stages,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'collectorId': collectorId,
    'collectorName': collectorName,
    'collectorPhone': collectorPhone,
    'collectorAvatar': collectorAvatar,
    'wasteType': wasteType,
    'wasteCategory': wasteCategory,
    'quantity': quantity,
    'scheduledDate': scheduledDate,
    'scheduledTime': scheduledTime,
    'pickupAddress': pickupAddress,
    'paymentMethod': paymentMethod,
    'estimatedAmount': estimatedAmount,
    'status': status,
    'createdTimestamp': createdTimestamp,
    'etaMinutes': etaMinutes,
    'stages': stages.map((s) => s.toMap()).toList(),
  };

  factory PickupRequestModel.fromMap(Map<String, dynamic> map) => PickupRequestModel(
    id: map['id'] ?? '',
    collectorId: map['collectorId'] ?? '',
    collectorName: map['collectorName'] ?? '',
    collectorPhone: map['collectorPhone'] ?? '',
    collectorAvatar: map['collectorAvatar'] ?? '',
    wasteType: map['wasteType'] ?? '',
    wasteCategory: map['wasteCategory'] ?? '',
    quantity: map['quantity'] ?? '',
    scheduledDate: map['scheduledDate'] ?? '',
    scheduledTime: map['scheduledTime'] ?? '',
    pickupAddress: map['pickupAddress'] ?? '',
    paymentMethod: map['paymentMethod'] ?? '',
    estimatedAmount: map['estimatedAmount'] ?? '',
    status: map['status'] ?? 'placed',
    createdTimestamp: map['createdTimestamp'] ?? '',
    etaMinutes: (map['etaMinutes'] as num?)?.toInt() ?? 15,
    stages: (map['stages'] as List<dynamic>?)
            ?.map((e) => TrackingStage.fromMap(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
