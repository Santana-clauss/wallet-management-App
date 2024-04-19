import 'package:flutter/material.dart';
import 'package:flutter_app/utils/routes.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

Future<void> main () async {
   //Get.put(LoginController());
   await GetStorage.init();
  runApp(GetMaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes
    //home: AddWallets(),
  ));
}
