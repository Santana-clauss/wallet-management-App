// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/controllers.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/pages/accounts.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/pages/profile.dart';
import 'package:flutter_app/pages/reports.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';

HomeController homeController = Get.put(HomeController());

class HomePage extends StatelessWidget {
  final List<Widget> screens = [
    Homepage(),
    AccountsPage(),
    //ReportsPage(),
    ProfilePage(userId: 6,),

    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: Obx(() => screens[homeController.selectedPage.value]),
      bottomNavigationBar: GNav(
        //color: primaryColor,
        color: const Color.fromARGB(255, 160, 150, 150),
        activeColor: Colors.green,
        tabBackgroundColor: Colors.green.withOpacity(0.1),
        backgroundColor: primaryColor.withOpacity(0.08),
        //tabBackgroundColor: primaryColor.withOpacity(0.5),
        tabs: [
          GButton(
            icon: Icons.home,
            iconColor: appBlackColor,
            text: 'Home',
          ),
          GButton(
            icon: Icons.category,
            iconColor: appBlackColor,
            text: 'Accounts',
          ),
          
          GButton(
            icon: Icons.person,
            iconColor: appBlackColor,
            text: 'Profile',
          ),
        ],
        selectedIndex: homeController.selectedPage.value,
        onTabChange: (index) {
          homeController.updateSelectedPage(index);
        },
      ),
    );
  }
}
