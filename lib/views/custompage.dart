// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';

TextEditingController amount=TextEditingController();

class MyPage extends StatelessWidget {
  const MyPage({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            backContainer(),
            Positioned(
              top: 120,
              child: Container(
                height: 500,
                width: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.grey[200], // Change container color here
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      customText(
                        label: 'Select wallet to deposit:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField(
                        borderRadius: BorderRadius.circular(20),
                        items: [
                          DropdownMenuItem(
                            value: 'savings',
                            child: Text('Savings Account'),
                          ),
                          DropdownMenuItem(
                            value: 'visa',
                            child: Text('Visa Card'),
                          ),
                          DropdownMenuItem(
                            value: 'kcb',
                            child: Text('KCB Card'),
                          ),
                        ],
                        onChanged: (value) {
                          // Handle wallet selection
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 15), // Adjust content padding
                          //border: InputBorder.none, 
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)
                          ),

                        ),
                      ),
                      SizedBox(height: 20),
                      customText(
                        label: 'Enter amount to deposit:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 20),
                      customTextField(userFieldController: amount),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Add logic to handle deposit
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green, 
                        ),
                        child: Text('Deposit',),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Column backContainer() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
        )
      ],
    );
  }
}
