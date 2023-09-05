import 'package:apple_shop/di.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthManager {
  static final ValueNotifier<String?> authChangeNotifire = ValueNotifier(null);
  static final SharedPreferences _sharePref = locator.get();

  static void saveToken(String token) async {
    _sharePref.setString('access_token', token);
    authChangeNotifire.value = token;
  }

  static String readAuth() {
    return _sharePref.getString('access_token') ?? '';
  }

  static void logout() {
    _sharePref.clear();
    authChangeNotifire.value = null;
  }

  static bool isLogedin() {
    String token = readAuth();
    return token.isNotEmpty;
  }
}
