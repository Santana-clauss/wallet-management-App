class WalletModel {
  final int walletId;
  final int userId;
  final String walletName;
  double balance;

  WalletModel({
    required this.walletId,
    required this.userId,
    required this.walletName,
    required this.balance,
  });

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return WalletModel(
      walletId: json['walletId'],
      userId: json['userId'],
      walletName: json['walletName'],
      balance: json['balance'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'walletId': walletId,
      'userId': userId,
      'walletName': walletName,
      'balance': balance,
    };
  }
}
