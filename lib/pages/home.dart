// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/controllers.dart';
import 'package:flutter_app/pages/accounts.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customcard.dart';
import 'package:flutter_app/views/customedetails.dart';
import 'package:flutter_app/views/customtbutton.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

HomeController homeController = Get.put(HomeController());
var screens = [Homepage(), AccountsPage()];

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: appWhiteColor,
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color.fromARGB(255, 88, 86, 86).withOpacity(0.15),
        ),
        child: GNav(
          color: const Color.fromARGB(255, 160, 150, 150),
          activeColor: Colors.green,
          gap: 8,
          tabBackgroundColor: Colors.green.withOpacity(0.1),
          tabs: [
            GButton(icon: Icons.home, iconColor: appBlackColor,onPressed: (){
              Navigator.pushNamed(context, '/home');

            },),
            GButton(icon: Icons.account_box, iconColor: appBlackColor,
            onPressed: (){
              Navigator.pushNamed(context, '/accounts');
            },),
            GButton(icon: Icons.settings, iconColor: appBlackColor,onPressed: (){
              Navigator.pushNamed(context, '/accounts');
            } ,),
            GButton(icon: Icons.person, iconColor: appBlackColor,
              onPressed: () {
                Navigator.pushNamed(context, '/accounts');
              } ,)
          ],
          
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        customText(
                          label: "Hello,",
                          fontSize: 14,
                          labelColor: appGreyColor,
                        ),
                        customText(
                          label: "Santana",
                          fontSize: 24,
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: appGreyColor,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.person),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Container(
                height: 200,
                child: PageView(
                  controller: _controller,
                  scrollDirection: Axis.horizontal,
                  children: [
                    MyWallet(
                      title: "SAVINGS ACCOUNT",
                      balance: 5000,
                      color: Colors.green,
                    ),
                    MyWallet(
                      title: "VISA CARD",
                      balance: 3000,
                      cardNumber: 048934178,
                      expiryMonth: 10,
                      color: Colors.purple,
                      expiryYear: 2026,
                    ),
                    MyWallet(
                      title: "KCB CARD",
                      balance: 4000,
                      cardNumber: 567894321,
                      expiryMonth: 10,
                      color: Colors.blue,
                      expiryYear: 2026,
                    )
                  ],
                ),
              ),
              SizedBox(height: 25),
              SmoothPageIndicator(
                controller: _controller,
                count: 3,
                effect: ExpandingDotsEffect(activeDotColor: Colors.black),
              ),
              SizedBox(height: 20),
              customText(
                label: "Features",
                labelColor: Colors.black,
                fontSize: 20,
              ),
              SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    MyButton(
                      iconImagePath: "images/deposit.png",
                      buttonText: "Bills",
                    ),
                    MyButton(
                      iconImagePath: "images/withdraw.png",
                      buttonText: "Withdraw",
                    ),
                    MyButton(
                      iconImagePath: "images/send.png",
                      buttonText: "Transfer",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 25),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  children: [
                    custumdetails(
                        imageUrl: "images/transcations.png",
                        tileTitle: "Transactions",
                        subTileTitle: "Recent Payments"),
                    SizedBox(
                      height: 20,
                    ),
                    custumdetails(
                        imageUrl: "images/report.png",
                        tileTitle: "Reports",
                        subTileTitle: "View reports"),
                  ],
                ),
              ),
              SizedBox(
                  height:
                      50), 
            ],
          ),
        ),
      ),
    );
  }
  void gotoAccounts() {
    Get.offAllNamed("/login");
  }
}
