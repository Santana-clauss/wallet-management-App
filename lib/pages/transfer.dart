// Import necessary packages and libraries
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

var store = GetStorage();

class TransferPage extends StatefulWidget {
  const TransferPage({Key? key}) : super(key: key);

  @override
  _TransferPageState createState() => _TransferPageState();
}

class _TransferPageState extends State<TransferPage> {
  late TextEditingController amountController;
  String? selectedFromWallet;
  String? selectedToWallet;

  final Map<String, int> walletTypeToIdMap = {
    'Equity Card': 1,
    'Visa Card': 2,
    'KCB Card': 3,
  };

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: [
            // Background container
            _backContainer(),
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
                        label: 'Select wallet to transfer from:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 10),
                      // Dropdown for selecting 'from' wallet
                      DropdownButtonFormField<String>(
                        value: selectedFromWallet,
                        borderRadius: BorderRadius.circular(20),
                        items: walletTypeToIdMap.keys
                            .map((String key) => DropdownMenuItem(
                                  value: key,
                                  child: Text(key),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedFromWallet = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      customText(label: 'Select wallet to transfer to'),
                      // Dropdown for selecting 'to' wallet
                      DropdownButtonFormField<String>(
                        value: selectedToWallet,
                        borderRadius: BorderRadius.circular(20),
                        items: walletTypeToIdMap.keys
                            .map((String key) => DropdownMenuItem(
                                  value: key,
                                  child: Text(key),
                                ))
                            .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedToWallet = value;
                          });
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      customText(
                        label: 'Enter amount to transfer:',
                        fontSize: 18,
                      ),
                      SizedBox(height: 20),
                      // Text field for entering transfer amount
                      customTextField(userFieldController: amountController),
                      SizedBox(height: 40),
                      // Button to initiate transfer
                      ElevatedButton(
                        onPressed: () {
                          transferAmount();
                        },
                        style: ElevatedButton.styleFrom(
                          primary: Colors.green,
                        ),
                        child: Text(
                          'Transfer',
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

  // Widget for background container
  Column _backContainer() {
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
                  SizedBox(
                    width: 80,
                  ),
                  Text(
                    'Transfer ',
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

  // Function to handle transfer operation
  Future<void> transferAmount() async {
    try {
      final int userId = store.read("userid");
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/transfer.php'),
        body: {
          'user_id': userId.toString(),
          'from_wallet_id': walletTypeToIdMap[selectedFromWallet]!.toString(),
          'to_wallet_id': walletTypeToIdMap[selectedToWallet]!.toString(),
          'transaction_type': "transfer",
          'amount': amountController.text,
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          // Show success message to the user
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Success'),
              content: Text('Transfer successful'),
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
        } else {
          // Show error message to the user
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Error'),
              content:
                  Text('Failed to transfer amount: ${responseData['error']}'),
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
        // Show error message to the user
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text('Error'),
            content:
                Text('Failed to transfer amount: ${response.reasonPhrase}'),
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
    } catch (error) {
      // Show error message to the user
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('Error'),
          content: Text('Error: $error'),
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
  }

}
