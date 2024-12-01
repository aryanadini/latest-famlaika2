import 'package:flutter/material.dart';
import 'dart:io';

class ProfileProvider extends ChangeNotifier {
  File? _image;
  bool _isFemale = true;
  bool isLoading = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  File? get image => _image;

  bool get isFemale => _isFemale;

  void pickImage(File image) {
    _image = image;
    print("Image picked: ${_image?.path}");
    notifyListeners();
  }

  void setGender(bool isFemale) {
    _isFemale = isFemale;
    print("Gender set to: ${_isFemale ? 'Female' : 'Male'}");
    notifyListeners();
  }

  void updateDate(String date) {
    dateController.text = date;
    print("Date updated to: $date");
    notifyListeners();
  }
  void updateFullName(String fullName) {
    fullNameController.text = fullName;
    print("Full Name updated to: $fullName");
    notifyListeners();
  }
}
