// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/controllers.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/pages/deposit.dart';
import 'package:flutter_app/pages/settings.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customcard.dart';
import 'package:flutter_app/views/customedetails.dart';
import 'package:flutter_app/views/customtbutton.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

HomeController homeController = Get.put(HomeController());
LoginController loginController = Get.put(LoginController());

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final PageController _controller = PageController();
  List<double> balances = [0, 0, 0];

  get userId => loginController.user_id;

  @override
  void initState() {
    super.initState();
    fetchBalances();
  }

  @override
  Widget build(BuildContext context) {
     //final screenWidth = MediaQuery.of(context).size.width;

    return SingleChildScrollView(
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
                      label: "Hello ${loginController.fname.toString()}!",
                      fontSize: 14,
                      labelColor: appGreyColor,
                    ),
                    // customText(
                    //   label: loginController.fname.toString(),
                    //   fontSize: 24,
                    // ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: greenColor.withOpacity(0.1),
                    shape: BoxShape.circle,
                  ),
                  child: GestureDetector(
                      onTap: () {
                        Get.to(SettingsPage());
                      },
                      child: Icon(Icons.settings)),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 200,
            child: PageView.builder(
              controller: _controller,
              scrollDirection: Axis.horizontal,
              itemCount: balances.length,
              itemBuilder: (context, index) {
                switch (index) {
                  case 0:
                    return MyWallet(
                      title: "EQUITY CARD",
                      balance: balances[index],
                      cardNumber: 048934178,
                      expiryMonth: 4,
                      expiryYear: 24,
                      color: Colors.green,
                    );
                  case 1:
                    return MyWallet(
                      title: "VISA Card",
                      balance: balances[index],
                      cardNumber: 1234567890123456,
                      expiryMonth: 10,
                      expiryYear: 25,
                      color: Colors.blue,
                    );
                  case 2:
                    return MyWallet(
                      title: "KCB Card",
                      balance: balances[index],
                      cardNumber: 9876543210987654,
                      expiryMonth: 5,
                      expiryYear: 26,
                      color: Color.fromARGB(255, 214, 185, 23),
                    );
                  default:
                    return Container();
                }
              },
            ),
          ),
          SizedBox(height: 25),
          Container(
            height: 16, // Adjust the height as needed
            child: SmoothPageIndicator(
              controller: _controller,
              count: balances.length,
              effect: ExpandingDotsEffect(activeDotColor: Colors.black),
            ),
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
                  onTap: () {
                    Navigator.pushNamed(context, '/transfer');
                  },
                  child: MyButton(
                    iconImagePath: "images/send.png",
                    buttonText: "Transfer",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/deposit');
                  },
                  child: MyButton(
                    iconImagePath: "images/deposit.png",
                    buttonText: "Deposit",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/withdraw');
                  },
                  child: MyButton(
                    iconImagePath: "images/withdraw.png",
                    buttonText: "Withdraw",
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/send');
                  },
                  child: MyButton(
                    iconImagePath: "images/transfer.png",
                    buttonText: "Send",
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
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/transcation');
                  },
                  child: custumdetails(
                      imageUrl: "images/transcations.png",
                      tileTitle: "Transactions",
                      subTileTitle: "Recent Payments"),
                ),
                SizedBox(
                  height: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/reports');
                  },
                  child: custumdetails(
                      imageUrl: "images/report.png",
                      tileTitle: "Reports",
                      subTileTitle: "View reports"),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
   Future<void> fetchBalances() async {
    try {
      final userId = store.read("userid") ?? "default_user_id";
      final response = await http.get(Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/readwallet.php?user_id=$userId'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          // Handle list response
          setState(() {
            balances = responseData
                .map<double>((item) => double.parse(item['balance']))
                .toList();
          });
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response
          setState(() {
            balances = [
              double.parse(responseData['Equity Card']),
              double.parse(responseData['Visa Card']),
              double.parse(responseData['KCB Card']),
            ];
          });
        }
      } else {
        print('Failed to fetch balances: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching balances: $error');
    }
  }
}
