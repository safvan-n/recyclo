/// Address model
class Address {
  final String id;
  final String label;
  final String address;
  final bool isDefault;

  const Address({
    required this.id,
    required this.label,
    required this.address,
    this.isDefault = false,
  });

  Map<String, dynamic> toMap() => {
    'id': id,
    'label': label,
    'address': address,
    'isDefault': isDefault,
  };

  factory Address.fromMap(Map<String, dynamic> map) => Address(
    id: map['id'] ?? '',
    label: map['label'] ?? '',
    address: map['address'] ?? '',
    isDefault: map['isDefault'] ?? false,
  );
}

/// User statistics model
class UserStats {
  final double totalRecycledKg;
  final int collectionsCompleted;
  final String moneyEarned;
  final double co2SavedKg;

  const UserStats({
    required this.totalRecycledKg,
    required this.collectionsCompleted,
    required this.moneyEarned,
    required this.co2SavedKg,
  });

  Map<String, dynamic> toMap() => {
    'totalRecycledKg': totalRecycledKg,
    'collectionsCompleted': collectionsCompleted,
    'moneyEarned': moneyEarned,
    'co2SavedKg': co2SavedKg,
  };

  factory UserStats.fromMap(Map<String, dynamic> map) => UserStats(
    totalRecycledKg: (map['totalRecycledKg'] as num?)?.toDouble() ?? 0.0,
    collectionsCompleted: (map['collectionsCompleted'] as num?)?.toInt() ?? 0,
    moneyEarned: map['moneyEarned'] ?? '₹0.00',
    co2SavedKg: (map['co2SavedKg'] as num?)?.toDouble() ?? 0.0,
  );
}

/// Core User model
class UserModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String? avatar;
  final UserStats stats;
  final List<Address> savedAddresses;

  const UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    this.avatar,
    required this.stats,
    required this.savedAddresses,
  });

  UserModel copyWith({
    String? name,
    String? email,
    String? phone,
    String? location,
    String? avatar,
    UserStats? stats,
    List<Address>? savedAddresses,
  }) {
    return UserModel(
      id: id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      location: location ?? this.location,
      avatar: avatar ?? this.avatar,
      stats: stats ?? this.stats,
      savedAddresses: savedAddresses ?? this.savedAddresses,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'email': email,
    'phone': phone,
    'location': location,
    'avatar': avatar,
    'stats': stats.toMap(),
    'savedAddresses': savedAddresses.map((a) => a.toMap()).toList(),
  };

  factory UserModel.fromMap(Map<String, dynamic> map) => UserModel(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    email: map['email'] ?? '',
    phone: map['phone'] ?? '',
    location: map['location'] ?? '',
    avatar: map['avatar'],
    stats: UserStats.fromMap(map['stats'] ?? {}),
    savedAddresses: (map['savedAddresses'] as List<dynamic>?)
            ?.map((e) => Address.fromMap(e as Map<String, dynamic>))
            .toList() ??
        [],
  );
}
