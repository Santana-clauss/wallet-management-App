import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:flutter_app/views/customTextField.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

var store = GetStorage();

class SendPage extends StatefulWidget {
  const SendPage({Key? key}) : super(key: key);

  @override
  _SendPageState createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  late TextEditingController amountController;
  String? selectedFromWallet;
  String? selectedToWallet;
  late TextEditingController phoneNumberController;

  final Map<String, int> walletTypeToIdMap = {
    'Equity Card': 1,
    'Visa Card': 2,
    'KCB Card': 3,
  };

  @override
  void initState() {
    super.initState();
    amountController = TextEditingController();
    phoneNumberController = TextEditingController();
  }

  @override
  void dispose() {
    amountController.dispose();
    phoneNumberController.dispose();
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
            backContainer(),
            Positioned(
              top: 10,
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Container(
                    height: 700,
                    width: 400,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey[200],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(height: 0),
                          Center(child: customText(label: "Send",fontSize: 40,)),
                          customText(
                            label: 'Select wallet to transfer from:',
                            fontSize: 18,
                          ),
                        SizedBox(height: 5),
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
                        SizedBox(height: 15),
                        customText(
                          label: 'Select wallet to send to:',
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
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
                        SizedBox(height: 15),
                        customText(
                          label: 'Enter recipient\'s phone number:',
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        customTextField(userFieldController: phoneNumberController),
                        SizedBox(height: 15),
                        customText(
                          label: 'Enter amount to send:',
                          fontSize: 18,
                        ),
                        SizedBox(height: 10),
                        customTextField(userFieldController: amountController),
                        SizedBox(height: 35),
                        ElevatedButton(
                          onPressed: () {
                            sendAmount();
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green,
                          ),
                          child: Text(
                            'Send',
                          ),
                        ),
                      ],
                    ),
                  ),
                          ),
                ),
              ))],
          ),
        ),
      );
    
  }

   Column backContainer() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 300,
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
                  // Text(
                  //   'Send',
                  //   style: TextStyle(
                  //     fontSize: 40,
                  //     fontWeight: FontWeight.bold,
                  //     color: Colors.white,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    
  }

  Future<void> fetchBalances() async {
    try {
      final userId = store.read("userid") ?? "default_user_id";
      final response = await http.get(Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/readwallet.php?user_id=$userId'));

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        if (responseData is List) {
          // Handle list response
          // Update balances in the UI
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response
          // Update balances in the UI
        }
      } else {
        print('Failed to fetch balances: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching balances: $error');
    }
  }

  Future<void> sendAmount() async {
    try {
      final int userId = store.read("userid");
      final int fromWalletId = walletTypeToIdMap[selectedFromWallet]!;
      final int toWalletId = walletTypeToIdMap[selectedToWallet]!;
      final String phoneNumber = phoneNumberController.text;
      final double amount = double.parse(amountController.text);

      // Query backend to transfer amount
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/send.php'),
        body: {
          'user_id': userId.toString(),
          'from_wallet_id': fromWalletId.toString(),
          'to_wallet_id': toWalletId.toString(),
          'to_phone_number': phoneNumber,
          'amount': amount.toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          await fetchBalances();
          showDialog(
            context: context,
            builder: (_) => AlertDialog(
              title: Text('Success'),
              content: Text('Sent successful'),
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
          showErrorDialog(
              'Failed to transfer amount: ${responseData['error']}');
        }
      } else {
        showErrorDialog('Failed to transfer amount: ${response.reasonPhrase}');
      }
    } catch (error) {
      showErrorDialog('Error: $error');
    }
  }

  void showErrorDialog(String errorMessage) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text('Error'),
        content: Text(errorMessage),
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
