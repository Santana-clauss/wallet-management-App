// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/controllers.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customcard.dart';
import 'package:flutter_app/views/customedetails.dart';
import 'package:flutter_app/views/customtbutton.dart';
import 'package:get/get.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

HomeController homeController = Get.put(HomeController());

class Homepage extends StatelessWidget {
  final PageController _controller = PageController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Your homepage content here
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
                    color: greenColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(onTap:(){
                    Get.to(SettingsPage());

                  },child: Icon(Icons.settings)),
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
                  color: Colors.yellow,
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
          SizedBox(height: 25),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  child: MyButton(
                    iconImagePath: "images/send.png",
                    buttonText: "Transfer",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    // Navigator.pushNamed(context, '/accounts');
                  },
                  child: MyButton(
                    iconImagePath: "images/deposit.png",
                    buttonText: "Bills",
                  ),
                ),
                GestureDetector(
                  child: MyButton(
                    iconImagePath: "images/withdraw.png",
                    buttonText: "Withdraw",
                  ),
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
          SizedBox(height: 50),
        ],
      ),
    );
  }
}

