/// Waste Category Model
class WasteCategory {
  final String id;
  final String name;
  final String icon;
  final String description;
  final String avgRate;
  final double rateValue;
  final List<String> suggestedItems;

  const WasteCategory({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.avgRate,
    required this.rateValue,
    required this.suggestedItems,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'icon': icon,
    'description': description,
    'avgRate': avgRate,
    'rateValue': rateValue,
    'suggestedItems': suggestedItems,
  };

  factory WasteCategory.fromMap(Map<String, dynamic> map) => WasteCategory(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    icon: map['icon'] ?? '',
    description: map['desc'] ?? map['description'] ?? '',
    avgRate: map['avgRate'] ?? '',
    rateValue: (map['rateValue'] as num?)?.toDouble() ?? 0.0,
    suggestedItems: List<String>.from(map['suggestedItems'] ?? []),
  );
}
