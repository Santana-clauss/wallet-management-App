class Transaction {
  final int transactionId;
  final int userId;
  final int walletId;
  final String transactionType;
  final double amount;

  Transaction({
    required this.transactionId,
    required this.userId,
    required this.walletId,
    required this.transactionType,
    required this.amount,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      transactionId: json['transactionId'],
      userId: json['userId'],
      walletId: json['walletId'],
      transactionType: json['transactionType'],
      amount: json['amount'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'transactionId': transactionId,
      'userId': userId,
      'walletId': walletId,
      'transactionType': transactionType,
      'amount': amount,
    };
  }
}
