class TransactionModel {
  final String transaction_type;
  final int wallet_id;
  final double amount;
  //final String timestamp;

  TransactionModel({
    required this.transaction_type,
    required this.wallet_id,
    required this.amount,
    //required this.timestamp,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      transaction_type: json['transaction_type'],
      wallet_id: json['wallet_id'],
      amount: double.parse(json['amount']),
      //timestamp: json['timestamp'],
    );
  }
}
