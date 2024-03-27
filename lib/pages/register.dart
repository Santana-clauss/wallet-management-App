// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/pages/login.dart';
import 'package:flutter_app/views/customButton.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';

import 'package:http/http.dart' as http;


final TextEditingController fName = TextEditingController();
final TextEditingController lName = TextEditingController();
final TextEditingController email = TextEditingController();
final TextEditingController password = TextEditingController();
final TextEditingController phone = TextEditingController();
final TextEditingController renterPasswordController = TextEditingController();
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: double.infinity,
          decoration: BoxDecoration(
            image:DecorationImage(image: AssetImage('/images/background.jpg'),
            fit:BoxFit.cover),
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
                
                  SizedBox(height: 25),
                  customText(
                    label: "Your Mobile wallet",
                    labelColor: Colors.white,
                    fontSize: 20,
                    
                  ),
                  customText(
                    label: "Your Way",
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
                              userFieldController: fName,
                              hint: "First Name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: lName,
                              hint: "Last Name",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: email,
                              hint: "youremail@example.com",
                              icon: Icons.email,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: phone,
                              hint: "Phone number",
                              icon: Icons.phone,
                            ),
                            SizedBox(height: 15),
                            customTextField(
                              userFieldController: password,
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
                            // ElevatedButton(onPressed: (){
                            //   serverSignup();
                            //   Get.toNamed("/login");
                            //   style: ElevatedButton.styleFrom(
                            //    backgroundColor: greenColor,
                            //    foregroundColor: Colors.white,
                            //    shape: RoundedRectangleBorder(
                            //    borderRadius: BorderRadius.circular(20),)); 
                            // }, child: Text("Signup"))

                            customButton(buttonLabel: "Sign up",action: (){serverSignup();
                            Get.toNamed("/login");}
                            
                            ),
                            
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

 Future<void> serverSignup() async {
    http.Response response;
    var body={
      'phone': phone.text.trim(),
      'email': email.text.trim(),
      'fname': fName.text.trim(),
      'sname': lName.text.trim(),
      'password':password.text.trim(),
};
    response = await http.post(
      Uri.parse("https://sanerylgloann.co.ke/wallet_app/create_user.php"),
      body: body,
    );
    if (response.statusCode == 200) {
      var serverResponse = json.decode(response.body);
      int signedUp=serverResponse['success '];
      if (signedUp == 1) {
        Get.offAndToNamed('/login');
      } 
    }
}
}