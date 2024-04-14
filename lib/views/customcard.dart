// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyWallet extends StatelessWidget {
  final String title;
  final double balance;
  final int? cardNumber;
  final int? expiryMonth;
  final int? expiryYear;
  final Color color;

  MyWallet({
    required this.title,
    required this.balance,
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.symmetric(horizontal: 25),
      width: MediaQuery.of(context).size.width * 0.8,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Align children center
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            textAlign: TextAlign.center, // Center align title
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          Text(
            "Balance: \Kshs.$balance",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 10),
          if (cardNumber != null)
            Text(
              "Card Number: $cardNumber",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          Text(
            "Expiry Date: $expiryMonth/$expiryYear",
            style: TextStyle(
              fontSize: 16,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
