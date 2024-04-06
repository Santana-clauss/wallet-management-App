// Example of storing userId globally using a provider
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UserProvider extends ChangeNotifier {
  String? userId;

  void setUserId(String id) {
    userId = id;
    notifyListeners();
  }
}

// Usage in main.dart or wherever you set up your app
// void main() {
//   runApp(
//     ChangeNotifierProvider(
//       create: (context) => UserProvider(),
      
//     ),
//   );
// }
