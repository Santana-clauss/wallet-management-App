import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class ReportsPage extends StatefulWidget {
  @override
  _ReportsPageState createState() => _ReportsPageState();
}

class _ReportsPageState extends State<ReportsPage> {
  // Sample data for total balance and transactions
  double totalBalance = 5000.0;
  List<Transaction> transactions = [
    Transaction(
      date: DateTime.now(),
      amount: -50.0,
      category: 'Food',
      description: 'Groceries',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 2)),
      amount: -20.0,
      category: 'Entertainment',
      description: 'Movie Tickets',
    ),
    Transaction(
      date: DateTime.now().subtract(Duration(days: 5)),
      amount: -100.0,
      category: 'Bills',
      description: 'Electricity Bill',
    ),
    // Add more sample transactions here
  ];

  // Filter options
  DateTime? startDate;
  DateTime? endDate;
  String? selectedAccount;
  String? selectedTransactionType;

  // Chart data
  late List<charts.Series<Transaction, String>> _chartData;

  @override
  void initState() {
    super.initState();
    _generateChartData();
  }

  void _generateChartData() {
    _chartData = [
      charts.Series<Transaction, String>(
        id: 'Expenses',
        domainFn: (transaction, _) => transaction.category,
        measureFn: (transaction, _) => transaction.amount.abs(),
        data: transactions,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Total Balance: \$${totalBalance.toStringAsFixed(2)}'),
            SizedBox(height: 16.0),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Start Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: startDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          startDate = selectedDate;
                        });
                      }
                    },
                  ),
                ),
                SizedBox(width: 16.0),
                Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'End Date',
                      prefixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: () async {
                      final selectedDate = await showDatePicker(
                        context: context,
                        initialDate: endDate ?? DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      );
                      if (selectedDate != null) {
                        setState(() {
                          endDate = selectedDate;
                        });
                      }
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Account',
                prefixIcon: Icon(Icons.account_balance_wallet),
              ),
              value: selectedAccount,
              onChanged: (value) {
                setState(() {
                  selectedAccount = value;
                });
              },
              items: ['All', 'Savings', 'KCB Card', 'Visa Card']
                  .map((account) => DropdownMenuItem(
                        value: account,
                        child: Text(account),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                labelText: 'Transaction Type',
                prefixIcon: Icon(Icons.swap_vert),
              ),
              value: selectedTransactionType,
              onChanged: (value) {
                setState(() {
                  selectedTransactionType = value;
                });
              },
              items: ['Withdrawals', 'Bills', 'Sent']
                  .map((type) => DropdownMenuItem(
                        value: type,
                        child: Text(type),
                      ))
                  .toList(),
            ),
            SizedBox(height: 16.0),
            Expanded(
              child: charts.PieChart(
                _chartData,
                animate: true,
                animationDuration: Duration(seconds: 1),
                behaviors: [
                  charts.DatumLegend(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Transaction {
  final DateTime date;
  final double amount;
  final String category;
  final String description;

  Transaction({
    required this.date,
    required this.amount,
    required this.category,
    required this.description,
  });
}
