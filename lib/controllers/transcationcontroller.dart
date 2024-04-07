import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


class TransactionController extends GetxController {
  var transactions = <TransactionModel>[].obs;

  Future<void> depositTransaction({
    required String toWalletId,
    required double amount,
  }) async {
    try {
      // Perform HTTP request to deposit to the selected wallet
      final response = await http.post(
        Uri.parse(
            'https://sanerylgloann.co.ke/wallet_app/createTranscation.php'),
        body: {
          'wallet_id': toWalletId,
          'transaction_type': 'Deposit',
          'amount': amount.toString(),
        },
      );

      // Handle the response accordingly
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          print('Deposit transaction successful');
          await fetchTransactions(); // Fetch the updated transactions
        } else {
          print(
              'Failed to perform deposit transaction: ${responseData['error']}');
        }
      } else {
        print(
            'Failed to perform deposit transaction: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }

  Future<void> fetchTransactions() async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://sanerylgloann.co.ke/wallet_app/readTransactions.php'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final transactionList = responseData['transactions'] as List;
        transactions.value = transactionList
            .map((transaction) => TransactionModel.fromJson(transaction))
            .toList();
      } else {
        print('Failed to fetch transactions: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}
