// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors
import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/utils/preferences.dart';
import 'package:flutter_app/views/customButton.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';

final TextEditingController userNameController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
preferences myPref=preferences();
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myPref.getValue("username").then((value) => {
      userNameController.text=value
    });
  
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("images/background.jpg"),
                    fit: BoxFit.cover)
        
               
                ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                    radius: 50, 
                    backgroundColor: Colors
                        .transparent, 
                    child: ClipOval(
                      child: Image.asset(
                        'images/logow.jpg',
                        height: 100,
                        width: 100,
                        fit: BoxFit.cover, 
                      ),
                    ),
                  ),
                SizedBox(height: 20),
                SizedBox(height: 20),
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white.withOpacity(0.74),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customText(label: "username"),
                              customTextField(
                                userFieldController: userNameController,
                                //hint: "youremail@example.com",
                                icon: Icons.email,
                              ),
                              customText(label: "Password"),
                              customTextField(
                                userFieldController: passwordController,
                                hint: "Password",
                                icon: Icons.lock,
                                hideText: true,
                              ),
                              SizedBox(height: 20),
                              customButton(
                                buttonLabel: "Login",
                                action: gotoHome,
                              ),
                              SizedBox(
                                height: 25,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customText(label: "Don't have an account?"),
                                  GestureDetector(
                                      child: Row(
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      customText(
                                          label: "Sign up here",
                                          labelColor: appGreenColor,
                                          onTap: gotoRegister),
                                    ],
                                  )),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void gotoRegister() {
    Get.offAllNamed("/");
  }

  void gotoHome() {
    myPref.setValue("username", userNameController.text);
    Get.offAllNamed("/home");
  }
}
