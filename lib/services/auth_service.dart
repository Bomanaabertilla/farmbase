import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  static const String _usersKey = 'auth_users_v1';
  static const String _currentUserKey = 'auth_current_user_v1';

  Future<bool> signUp(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, String> users = _loadUsers(prefs);
    if (users.containsKey(email.toLowerCase())) {
      return false; // already exists
    }
    users[email.toLowerCase()] = password;
    await _saveUsers(prefs, users);
    await prefs.setString(_currentUserKey, email.toLowerCase());
    return true;
  }

  Future<bool> login(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    final Map<String, String> users = _loadUsers(prefs);
    final String? stored = users[email.toLowerCase()];
    if (stored != null && stored == password) {
      await prefs.setString(_currentUserKey, email.toLowerCase());
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_currentUserKey);
  }

  Future<String?> getCurrentUserEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_currentUserKey);
  }

  Map<String, String> _loadUsers(SharedPreferences prefs) {
    final jsonString = prefs.getString(_usersKey);
    if (jsonString == null) return <String, String>{};
    final Map<String, dynamic> map =
        jsonDecode(jsonString) as Map<String, dynamic>;
    return map.map((k, v) => MapEntry(k, v as String));
  }

  Future<void> _saveUsers(
    SharedPreferences prefs,
    Map<String, String> users,
  ) async {
    final jsonString = jsonEncode(users);
    await prefs.setString(_usersKey, jsonString);
  }
}
