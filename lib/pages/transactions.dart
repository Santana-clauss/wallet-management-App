import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/transcationcontroller.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Transcationcontroller transcationcontroller = Get.put(Transcationcontroller());

class TranscationPage extends StatelessWidget {
  const TranscationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Transactions'),
        automaticallyImplyLeading: true,
      ),
      body: FutureBuilder<void>(
        future: getTransactions(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return Obx(
              () => ListView.builder(
                itemCount: transcationcontroller.transcationList.length,
                itemBuilder: (context, index) {
                  TransactionModel transaction =
                      transcationcontroller.transcationList[index];
                  return ListTile(
                    leading: Icon(Icons.category),
                    title: Text(
                      'From: ${transaction.fromWalletId}',
                      style: TextStyle(fontSize: 18),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'To: ${transaction.toWalletId}',
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          'Amount: ${transaction.amount.toStringAsFixed(2)}', // Format amount to display two decimal places
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }

  Future<void> getTransactions() async {
    try {
      final response = await http.get(Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/readTranscations.php'));

      if (response.statusCode == 200) {
        
        if (response.body.startsWith('[')) {
          final List<dynamic> transactionResponse = json.decode(response.body);
          final List<TransactionModel> transactionList = transactionResponse
              .map((transaction) => TransactionModel.fromJson(transaction))
              .toList();
          transcationcontroller.updateTranscationList(transactionList);
        } else {
       
          print(response.body);
          throw FormatException('HTML error response: ${response.body}');
          
        }
      } else {
        print('Server error: ${response.statusCode}');
        throw Exception('Server error: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
      throw error;
    }
  }
}
