// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;

  void updatePhoneNumber(num) {
    phoneNumber.value = num;
  }
}
