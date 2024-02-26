// ignore_for_file: prefer_const_constructors

import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/register.dart';

import 'package:get/get.dart';

class Routes{
  static var routes=[
    GetPage(name: "/home", page: () => Homepage()),
    GetPage(name: "/", page: ()=>RegisterScreen()),
    GetPage(name: "/login", page:()=>LoginScreen())
  ];
}