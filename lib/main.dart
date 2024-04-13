import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/pages/addwallets.dart';
import 'package:flutter_app/utils/routes.dart';



import 'package:get/get.dart';

void main() {
   //Get.put(LoginController());
  runApp(GetMaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes
    //home: AddWallets(),
  ));
}
