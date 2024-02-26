import 'package:flutter/material.dart';

class TransactionsPage extends StatefulWidget {
  @override
  _TransactionsPageState createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> {
  List<Transaction> transactions = [
    Transaction(
        date: DateTime.now(),
        amount: -50.0,
        description: 'Groceries',
        type: TransactionType.debit),
    Transaction(
        date: DateTime.now().subtract(Duration(days: 2)),
        amount: 1000.0,
        description: 'Salary',
        type: TransactionType.credit),
    // Add more sample transactions here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search transactions',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.filter_list),
                  onPressed: () {
                    // Show filter options
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: transactions.length,
              itemBuilder: (context, index) {
                final transaction = transactions[index];
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(
                      transaction.type == TransactionType.debit ? '-' : '+',
                      style: TextStyle(
                        color: transaction.type == TransactionType.debit
                            ? Colors.red
                            : Colors.green,
                      ),
                    ),
                  ),
                  title: Text(transaction.description),
                  subtitle: Text(transaction.date.toString()),
                  trailing: Text('${transaction.amount.toStringAsFixed(2)}'),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () {
              // Show dialog to add/edit transaction
            },
            child: Text('Add Transaction'),
          ),
        ],
      ),
    );
  }
}

class Transaction {
  final DateTime date;
  final double amount;
  final String description;
  final TransactionType type;

  Transaction({
    required this.date,
    required this.amount,
    required this.description,
    required this.type,
  });
}

enum TransactionType { debit, credit }
