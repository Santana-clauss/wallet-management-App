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
  List<double> balances = [0, 0, 0]; // Default balances, change as needed

  @override
  void initState() {
    super.initState();
    fetchBalances();
  }

Future<void> fetchBalances() async {
    try {
      final response = await http.get(Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/readwallet.php?user_id=3'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);

        setState(() {
          
          balances = [
            double.parse(data['Equity Card']),
            double.parse(data['Visa Card']),
            double.parse(data['KCB Card']),
          ];
        });
      } else {
        print('Failed to fetch balances: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching balances: $error');
    }
  }


  @override
  Widget build(BuildContext context) {
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
                      title: "Savings",
                      balance: balances[index],
                      color: Colors.green,
                    );
                  case 1:
                    return MyWallet(
                      title: "KCB Card",
                      balance: balances[index],
                      color: Colors.blue,
                    );
                  case 2:
                    return MyWallet(
                      title: "Visa Card",
                      balance: balances[index],
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
                    Navigator.pushNamed(context, '/accounts');
                  },
                  child: custumdetails(
                      imageUrl: "images/report.png",
                      tileTitle: "Accounts",
                      subTileTitle: "View your accounts"),
                ),
              ],
            ),
          ),
          SizedBox(height: 50),
        ],
      ),
    );
  }
}
