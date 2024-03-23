// ignore_for_file: non_constant_identifier_names, unnecessary_import

import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class UserController extends GetxController {
  final loadingUser = true.obs;
  final UserList = {}.obs;
  updateStudentList(list) => UserList.value = list;
  updateLoadingStudent(loading) => loadingUser.value = loading;
}
