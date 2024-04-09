class TransactionModel {
  final int id;
  final int fromWalletId;
  final int toWalletId;
  final double amount;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.fromWalletId,
    required this.toWalletId,
    required this.amount,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      fromWalletId: json['from_wallet_id'],
      toWalletId: json['to_wallet_id'],
      amount: json['amount'].toDouble(),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'from_wallet_id': fromWalletId,
      'to_wallet_id': toWalletId,
      'amount': amount.toString(),
      'timestamp': timestamp.toString(),
    };
  }
}
