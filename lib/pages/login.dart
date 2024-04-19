// ignore_for_file: unused_local_variable, must_be_immutable, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/controllers/sharepref.dart';
import 'package:flutter_app/views/customButton.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final TextEditingController phoneController = TextEditingController();
final TextEditingController passwordController = TextEditingController();
LoginController loginController = Get.put(LoginController());
//preferences myPref = preferences();
Prefs myPref=Prefs();
var store=GetStorage();

class LoginScreen extends StatelessWidget {
  bool isLogged = false;
  bool isRememberMe = false;
  //final Prefs _prefs = Prefs();
  LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    myPref.getString("phone").then((value) => {
          phoneController.text =value.toString()
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
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                SizedBox(height: 20),
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.transparent,
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
                              customText(label: "phone"),
                              customTextField(
                                userFieldController: phoneController,
                                icon: Icons.phone,
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
                                action: () {
                                  serverLogin();
                                },
                              ),
                              SizedBox(height: 25),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customText(label: "Don't have an account?"),
                                  GestureDetector(
                                    child: customText(
                                      label: "Sign up here",
                                      labelColor: appGreenColor,
                                      onTap: gotoRegister,
                                    ),
                                  ),
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
   myPref.addString("phone", phoneController.text);
    Get.toNamed("/home");
  }

  Future<void> serverLogin() async {
    http.Response response;
    try {
      response = await http.get(Uri.parse(
          "https://sanerylgloann.co.ke/wallet_app/read_user.php?phone=${phoneController.text.trim()}&password=${passwordController.text.trim()}"));

      print('Response Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        var responseBody = response.body;
        print('Response Body: $responseBody');

        if (responseBody.isNotEmpty) {
          var serverResponse = json.decode(responseBody);
          print('Server Response: $serverResponse');

          bool success = serverResponse['success'];
          if (success) {
            var userData = serverResponse['user'];
            var phone = userData['phone'];
            
            var userId = userData['user_id'];
            var username = userData['fname'];
            print(userId); // Get the user ID

            // Update the user ID in the login controller
            loginController.updateUserId(userId);
            store.write("userid", userId);
            loginController.updatefname(username);
            print(username);
            //loginController.updatePhoneNumber(phone);
            gotoHome();
          } else {
            showDialog(
              context: Get.overlayContext!,
              builder: (context) => AlertDialog(
                title: Text("Login Failed"),
                content: Text(serverResponse['message']),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("OK"),
                  ),
                ],
              ),
            );
          }
        } else {
          print("Empty response body");
        }
      } else {
        print("Server error: ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
