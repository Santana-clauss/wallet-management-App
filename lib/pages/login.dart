// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

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
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  const Color(0xFF1B8D1E),
                  const Color(0xFF2ECC71),
                ],
              ),
            ),
          ),
          SafeArea(
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
                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              customText(label: "First Name"),
                              customTextField(
                                userFieldController: firstNameController,
                                hint: "First Name",
                              ),
                              customText(label: "Last Name"),
                              customTextField(
                                userFieldController: lastNameController,
                                hint: "Last Name",
                              ),
                              customText(label: "Email"),
                              customTextField(
                                userFieldController: emailController,
                                hint: "youremail@example.com",
                              ),
                              customText(label: "Phone Number"),
                              customTextField(
                                userFieldController: phoneNumberController,
                                hint: "Phone number",
                              ),
                              customText(label: "Password"),
                              customTextField(
                                userFieldController: passwordController,
                                hint: "Password",
                                hideText: true,
                              ),
                              customText(label: "Re-enter password"),
                              customTextField(
                                userFieldController: renterPasswordController,
                                hint: "Re-enter password",
                                hideText: true,
                              ),
                              SizedBox(height: 20),
                              ElevatedButton(
                                onPressed: () {},
                                child: Text("Sign Up"),
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 50,
                                    vertical: 15,
                                  ),
                                ),
                              ),
                              SizedBox(height: 25,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  customText(label: "Already have an account?"),
                                  GestureDetector(child: 
                                  Row(
                                    //mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      
                                      customText(label: "Login here",labelColor: Colors.blue,),
                                    ],
                                  )
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
}
