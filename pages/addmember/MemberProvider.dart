import 'package:flutter/material.dart';

class MemberProvider with ChangeNotifier {
  bool _isFemale;
  String _currentRelation;

  MemberProvider(this._isFemale) : _currentRelation = _isFemale ? 'Sister' : 'Brother';

  bool get isFemale => _isFemale;
  String get currentRelation => _currentRelation;

  void toggleGender() {
    _isFemale = !_isFemale;
    _updateRelation();
    notifyListeners(); // Notify listeners about the state change
  }

  void _updateRelation() {
    _currentRelation = _isFemale ? 'Sister' : 'Brother';
  }

  String? getSelectedRelation(String relation) {
    return _isFemale ? (relation == 'Sister' ? '5' : '6') : (relation == 'Brother' ? '4' : '7');
  }
}
