// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/pages/home.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstNameController = TextEditingController();
    final TextEditingController lastNameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController phoneNumberController = TextEditingController();
    final TextEditingController renterPasswordController =
        TextEditingController();

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF88AB75), // Adjusted color
                Color(0xFF53734B), // Adjusted color
              ],
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(40),
              bottomRight: Radius.circular(40),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            // Add padding to the SafeArea to prevent bottom overflow
            //padding: EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 20),
                  Image.asset(
                    'images/logow.jpg',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(height: 20),
                  customText(
                    label: "Hello,",
                    labelColor: Colors.white,
                    fontSize: 20,
                  ),
                  customText(
                    label: "Welcome",
                    labelColor: Colors.white,
                    fontSize: 20,
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customTextField(
                              userFieldController: firstNameController,
                              hint: "First Name",
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: lastNameController,
                              hint: "Last Name",
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: emailController,
                              hint: "youremail@example.com",
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: phoneNumberController,
                              hint: "Phone number",
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: passwordController,
                              hint: "Password",
                              hideText: true,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: renterPasswordController,
                              hint: "Re-enter password",
                              hideText: true,
                            ),
                            SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                          Homepage()),
                                );
                              },
                              child: Text("Sign Up"),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 50,
                                  vertical: 15,
                                ),
                              ),
                            ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                customText(label: "Already have an account?"),
                                GestureDetector(
                                  onTap: () {
                                    // Navigate to login screen
                                  },
                                  child: customText(
                                    label: "Login here",
                                    labelColor: Colors.green,
                                    onTap: gotoHome
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
   void gotoHome() {
    Get.offAllNamed("/login");
  }
}
