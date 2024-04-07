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

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
                        label: 'Select wallet to deposit:',
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
                        label: 'Enter amount to deposit:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 20),
                      customTextField(userFieldController: amount),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          // Call depositTransaction with selected wallet
                          if (selectedWallet != null) {
                            depositTransaction(
                              toWalletId: selectedWallet!,
                              amount: double.parse(amount.text),
                            );
                          } else {
                            // Show error message if no wallet is selected
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('Error'),
                                  content: Text('Please select a wallet.'),
                                  actions: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text('OK'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          'Deposit',
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
Future<void> depositTransaction({
  required String toWalletId,
  required double amount,
}) async {
  try {
    // Perform HTTP request to deposit to the selected wallet
    final response = await http.post(
      Uri.parse('https://sanerylgloann.co.ke/wallet_app/createTranscation.php'),
      body: {
        'user_id': '123', // Replace '123' with the actual user ID
        'from_wallet_id':
            '', // Since this is a deposit, there's no 'from_wallet_id'
        'to_wallet_id': toWalletId,
        'transaction_type': 'deposit',
        'amount': amount.toString(),
        'transaction_date':
            DateTime.now().toString(), // Or use the actual transaction date
        'other_relevant_info':
            '', // Add any other relevant information if needed
      },
    );

    // Handle the response accordingly
    if (response.statusCode == 200) {
      final responseData = json.decode(response.body);
      if (responseData['success'] == 1) {
        print('Deposit transaction successful');
      } else {
        print(
            'Failed to perform deposit transaction: ${responseData['error']}');
      }
    } else {
      print('Failed to perform deposit transaction: ${response.reasonPhrase}');
    }
  } catch (error) {
    print('Error: $error');
  }
}
