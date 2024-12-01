import 'package:flutter/material.dart';

import '../../addmember/MemberData.dart';

class FamilyData extends ChangeNotifier {
  List<MemberData> _members = [];

  List<MemberData> get members => _members;

  void addMember(MemberData member) {
    _members.add(member);
    notifyListeners(); // Notify listeners to update the UI
  }

// Add any other methods for managing members (like removing members)
}
