import 'package:flutter/material.dart';
import 'package:flutter_app/utils/routes.dart';


import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes
  ));
}
