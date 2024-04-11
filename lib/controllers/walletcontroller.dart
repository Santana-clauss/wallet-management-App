// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class WalletController extends GetxController {
  var walletid = 0.obs;

  void updateWaller(id) {
    walletid.value = id;
  }
}
