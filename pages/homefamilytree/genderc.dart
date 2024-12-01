import 'package:flutter/material.dart';

// GenderController to manage gender selection
class GenderController extends ValueNotifier<bool> {
  GenderController() : super(true); // Default to female (true)

  void selectMale() {
    value = true;
  }

  void selectFemale() {
    value = false;
  }
}
