import 'package:flutter/material.dart';
import 'dart:io';
class MemberData extends ChangeNotifier {
  String _name = '';
  String mobileNumber = '';
  String dateOfBirth = '';
  int? gender =0; // Default to male
  File? _profile_pic;
 late bool _isMale;
  String _relation;

  MemberData({required bool isMale, required String relation, required profilePic, required name,  })
      :  _isMale = isMale,
        gender = isMale ? 1 : 2,
        _relation = relation;
  int get genderValue => _isMale ? 1 : 2;
  String get relation => _relation;
  bool get isMale => _isMale;


  void updateRelation(String newRelation) {
    _relation = newRelation;
    notifyListeners();
  }
  void setSiblingRelation(bool isMale) {
    _isMale = isMale;
    _relation = isMale ? 'Brother' : 'Sister'; // Relation for sibling
    notifyListeners();
  }


  // Profile Image




}