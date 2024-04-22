import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/pages/addwallets.dart';
import 'package:flutter_app/views/customcard.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final store = GetStorage();
LoginController loginController = Get.put(LoginController());

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  late List<double> balances = [0, 0, 0]; // Initialize balances list

  @override
  void initState() {
    super.initState();
    fetchBalances();
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
          setState(() {
            balances = responseData
                .map<double>((item) => double.parse(item['balance']))
                .toList();
          });
        } else if (responseData is Map<String, dynamic>) {
          // Handle map response
          setState(() {
            balances = [
              double.parse(responseData['Equity Card']),
              double.parse(responseData['Visa Card']),
              double.parse(responseData['KCB Card']),
            ];
          });
        }
      } else {
        print('Failed to fetch balances: ${response.statusCode}');
      }
    } catch (error) {
      print('Error fetching balances: $error');
    }
  }



  @override
  Widget build(BuildContext context) {
    List<MyWallet> accounts = [
      MyWallet(
        title: "EQUITY CARD",
        balance: balances[0], // Access balances using index
        cardNumber: 048934178,
        expiryMonth: 10,
        color: Colors.green,
        expiryYear: 2026,
      ),
      MyWallet(
        title: 'KCB Bank Card',
        balance: balances[1], // Access balances using index
        cardNumber: 1234567890123456,
        expiryMonth: 12,
        expiryYear: 2025,
        color: Colors.blue,
      ),
      MyWallet(
        title: 'Visa Credit Card',
        balance: balances[2], // Access balances using index
        cardNumber: 9876543210987654,
        expiryMonth: 6,
        expiryYear: 2026,
        color: Colors.purple,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Accounts'),
      ),
      body: ListView.builder(
        itemCount: accounts.length,
        itemBuilder: (context, index) {
          final account = accounts[index];
          return Card(
            child: ListTile(
              leading: account.cardNumber != null
                  ? Icon(Icons.credit_card)
                  : Icon(Icons.account_balance),
              title: Text(account.title),
              subtitle:
                  Text('Balance: \Kshs${account.balance.toStringAsFixed(2)}'),
              trailing: account.cardNumber != null
                  ? Text(account.cardNumber.toString())
                  : null,
              onTap: () {
                Get.offNamed('/home');
              },
            ),
          );
        },
      ),
    );
  }
}
