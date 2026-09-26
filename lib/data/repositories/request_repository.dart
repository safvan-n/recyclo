import 'package:flutter/foundation.dart';
import '../../models/pickup_request_model.dart';
import '../../models/collector_model.dart';
import '../../models/waste_category_model.dart';
import '../mock/mock_data.dart';

/// Pickup Requests Provider & Lifecycle Tracker
class RequestProvider extends ChangeNotifier {
  PickupRequestModel? _activeRequest = MockData.initialActiveRequest;
  final List<PickupRequestModel> _pastRequests = List.from(MockData.pastRequests);

  PickupRequestModel? get activeRequest => _activeRequest;
  List<PickupRequestModel> get pastRequests => _pastRequests;

  /// Creates a new request from completed booking draft
  void createRequest({
    required CollectorModel collector,
    required WasteCategory category,
    required double quantity,
    required String unit,
    required String pickupAddress,
    required String pickupDate,
    required String pickupTime,
    required String paymentMethod,
    required String estimatedAmount,
  }) {
    final newId = 'REQ-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}';
    final nowTime = 'Just now';

    _activeRequest = PickupRequestModel(
      id: newId,
      collectorId: collector.id,
      collectorName: collector.name,
      collectorPhone: collector.phone,
      collectorAvatar: collector.avatar,
      wasteType: '${category.name} Scrap ($quantity $unit)',
      wasteCategory: category.id,
      quantity: '$quantity $unit',
      scheduledDate: pickupDate,
      scheduledTime: pickupTime,
      pickupAddress: pickupAddress,
      paymentMethod: paymentMethod,
      estimatedAmount: estimatedAmount,
      status: 'placed',
      createdTimestamp: nowTime,
      etaMinutes: 18,
      stages: [
        TrackingStage(key: 'placed', label: 'Request Placed', time: nowTime, done: true, current: true),
        const TrackingStage(key: 'accepted', label: 'Collector Accepted', time: 'Pending', done: false),
        TrackingStage(key: 'scheduled', label: 'Pickup Scheduled', time: '$pickupDate, $pickupTime', done: false),
        const TrackingStage(key: 'on_the_way', label: 'Collector On The Way', time: 'Pending', done: false),
        const TrackingStage(key: 'collected', label: 'Waste Collected', time: 'Pending', done: false),
        const TrackingStage(key: 'completed', label: 'Payment Completed', time: 'Pending', done: false),
      ],
    );
    notifyListeners();
  }

  /// Live Tracking Simulator: advances the request stage step-by-step
  void advanceStatus() {
    if (_activeRequest == null) return;

    final stages = List<TrackingStage>.from(_activeRequest!.stages);
    final currentStatus = _activeRequest!.status;

    String nextStatus = currentStatus;
    int nextEta = _activeRequest!.etaMinutes;

    switch (currentStatus) {
      case 'placed':
        nextStatus = 'accepted';
        nextEta = 15;
        _updateStages(stages, 'accepted', '11:24 AM');
        break;
      case 'accepted':
        nextStatus = 'scheduled';
        nextEta = 12;
        _updateStages(stages, 'scheduled', '01:30 PM');
        break;
      case 'scheduled':
        nextStatus = 'on_the_way';
        nextEta = 8;
        _updateStages(stages, 'on_the_way', '01:48 PM');
        break;
      case 'on_the_way':
        nextStatus = 'collected';
        nextEta = 0;
        _updateStages(stages, 'collected', '02:05 PM');
        break;
      case 'collected':
        nextStatus = 'completed';
        nextEta = 0;
        _updateStages(stages, 'completed', '02:10 PM');
        // Move to past requests
        _pastRequests.insert(0, _activeRequest!.copyWith(status: 'completed', stages: stages));
        break;
      case 'completed':
        // Reset back to placed for continuous demo capability
        nextStatus = 'placed';
        nextEta = 18;
        for (int i = 0; i < stages.length; i++) {
          stages[i] = stages[i].copyWith(done: i == 0, current: i == 0);
        }
        break;
    }

    _activeRequest = _activeRequest!.copyWith(
      status: nextStatus,
      etaMinutes: nextEta,
      stages: stages,
    );
    notifyListeners();
  }

  void _updateStages(List<TrackingStage> stages, String currentKey, String timestamp) {
    bool passedCurrent = false;
    for (int i = 0; i < stages.length; i++) {
      if (stages[i].key == currentKey) {
        stages[i] = stages[i].copyWith(done: true, current: true, time: timestamp);
        passedCurrent = true;
      } else if (!passedCurrent) {
        stages[i] = stages[i].copyWith(done: true, current: false);
      } else {
        stages[i] = stages[i].copyWith(done: false, current: false);
      }
    }
  }

  void cancelActiveRequest() {
    _activeRequest = null;
    notifyListeners();
  }
}
