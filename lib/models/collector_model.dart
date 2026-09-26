import 'review_model.dart';

/// Collector profile model
class CollectorModel {
  final String id;
  final String name;
  final String agency;
  final String avatar;
  final double rating;
  final int reviewCount;
  final int completedCollections;
  final double distanceKm;
  final String availability; // 'available', 'busy', 'offline'
  final String phone;
  final String serviceArea;
  final String workingHours;
  final bool verified;
  final List<String> acceptedCategories;
  final String rateCard;
  final String about;
  final List<Review> reviews;

  const CollectorModel({
    required this.id,
    required this.name,
    required this.agency,
    required this.avatar,
    required this.rating,
    required this.reviewCount,
    required this.completedCollections,
    required this.distanceKm,
    required this.availability,
    required this.phone,
    required this.serviceArea,
    required this.workingHours,
    required this.verified,
    required this.acceptedCategories,
    required this.rateCard,
    required this.about,
    required this.reviews,
  });

  bool get isAvailable => availability == 'available';

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'agency': agency,
    'avatar': avatar,
    'rating': rating,
    'reviewCount': reviewCount,
    'completedCollections': completedCollections,
    'distanceKm': distanceKm,
    'availability': availability,
    'phone': phone,
    'serviceArea': serviceArea,
    'workingHours': workingHours,
    'verified': verified,
    'acceptedCategories': acceptedCategories,
    'rateCard': rateCard,
    'about': about,
    'reviews': reviews.map((r) => r.toMap()).toList(),
  };

  factory CollectorModel.fromMap(Map<String, dynamic> map) => CollectorModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    agency: map['agency'] ?? '',
    avatar: map['avatar'] ?? '',
    rating: (map['rating'] as num?)?.toDouble() ?? 5.0,
    reviewCount: (map['reviewCount'] as num?)?.toInt() ?? 0,
    completedCollections: (map['completedCollections'] as num?)?.toInt() ?? 0,
    distanceKm: (map['distanceKm'] as num?)?.toDouble() ?? 1.0,
    availability: map['availability'] ?? 'available',
    phone: map['phone'] ?? '',
    serviceArea: map['serviceArea'] ?? '',
    workingHours: map['workingHours'] ?? '',
    verified: map['verified'] ?? false,
    acceptedCategories: List<String>.from(map['acceptedCategories'] ?? []),
    rateCard: map['rateCard'] ?? '',
    about: map['about'] ?? '',
    reviews: (map['reviews'] as List<dynamic>?)
            ?.map((e) => Review.fromMap(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
