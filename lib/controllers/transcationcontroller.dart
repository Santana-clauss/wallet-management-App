import 'dart:convert';
import 'package:flutter_app/model/walletsmodels.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class TransactionController {
  Future<void> depositTransaction({
    required String userId,
    required String toWalletId,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse(
            'https://sanerylgloann.co.ke/wallet_app/createTransaction.php'),
        body: {
          'user_id': userId,
          'to_wallet_id': toWalletId,
          'amount': amount.toString(),
          'transaction_date': DateTime.now().toString(),
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        if (responseData['success'] == 1) {
          print('Deposit transaction successful');
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

  Future<void> withdrawTransaction({
    required String fromWalletId,
    required double amount,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/withdraw.php'),
        body: {
          'from_wallet_id': fromWalletId,
          'amount': amount.toString(),
        },
      );

      if (response.statusCode == 200) {
        print('Withdraw transaction successful');
      } else {
        print(
            'Failed to perform withdraw transaction: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error: $error');
    }
  }
}

class WalletController {
  Future<List<Wallet>> fetchWallets() async {
    try {
      final response = await http.get(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/readWallets.php'),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        final walletList = responseData['wallets'] as List;
        return walletList.map((wallet) => Wallet.fromJson(wallet)).toList();
      } else {
        print('Failed to fetch wallets: ${response.reasonPhrase}');
        return [];
      }
    } catch (error) {
      print('Error: $error');
      return [];
    }
  }
}
class Transcationcontroller{
  var transcationList=[].obs;
  updateTranscationList(list){
    transcationList.value=list;
  }
}