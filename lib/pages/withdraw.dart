// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/views/customText.dart';

class WithdrawPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdraw'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20),
            customText(
              label: 'Select wallet to withdraw from:',
              fontSize: 18,
              
            ),
            SizedBox(height: 10),
            DropdownButtonFormField(
              items: [
                DropdownMenuItem(
                  child: Text('Savings Account'),
                  value: 'savings',
                ),
                DropdownMenuItem(
                  child: Text('Visa Card'),
                  value: 'visa',
                ),
                DropdownMenuItem(
                  child: Text('KCB Card'),
                  value: 'kcb',
                ),
              ],
              onChanged: (value) {
                // Handle wallet selection
              },
              decoration: InputDecoration(
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            customText(
              label: 'Enter amount to withdraw:',
              fontSize: 18,
              
            ),
            SizedBox(height: 20),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Amount',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logic to handle withdrawal
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
