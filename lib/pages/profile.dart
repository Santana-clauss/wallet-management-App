// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/views/customButton.dart';
import 'package:flutter_app/views/customProfile.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customedetails.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(25.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: Icon(Icons.arrow_back)),
                  Icon(Icons.settings),
                ],
              ),
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('/images/woman.png'),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(20),
                    //border:Border.all(),
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 2,
                        color: Colors.red.withOpacity(0.3),
                      )
                    ]),
                //child: Image.asset("/images/woman.png")),
              ),
              customText(label: "Santana Clauss"),
              customText(label: "santanaclauss@gmail.com"),
              SizedBox(
                height: 20,
              ),
              //customButton(buttonLabel: "Edit Profile",),
              ElevatedButton(
                  onPressed: () {},
                  child: customButton(buttonLabel: "Edit Profile"),
                  style:
                      ElevatedButton.styleFrom(backgroundColor: primaryColor)),
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
                    subTileTitle: "Manage your saved wallet"),
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
                        myIcon: Icon(Icons.person), myText: "My Account"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                        myIcon: Icon(Icons.notification_add),
                        myText: "Notifications"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                        myIcon: Icon(Icons.privacy_tip), myText: "Privacy"),
                    SizedBox(
                      height: 20,
                    ),
                    CustomProfile(
                        myIcon: Icon(Icons.account_balance_rounded),
                        myText: "About"),
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
