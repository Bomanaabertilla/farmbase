import 'package:flutter/foundation.dart';
import '../services/auth_service.dart';

class AuthProvider extends ChangeNotifier {
  final AuthService _service;
  String? _email;
  bool _isLoading = false;

  AuthProvider(this._service);

  String? get email => _email;
  bool get isAuthenticated => _email != null;
  bool get isLoading => _isLoading;

  Future<void> loadSession() async {
    _isLoading = true;
    notifyListeners();
    _email = await _service.getCurrentUserEmail();
    _isLoading = false;
    notifyListeners();
  }

  Future<bool> signUp(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final ok = await _service.signUp(email, password);
    if (ok) {
      _email = email.toLowerCase();
    }
    _isLoading = false;
    notifyListeners();
    return ok;
  }

  Future<bool> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    final ok = await _service.login(email, password);
    if (ok) {
      _email = email.toLowerCase();
    }
    _isLoading = false;
    notifyListeners();
    return ok;
  }

  Future<void> logout() async {
    _isLoading = true;
    notifyListeners();
    await _service.logout();
    _email = null;
    _isLoading = false;
    notifyListeners();
  }
}
