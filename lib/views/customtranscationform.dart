import 'package:flutter/material.dart';

class TransactionForm extends StatefulWidget {
  const TransactionForm({Key? key}) : super(key: key);

  @override
  _TransactionFormState createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _formKey = GlobalKey<FormState>();
  String _transactionType = 'deposit';
  TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField(
            value: _transactionType,
            onChanged: (value) {
              setState(() {
                _transactionType = value.toString();
              });
            },
            items: ['deposit', 'withdraw', 'transfer']
                .map((type) => DropdownMenuItem(
                      value: type,
                      child: Text(type.toUpperCase()),
                    ))
                .toList(),
          ),
          TextFormField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter an amount';
              }
              return null;
            },
            decoration: InputDecoration(
              labelText: 'Amount',
            ),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Process the transaction
                _submitTransaction();
              }
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  void _submitTransaction() {
    // Send transaction data to backend
    // Implement this method to send data to your backend API
    // You can use HTTP package or any other method to make API requests
    // Include transaction type and amount in the request body
    String amount = _amountController.text;
    // Send the data to backend
    // Example:
    // YourApiService().submitTransaction(_transactionType, amount);
  }
}
