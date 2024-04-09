// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class LoginController extends GetxController {
  var walletid = ''.obs;

  void updatePhoneNumber(num) {
    walletid.value = num;
  }
}
