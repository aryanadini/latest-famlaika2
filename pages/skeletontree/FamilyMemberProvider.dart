import 'dart:math';

import 'package:flutter/material.dart';

import '../addmember/MemberData.dart';

class FamilyTreeProvider with ChangeNotifier {

  List<MemberData> _members = [];
  bool isMale = true;
  //String relation = 'Brother';
  int gender=1;
  bool isSibling = false;

  bool defaultMale = true;
  //String relation = '';
  //int _gender = 1;
   String get relation {
    if (isSibling) {
      return isMale ? 'Brother' : 'Sister';
    }
    return isMale ? 'Son' : 'Daughter';
  }

  //bool get isMale => isMale;
  // get isSibling => isSibling;
  //bool get defaultMale => defaultMale;
 // String get relation => _relation;
  //int get gender => _gender;

  // int get gender {
  //   if (isSibling) {
  //     return isMale ? 4 : 5;
  //   }
  //   return isMale ? 7 : 6;
  // }
// int get gender => isMale ? (isSibling ? 4 : 7) : (isSibling ? 5 : 6); // Adjust gender based on relation

  // void toggleGender() {
  //   isMale = !isMale;
  //   notifyListeners();
  // }
  // void toggleRelation() {
  //   isSibling = !isSibling;
  //   notifyListeners();
  // }
  // void setSiblingGender(bool isMale) {
  //   this.isMale = isMale;
  //   //relation = isMale ? 'Brother' : 'Sister';
  //   gender = isMale ? 1 : 2;
  //   notifyListeners();
  // }

  void addMember(bool isMale, String relation, int gender) {
    this.isMale = isMale;
   // this.relation = relation;
    this.gender = gender;
    notifyListeners();
  }
  // void AddMember(bool isMale, String relation, int gender) {
  //   final member = MemberData(isMale: isMale, relation: relation,);
  //   _members.add(member);
  //   notifyListeners();
  // }
  // void addSibling() {
  //   // Assuming the default relation is Brother
  //   isMale = true;
  //   relation = 'Brother';
  //   gender = 1;
  //   notifyListeners();
  // }
  void resetSiblingState() {
    isMale = true;
   // relation = 'Brother';
   // gender = 1;
    notifyListeners();
  }

}


