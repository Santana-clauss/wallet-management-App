// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/views/customButton.dart';
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
            image:DecorationImage(image: AssetImage('/images/background.jpg'),
            fit:BoxFit.cover),
            
            //color: appGreenColor,
            // gradient: LinearGradient(
            //   begin: Alignment.topCenter,
            //   end: Alignment.bottomCenter,
            //   colors: [
            //     Color(0xFF88AB75), // Adjusted color
            //     Color(0xFF53734B), // Adjusted color
            //   ],
            // ),
            // borderRadius: BorderRadius.only(
            //   bottomLeft: Radius.circular(40),
            //   bottomRight: Radius.circular(40),
            // ),
            boxShadow: [
              BoxShadow(
                color: appGreenColor.withOpacity(0.2),
                spreadRadius: 5,
                blurRadius: 7,
                offset: Offset(0, 3),
              ),
            ],
          ),
          child: SafeArea(
            
            //padding: EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
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
                  // Container(
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(10))
                  //   ),
                  //   child: Image.asset(
                  //     'images/logow.jpg',
                  //     height: 100,
                  //     width: 100,
                  //   ),
                  // ),
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
                        color: Colors.white.withOpacity(0.74)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            customTextField(
                              userFieldController: firstNameController,
                              hint: "First Name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: lastNameController,
                              hint: "Last Name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: emailController,
                              hint: "youremail@example.com",
                              icon: Icons.email,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: phoneNumberController,
                              hint: "Phone number",
                              icon: Icons.phone,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: passwordController,
                              hint: "Password",
                              icon: Icons.lock,
                              hideText: true,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: renterPasswordController,
                              hint: "Re-enter password",
                              icon: Icons.lock,
                              hideText: true,
                            ),
                            SizedBox(height: 20),
                            customButton(buttonLabel: "Sign up",action: gotoLogin,),
                            // ElevatedButton(
                            //   onPressed: () {
                            //     Navigator.push(
                            //       context,
                            //       MaterialPageRoute(
                            //           builder: (BuildContext context) =>
                            //               Homepage()),
                            //     );
                            //   },
                            //   child: Text("Sign Up"),
                            //   style: ElevatedButton.styleFrom(
                            //     backgroundColor: Colors.green,
                            //     shape: RoundedRectangleBorder(
                            //       borderRadius: BorderRadius.circular(20),
                            //     ),
                            //     padding: const EdgeInsets.symmetric(
                            //       horizontal: 50,
                            //       vertical: 15,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(height: 25),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                customText(label: "Already have an account?",onTap: gotoLogin,),
                                customText(
                                      label: "Login here",
                                      labelColor: appGreenColor,
                                      onTap: gotoLogin),
                                
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

  void gotoLogin() {
    Get.offAllNamed("/login");
  }
  void gotoRegister() {
    Get.offAllNamed("/");
  }
}
