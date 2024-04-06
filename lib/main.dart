import 'package:flutter/material.dart';
import 'package:flutter_app/pages/deposit.dart';
import 'package:flutter_app/pages/withdrawpage.dart';
import 'package:flutter_app/utils/routes.dart';
import 'package:flutter_app/views/custompage.dart';


import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes
    //home: WithdrawPage(),
  ));
}
