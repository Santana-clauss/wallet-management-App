import 'dart:convert';
import 'package:flutter_app/model/transaction.dart';
import 'package:http/http.dart' as http;


class TransactionController {
  static const String baseUrl = '';

  Future<TransactionModel> recordDeposit(
      int userId, int walletId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/deposit'),
      body: jsonEncode({
        'user_id': userId,
        'wallet_id': walletId,
        'transaction_type': 'Deposit',
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to record deposit');
    }
  }

  Future<TransactionModel> recordWithdrawal(
      int userId, int walletId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/withdrawal'),
      body: jsonEncode({
        'user_id': userId,
        'wallet_id': walletId,
        'transaction_type': 'Withdrawal',
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to record withdrawal');
    }
  }

  Future<TransactionModel> recordTransfer(
      int userId, int fromWalletId, int toWalletId, double amount) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/transfer'),
      body: jsonEncode({
        'user_id': userId,
        'from_wallet_id': fromWalletId,
        'to_wallet_id': toWalletId,
        'transaction_type': 'Transfer',
        'amount': amount,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to record transfer');
    }
  }

  Future<TransactionModel> recordBillPayment(
      int userId, int walletId, double amount, String billDetails) async {
    final response = await http.post(
      Uri.parse('$baseUrl/transactions/bill-payment'),
      body: jsonEncode({
        'user_id': userId,
        'wallet_id': walletId,
        'transaction_type': 'Bill Payment',
        'amount': amount,
        'bill_details': billDetails,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return TransactionModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to record bill payment');
    }
  }
}
