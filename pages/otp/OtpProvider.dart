import 'package:flutter/foundation.dart';

class OtpProvider extends ChangeNotifier {
  // Define any state or methods you need for the provider

  // Example state
  String _otp = '';
  String get otp => _otp;

  // Example method to set OTP
  void setOtp(String value) {
    _otp = value;
    notifyListeners();
  }
}
