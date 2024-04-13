// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/views/customProfile.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customedetails.dart';

class ProfilePage extends StatefulWidget {
  final int userId;

  const ProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  String fname = "";
  String lname = "";
  String email = "";
  String phone = "";

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sanerylgloann.co.ke/wallet_app/profile.php?user_id=${widget.userId}'),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userDetails = data['userDetails'];
        setState(() {
          fname = userDetails['fname'] ?? '';
          lname = userDetails['lname'] ?? '';
          email = userDetails['email'] ?? '';
          phone = userDetails['phone'] ?? '';
        });
      } else {
        throw Exception(
          'Failed to load user details. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching user details: $e');
      setState(() {
        fname = 'Error';
        lname = 'Error';
        email = 'Error';
        phone = 'Error';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('/images/woman.png'),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 5,
                      spreadRadius: 2,
                      color: Colors.red.withOpacity(0.3),
                    )
                  ],
                ),
              ),
              customText(label: fname.isNotEmpty ? fname : "Loading..."),
              customText(label: lname.isNotEmpty ? lname : "Loading..."),
              customText(label: email.isNotEmpty ? email : "Loading..."),
              customText(label: phone.isNotEmpty ? phone : "Loading..."),
              SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushNamed(context, "/updateProfile");
                },
                style: ElevatedButton.styleFrom(
                  primary: greenColor,
                  onPrimary: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Text("Edit Profile"),
              ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customText(
                    label: "General",
                    fontSize: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: custumdetails(
                  imageUrl: "/images/wallet.png",
                  tileTitle: "My Wallet",
                  subTileTitle: "Manage your saved wallet",
                ),
              ),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  customText(
                    label: "Account",
                    fontSize: 20,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  children: [
                    CustomProfile(
                      myIcon: Icon(Icons.person),
                      myText: "My Account",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                      myIcon: Icon(Icons.notification_add),
                      myText: "Notifications",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                      myIcon: Icon(Icons.privacy_tip),
                      myText: "Privacy",
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                      myIcon: Icon(Icons.account_balance_rounded),
                      myText: "About",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
