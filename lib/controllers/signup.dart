// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class signUpController extends GetxController {
  var phoneNumber = ''.obs;
  var user_id = 0.obs;
  void updateUserId(id) {
    user_id.value = id;
  }


}
