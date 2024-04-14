// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class LoginController extends GetxController {
  var phoneNumber = ''.obs;
  var user_id =0.obs;
  var fname = ''.obs;

  void updatePhoneNumber(num) {
    phoneNumber.value = num;
  }

  void updateUserId(id) {
    user_id.value = id;
  }
  void updatefname(name){
    fname.value =name;
  }
}
