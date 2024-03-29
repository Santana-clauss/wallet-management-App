// ignore_for_file: prefer_const_constructors

import 'package:flutter_app/pages/accounts.dart';
import 'package:flutter_app/pages/dashboard.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/register.dart';
import 'package:flutter_app/pages/reports.dart';

import 'package:get/get.dart';

class Routes{
  static var routes=[
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/", page: ()=>RegisterScreen()),
    GetPage(name: "/login", page:()=>LoginScreen()),
    GetPage(name: "/accounts", page: () => AccountsPage()),
    GetPage(name: "/reports", page: () => ReportsPage()),
    GetPage(name: "/profile", page: () => ProfilePage()),
    
  ];
}