import 'package:flutter/material.dart';
import '../models/user.dart';
import '../services/api.dart';

class UserProvider extends ChangeNotifier {
  User? _user;

  User? get user => _user;
  bool get isLoggedIn => _user != null;

  Future<bool> login(String username, String password) async {
    debugPrint('🟡 LOGIN STARTED: $username');

    final user = await Api.login(username, password);

    if (user != null) {
      debugPrint('🟢 API returned user: ${user.toJson()}');

      _user = user;
      notifyListeners();

      debugPrint('🟢 USER STORED IN PROVIDER');
      return true;
    }

    debugPrint('🔴 LOGIN FAILED: user is null');
    return false;
  }

  void logout() {
    debugPrint('🟠 USER LOGOUT');
    _user = null;
    notifyListeners();
  }
}
