class TransactionModel {
  final int id;
  final int walletId;
  final String transactionType;
  final double amount;
  final DateTime timestamp;

  TransactionModel({
    required this.id,
    required this.walletId,
    required this.transactionType,
    required this.amount,
    required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'],
      walletId: json['wallet_id'],
      transactionType: json['transaction_type'],
      amount: double.parse(json['amount'].toString()),
      timestamp: DateTime.parse(json['timestamp']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'wallet_id': walletId,
      'transaction_type': transactionType,
      'amount': amount,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}
