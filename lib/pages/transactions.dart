import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/transcationcontroller.dart';
import 'package:flutter_app/model/transactionmodel.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

final Map<int, String> walletIdToTypeMap = {
  1: 'Equity Card',
  2: 'Visa Card',
  3: 'KCB Card',
};

TranscationController transcationcontroller = Get.put(TranscationController());

class TranscationPage extends StatelessWidget {
  final store = GetStorage(); // User ID of the logged-in user

  TranscationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger the transaction fetching when the widget is built
    getTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Transactions')),
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => transcationcontroller.transcationList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.builder(
                itemCount: transcationcontroller.transcationList.length,
                itemBuilder: (context, index) {
                  TransactionModel transaction =
                      transcationcontroller.transcationList[index];
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(
                      'Transaction Type: ${transaction.transaction_type}',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Wallet: ${getWalletType(transaction.wallet_id)}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Amount: ${transaction.amount.toString()}',
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
      ),
    );
  }

  String getWalletType(int walletId) {
    return walletIdToTypeMap[walletId] ?? 'Unknown';
  }

  Future<void> getTransactions() async {
    try {
      final userId = store.read("userid") ?? "default_user_id";
      final response = await http.get(
        Uri.parse(
            'https://sanerylgloann.co.ke/wallet_app/readTranscations.php?user_id=$userId'),
      );

      if (response.statusCode == 200) {
        final dynamic jsonResponse = json.decode(response.body);
        final List<dynamic> transactionResponse =
            jsonResponse is List ? jsonResponse : [jsonResponse];

        final List<TransactionModel> transactionList = transactionResponse
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
        transcationcontroller.updateTranscationList(transactionList);
      } else {
        print('Server error: ${response.statusCode}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      // Handle error display or retry mechanism here
    }
  }
}
