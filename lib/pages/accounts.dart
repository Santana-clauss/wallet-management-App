import 'package:flutter/material.dart';
import 'package:flutter_app/views/customcard.dart';

class AccountsPage extends StatefulWidget {
  @override
  _AccountsPageState createState() => _AccountsPageState();
}

class _AccountsPageState extends State<AccountsPage> {
  List<MyWallet> accounts = [
    MyWallet(
      title: 'Savings Account',
      balance: 5000.0,
      color: Colors.green,
    ),
    MyWallet(
      title: 'KCB Bank Card',
      balance: 3000.0,
      cardNumber: 1234567890123456,
      expiryMonth: 12,
      expiryYear: 2025,
      color: Colors.blue,
    ),
    MyWallet(
      title: 'Visa Credit Card',
      balance: 2000.0,
      cardNumber: 9876543210987654,
      expiryMonth: 6,
      expiryYear: 2026,
      color: Colors.purple,
    ),
  ];

  @override
  Widget build(BuildContext context) {
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
                  Text('Balance: \$${account.balance.toStringAsFixed(2)}'),
              trailing: account.cardNumber != null
                  ? Text(account.cardNumber.toString())
                  : null,
              onTap: () {
                // Show account details or edit dialog
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // Show dialog to add a new account
        },
      ),
    );
  }
}
