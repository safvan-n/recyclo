import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';
import '../mock/mock_data.dart';

/// Authentication Repository & State Provider
/// Firebase-ready interface (can easily swap with FirebaseAuth)
class AuthProvider extends ChangeNotifier {
  UserModel? _currentUser;
  bool _isAuthenticated = false;
  bool _isLoading = false;

  UserModel? get currentUser => _currentUser;
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;

  AuthProvider() {
    // Default demo authenticated state
    _currentUser = MockData.currentUser;
    _isAuthenticated = true;
  }

  Future<bool> login(String emailOrPhone, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 600));

    _currentUser = MockData.currentUser.copyWith(
      email: emailOrPhone.contains('@') ? emailOrPhone : MockData.currentUser.email,
      phone: !emailOrPhone.contains('@') ? emailOrPhone : MockData.currentUser.phone,
    );
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<bool> signup({
    required String name,
    required String email,
    required String phone,
    required String password,
    required String location,
  }) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(milliseconds: 700));

    _currentUser = UserModel(
      id: 'usr-${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      location: location,
      stats: const UserStats(
        totalRecycledKg: 0.0,
        collectionsCompleted: 0,
        moneyEarned: '₹0.00',
        co2SavedKg: 0.0,
      ),
      savedAddresses: [
        Address(
          id: 'addr-main',
          label: 'Home',
          address: location,
          isDefault: true,
        ),
      ],
    );
    _isAuthenticated = true;
    _isLoading = false;
    notifyListeners();
    return true;
  }

  Future<void> updateProfile({
    String? name,
    String? email,
    String? phone,
    String? location,
  }) async {
    if (_currentUser == null) return;
    _currentUser = _currentUser!.copyWith(
      name: name,
      email: email,
      phone: phone,
      location: location,
    );
    notifyListeners();
  }

  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
}
