import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/controllers/transcationcontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

TextEditingController amount = TextEditingController();
//TransactionController transactionController = Get.put(TransactionController());
LoginController loginController = Get.put(LoginController());
String? selectedWallet;

class DepositPage extends StatelessWidget {
  const DepositPage({Key? key}) : super(key: key);

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
                          selectedWallet = value;
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
                        onPressed: () => _deposit(context),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text('Deposit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _deposit(BuildContext context) async {
    try {
      if (selectedWallet != null) {
        var amountText = amount.text.trim();
        if (amountText.isNotEmpty) {
          var amountValue = double.tryParse(amountText);
          if (amountValue != null) {
            var response = await http.post(
              Uri.parse(
                'https://sanerylgloann.co.ke/wallet_app/createTranscation.php',
              ),
              body: jsonEncode(<String, dynamic>{
                'user_id': loginController.phoneNumber.value,
                'transaction_type': 'deposit',
                'amount': amountValue,
                'wallet_id': getWalletID(selectedWallet!),
              }),
            );
            if (response.statusCode == 200) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deposit successful'),
                  backgroundColor: Colors.green,
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deposit failed: ${response.body}'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Invalid amount entered'),
                backgroundColor: Colors.red,
              ),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Please enter an amount.'),
              backgroundColor: Colors.red,
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Please select a wallet.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      //Navigator.pushNamed(context, '/home');
                    },
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    'Deposit ',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

int getWalletID(String selectedWallet) {
  switch (selectedWallet) {
    case 'savings':
      return 1;
    case 'visa':
      return 2;
    case 'kcb':
      return 3;
    default:
      return 0; // Return a default value or handle the case where selectedWallet is not recognized
  }
}
