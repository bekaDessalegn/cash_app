import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

String LOGIN_KEY = "5FD6G46SDF4GD64F1VG9SD17";

class AppService with ChangeNotifier {
  late final SharedPreferences sharedPreferences;
  final StreamController<bool> _loginStateChange = StreamController<bool>.broadcast();
  bool _loginState = false;
  bool _initialized = false;
  bool _isEditFullName = false;
  bool _isEditPhone = false;

  AppService(this.sharedPreferences);

  bool get loginState => _loginState;
  bool get initialized => _initialized;
  bool get isEditFullName => _isEditFullName;
  bool get isEditPhone => _isEditPhone;
  Stream<bool> get loginStateChange => _loginStateChange.stream;

  set loginState(bool state) {
    sharedPreferences.setBool(LOGIN_KEY, state);
    _loginState = state;
    _loginStateChange.add(state);
    notifyListeners();
  }

  set initialized(bool value) {
    _initialized = value;
    notifyListeners();
  }

  set isEditFullName(bool value) {
    _isEditFullName = value;
    notifyListeners();
  }

  set isEditPhone(bool value) {
    _isEditPhone = value;
    notifyListeners();
  }

  Future<void> onAppStart() async {
    _loginState = sharedPreferences.getBool(LOGIN_KEY) ?? false;

    await Future.delayed(const Duration(seconds: 0));

    _initialized = true;
    notifyListeners();
  }

  void changeIsEditFullName(bool value){
    _isEditFullName = value;
    notifyListeners();
  }

  void changeIsEditPhone(bool value){
    _isEditPhone = value;
    notifyListeners();
  }

}
