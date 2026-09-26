import 'package:flutter/foundation.dart';
import '../../models/collector_model.dart';
import '../mock/mock_data.dart';

/// Collector Directory Provider & Repository
class CollectorProvider extends ChangeNotifier {
  final List<CollectorModel> _allCollectors = MockData.collectors;
  String _searchQuery = '';
  String _categoryFilter = 'all';
  String _availabilityFilter = 'all'; // 'all', 'available', 'rating', 'distance'

  List<CollectorModel> get allCollectors => _allCollectors;
  String get searchQuery => _searchQuery;
  String get categoryFilter => _categoryFilter;
  String get availabilityFilter => _availabilityFilter;

  List<CollectorModel> get filteredCollectors {
    return _allCollectors.where((c) {
      // Search match
      final matchesSearch = _searchQuery.isEmpty ||
          c.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.serviceArea.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          c.agency.toLowerCase().contains(_searchQuery.toLowerCase());

      // Category match
      final matchesCategory = _categoryFilter == 'all' ||
          c.acceptedCategories.contains(_categoryFilter.toLowerCase());

      // Availability match
      final matchesAvailability = _availabilityFilter != 'available' ||
          c.availability == 'available';

      return matchesSearch && matchesCategory && matchesAvailability;
    }).toList()
      ..sort((a, b) {
        if (_availabilityFilter == 'rating') {
          return b.rating.compareTo(a.rating);
        } else if (_availabilityFilter == 'distance') {
          return a.distanceKm.compareTo(b.distanceKm);
        }
        return 0;
      });
  }

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setCategoryFilter(String category) {
    _categoryFilter = category;
    notifyListeners();
  }

  void setAvailabilityFilter(String filter) {
    _availabilityFilter = filter;
    notifyListeners();
  }

  CollectorModel? getById(String id) {
    try {
      return _allCollectors.firstWhere((c) => c.id == id);
    } catch (_) {
      return null;
    }
  }
}
