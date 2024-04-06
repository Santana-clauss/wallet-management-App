import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> withdrawTransaction(
    int userId, String fromWalletId, double amount) async {
  final url =
      Uri.parse('your_backend_url_here'); // Replace with your backend URL
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'user_id': userId,
      'from_wallet_id': fromWalletId,
      'transaction_type': 'withdraw',
      'amount': amount,
    }),
  );

  if (response.statusCode == 200) {
    // Transaction successful
    print('Withdraw transaction successful');
  } else {
    // Transaction failed
    print('Failed to perform withdraw transaction: ${response.body}');
  }
}

Future<void> depositTransaction(
    int userId, String toWalletId, double amount) async {
  final url =
      Uri.parse('your_backend_url_here'); // Replace with your backend URL
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'user_id': userId,
      'to_wallet_id': toWalletId,
      'transaction_type': 'deposit',
      'amount': amount,
    }),
  );

  if (response.statusCode == 200) {
    // Transaction successful
    print('Deposit transaction successful');
  } else {
    // Transaction failed
    print('Failed to perform deposit transaction: ${response.body}');
  }
}

Future<void> transferTransaction(
    int userId, String fromWalletId, String toWalletId, double amount) async {
  final url =
      Uri.parse('your_backend_url_here'); // Replace with your backend URL
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'user_id': userId,
      'from_wallet_id': fromWalletId,
      'to_wallet_id': toWalletId,
      'transaction_type': 'transfer',
      'amount': amount,
    }),
  );

  if (response.statusCode == 200) {
    // Transaction successful
    print('Transfer transaction successful');
  } else {
    // Transaction failed
    print('Failed to perform transfer transaction: ${response.body}');
  }
}
