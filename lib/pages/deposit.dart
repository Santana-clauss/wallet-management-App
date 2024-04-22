// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

TextEditingController amount = TextEditingController();
LoginController loginController = LoginController();
String? selectedWallet;
var store = GetStorage();

final Map<String, int> walletTypeToIdMap = {
  'Equity Card': 1,
  'Visa Card': 2,
  'KCB Card': 3,
};

class DepositPage extends StatefulWidget {
  const DepositPage({Key? key}) : super(key: key);

  @override
  _DepositPageState createState() => _DepositPageState();
}

class _DepositPageState extends State<DepositPage> {
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
                        onChanged: (value) {
                          setState(() {
                            selectedWallet = value;
                          });
                        },
                        items: [
                          DropdownMenuItem(
                            value: 'Equity Card',
                            child: Text('Equity card'),
                          ),
                          DropdownMenuItem(
                            value: 'Visa Card',
                            child: Text('Visa Card'),
                          ),
                          DropdownMenuItem(
                            value: 'KCB Card',
                            child: Text('KCB Card'),
                          ),
                        ],
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
                          if (selectedWallet != null) {
                            depositTransaction();
                          } else {
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
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  SizedBox(width: 120),
                  Text(
                    'Deposit',
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

  Future<void> depositTransaction() async {
    try {
      final int userId = store.read("userid");
      final int walletId = walletTypeToIdMap[selectedWallet]!;
      final double amountValue = double.parse(amount.text);
      print(userId);
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/deposit.php'),
        body: {
          'user_id': userId.toString(),
          'wallet_id': walletId.toString(),
          'amount': amountValue.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == true &&
            responseData['new_balance'] != null) {
          final newBalance = responseData['new_balance'];
          updateWalletBalance(userId, walletId, newBalance);
          print('Deposit transaction successful');
          print(response.body);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Successfully deposited'),
              duration: Duration(seconds: 2),
              backgroundColor: Colors.green,
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Success'),
              content: Text('Deposit successful '),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            ),
          );
        }
      } else {
        print(
            'Failed to perform deposit transaction: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void updateWalletBalance(int userId, int walletId, double newBalance) async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/updatewallet.php'),
        body: {
          'user_id': userId.toString(),
          'wallet_id': walletId.toString(),
          'new_balance': newBalance.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Wallet balance updated successfully');
      } else {
        print('Failed to update wallet balance: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error updating wallet balance: $error');
    }
  }
}
