import 'package:flutter/material.dart';

class WithdrawalPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Withdrawal'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Amount to Withdraw',
              ),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Implement withdrawal logic here
                // For example, deduct the entered amount from the user's wallet balance
                // and update the balance accordingly
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Withdrawal request submitted.'),
                  ),
                );
              },
              child: Text('Withdraw'),
            ),
          ],
        ),
      ),
    );
  }
}
