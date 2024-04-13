// Example of storing userId globally using a provider
import 'package:flutter/material.dart';
class UserProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}


