// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/transcationcontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

TextEditingController amount = TextEditingController();
TransactionController transcationController = Get.put(TransactionController());

class WithdrawPage extends StatefulWidget {
  const WithdrawPage({Key? key}) : super(key: key);

  @override
  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  String? selectedWallet;

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
                  color: Colors.grey[200],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 20),
                      customText(
                        label: 'Select wallet to withdraw from:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 10),
                      DropdownButtonFormField<String>(
                        value: selectedWallet,
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
                          setState(() {
                            selectedWallet = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 15,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      customText(
                        label: 'Enter amount to withdraw:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 20),
                      customTextField(userFieldController: amount),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedWallet != null) {
                            withdrawTransaction(
                              fromWalletId: selectedWallet!,
                              amount: double.parse(amount.text),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Please select a wallet.'),
                              ),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          'Withdraw',
                        ),
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

Future<void> withdrawTransaction({
  required String fromWalletId,
  required double amount,
}) async {
  try {
    final response = await http.post(
      // Update the URL with the correct endpoint
      Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/withdraw.php'),
      body: jsonEncode({
        'fromWalletId': fromWalletId,
        'amount': amount,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print('Withdraw transaction successful');
    } else {
      print('Failed to perform withdraw transaction: ${response.body}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
