// Example of storing walletId globally using a provider
import 'package:flutter/material.dart';

class WalletProvider extends ChangeNotifier {
  String? selectedWalletId;

  void setSelectedWalletId(String id) {
    selectedWalletId = id;
    notifyListeners();
  }
}

