import 'package:flutter/foundation.dart';
import '../../models/waste_category_model.dart';
import '../../models/collector_model.dart';
import '../mock/mock_data.dart';

/// Multi-step Waste Draft state
class WasteDraft {
  int currentStep; // 1 to 5
  String? photoPath; // Simulated or selected photo
  String? suggestedType; // e.g. "Plastic Bottles (Suggested)"
  WasteCategory? category;
  double quantity;
  String unit; // 'kg' or 'pcs'
  String description;
  String pickupAddress;
  CollectorModel? selectedCollector;
  String pickupDate;
  String pickupTime;
  String paymentMethod; // 'UPI', 'Card', 'Cash on Collection'

  WasteDraft({
    this.currentStep = 1,
    this.photoPath,
    this.suggestedType = 'Plastic Bottles & Containers',
    this.category,
    this.quantity = 5.0,
    this.unit = 'kg',
    this.description = '',
    this.pickupAddress = '402 Oakwood Heights, Green Glen Layout, Bengaluru',
    this.selectedCollector,
    this.pickupDate = 'Today',
    this.pickupTime = '02:00 PM',
    this.paymentMethod = 'UPI Digital Payment',
  });

  double get estimatedAmount {
    if (category == null) return quantity * 18.0;
    return quantity * category!.rateValue;
  }
}

/// Waste Repository & Draft Provider
class WasteProvider extends ChangeNotifier {
  final List<WasteCategory> _categories = MockData.categories;
  WasteDraft _draft = WasteDraft();

  List<WasteCategory> get categories => _categories;
  WasteDraft get draft => _draft;

  WasteProvider() {
    _draft.category = _categories.first;
    _draft.selectedCollector = MockData.collectors.first;
  }

  void resetDraft() {
    _draft = WasteDraft(
      category: _categories.first,
      selectedCollector: MockData.collectors.first,
    );
    notifyListeners();
  }

  void setStep(int step) {
    _draft.currentStep = step;
    notifyListeners();
  }

  void setPhoto(String? path, {String? suggestedType}) {
    _draft.photoPath = path;
    if (suggestedType != null) {
      _draft.suggestedType = suggestedType;
    }
    notifyListeners();
  }

  void setCategory(WasteCategory category) {
    _draft.category = category;
    notifyListeners();
  }

  void setDetails({
    required double quantity,
    required String unit,
    required String description,
    required String address,
  }) {
    _draft.quantity = quantity;
    _draft.unit = unit;
    _draft.description = description;
    _draft.pickupAddress = address;
    notifyListeners();
  }

  void setCollector(CollectorModel collector) {
    _draft.selectedCollector = collector;
    notifyListeners();
  }

  void setSchedule(String date, String time) {
    _draft.pickupDate = date;
    _draft.pickupTime = time;
    notifyListeners();
  }

  void setPaymentMethod(String method) {
    _draft.paymentMethod = method;
    notifyListeners();
  }
}
