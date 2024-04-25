// ignore_for_file: prefer_const_constructors

import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/pages/accounts.dart';
import 'package:flutter_app/pages/addwallets.dart';
import 'package:flutter_app/pages/dashboard.dart';
import 'package:flutter_app/pages/deposit.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/register.dart';
import 'package:flutter_app/pages/reports.dart';
import 'package:flutter_app/pages/transactions.dart';
import 'package:flutter_app/pages/transfer.dart';
import 'package:flutter_app/pages/updateprofile.dart';
import 'package:flutter_app/pages/withdrawpage.dart';

import 'package:get/get.dart';
LoginController loginController=Get.put(LoginController());
class Routes {
  static var routes = [
    GetPage(name: "/home", page: () => HomePage()),
    GetPage(name: "/", page: () => RegisterScreen()),
    GetPage(name: "/login", page: () => LoginScreen()),
    GetPage(name: "/accounts", page: () => AccountsPage()),
    GetPage(name: "/reports", page: () => ReportsPage()),
    //GetPage(name: "/profile", page: () => ProfilePage()),
    GetPage(name: "/deposit", page: () => DepositPage()),
    GetPage(name: "/transfer", page: () => TransferPage()),
    GetPage(name: "/withdraw", page: () => WithdrawalPage()),
    GetPage(name: "/transcation", page: () => TranscationPage()),
    GetPage(name: "/add-wallet", page: () => AddWallets()),
    GetPage(name: "/profile", page: () => ProfilePage()),
    GetPage(name: "/profile", page: () => ProfilePage()),
   
    
    GetPage(
      name: "/updateProfile",
      
      page: () =>
          UpdateProfile(userId: Get.find<LoginController>().user_id.value),
    ),
  ];
}
