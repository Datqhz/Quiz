import 'package:flutter/material.dart';
import 'package:quiz/utilities/shared_preference_utils.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  void login() {
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _isLoggedIn = false;
    destroyToken();
    destroyUserInfo();
    destroyAccount();
    notifyListeners();
  }
}
