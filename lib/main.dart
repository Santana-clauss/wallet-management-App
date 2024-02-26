import 'package:flutter/material.dart';
import 'package:flutter_app/pages/accounts.dart';
import 'package:flutter_app/pages/reports.dart';
import 'package:flutter_app/pages/transactions.dart';
import 'package:flutter_app/utils/routes.dart';


import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
     initialRoute: "/",
    debugShowCheckedModeBanner: false,
    getPages: Routes.routes
    //home:AccountsPage(),
  ));
}
