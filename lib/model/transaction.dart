class TransactionModel {
  final int transactionId;
  final int userId;
  final int fromWalletId;
  final int toWalletId;
  final String transactionType;
  final double amount;
  final DateTime transactionDate;
  final String otherRelevantInfo;

  TransactionModel({
    required this.transactionId,
    required this.userId,
    required this.fromWalletId,
    required this.toWalletId,
    required this.transactionType,
    required this.amount,
    required this.transactionDate,
    required this.otherRelevantInfo,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transactionId: json['transaction_id'],
      userId: json['user_id'],
      fromWalletId: json['from_wallet_id'],
      toWalletId: json['to_wallet_id'],
      transactionType: json['transaction_type'],
      amount: json['amount'],
      transactionDate: DateTime.parse(json['transaction_date']),
      otherRelevantInfo: json['other_relevant_info'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transaction_id': transactionId,
      'user_id': userId,
      'from_wallet_id': fromWalletId,
      'to_wallet_id': toWalletId,
      'transaction_type': transactionType,
      'amount': amount,
      'transaction_date': transactionDate.toIso8601String(),
      'other_relevant_info': otherRelevantInfo,
    };
  }
}
