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

class ReportsPage extends StatelessWidget {
  final store = GetStorage(); // User ID of the logged-in user

  ReportsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Trigger the transaction fetching when the widget is built
    getTransactions();

    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Obx(
        () => transcationcontroller.transcationList.isEmpty
            ? Center(child: CircularProgressIndicator())
            : ListView.separated(
                itemCount: transcationcontroller.transcationList.length,
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Colors.grey[300],
                  height: 0,
                  thickness: 1,
                ),
                itemBuilder: (context, index) {
                  TransactionModel transaction =
                      transcationcontroller.transcationList[index];
                  return Card(
                    elevation: 3,
                    margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    child: ListTile(
                      leading: Icon(Icons.category),
                      title: Text(
                        'Transaction Type: ${transaction.transaction_type}',
                        style: TextStyle(fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4),
                         Text(
                            'Wallet type: ${getWalletType(transaction.wallet_id)}',
                            style: TextStyle(fontSize: 15),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Amount: \$${transaction.amount.toStringAsFixed(2)}',
                            style: TextStyle(fontSize: 14),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Time: ${transaction.timestamp}',
                            style: TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
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

        if (jsonResponse != null && jsonResponse['success'] == true) {
          final List<dynamic> transactionResponse =
              jsonResponse['transactions'];

          final List<TransactionModel> transactionList = transactionResponse
              .map((transactionJson) =>
                  TransactionModel.fromJson(transactionJson))
              .toList();

          transcationcontroller.updateTranscationList(transactionList);
        } else {
          print('Invalid JSON format or success field is false');
        }
      } else {
        print('Server error: ${response.statusCode}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
