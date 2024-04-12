import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:http/http.dart' as http;

TextEditingController amount = TextEditingController();
LoginController loginController = LoginController();
String? selectedWallet;

final Map<String, int> walletTypeToIdMap = {
  'Equity Card': 1,
  'Visa Card': 2,
  'KCB Card': 3,
};

class WithdrawalPage extends StatefulWidget {
  const WithdrawalPage({Key? key}) : super(key: key);

  @override
  _WithdrawalPageState createState() => _WithdrawalPageState();
}

class _WithdrawalPageState extends State<WithdrawalPage> {
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
                        label: 'Enter amount to withdraw:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 20),
                      customTextField(userFieldController: amount),
                      SizedBox(height: 40),
                      ElevatedButton(
                        onPressed: () {
                          if (selectedWallet != null) {
                            withdrawTransaction();
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
                        child: Text('Withdraw'),
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
                    'Withdraw',
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

  Future<void> withdrawTransaction() async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/withdraw.php'),
        body: {
          'user_id': loginController.user_id.value.toString(),
          'wallet_id': walletTypeToIdMap[selectedWallet]!.toString(),
          'transaction_type': "withdraw",
          'amount': amount.text.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1 &&
            responseData['new_balance'] != null) {
          final walletId = walletTypeToIdMap[selectedWallet]!;
          final newBalance = responseData['new_balance'];
          updateWalletBalance(walletId, newBalance);
          print('Withdrawal transaction successful');
          print(response.body);
        } else {
          print(
              'Successfully updated  for withdrawal transaction');
        }
      } else {
        print(
            'Failed to perform withdraw transaction: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  void updateWalletBalance(int walletId, double newBalance) async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/updatewallet.php'),
        body: {
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
