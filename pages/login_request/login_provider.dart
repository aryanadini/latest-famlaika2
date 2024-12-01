import 'package:flutter/material.dart';

class LoginProvider extends ChangeNotifier {
  String _countryCode = 'IN';
  bool _isLoading = false;

  String get countryCode => _countryCode;
  bool get isLoading => _isLoading;

  void setCountryCode(String code) {
    _countryCode = code;
    notifyListeners();
  }

  void setLoading(bool isLoading) {
    _isLoading = isLoading;
    notifyListeners();
  }
}
