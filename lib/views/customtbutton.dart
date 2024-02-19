// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';


class MyButton extends StatelessWidget {
  final iconImagePath;
  final buttonText;
  const MyButton({
    super.key,
    required this.iconImagePath,
    required this.buttonText
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Column(
          children: [
            Container(
                height: 90,
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.shade300,
                          blurRadius: 40,
                          spreadRadius: 10)
                    ]),
                child: Center(
                    child: Image.asset(iconImagePath),
                    )),
          ],
        ),
        SizedBox(height: 12 ),
        Text(
          buttonText,
          style:TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.black
          )
        )
      ],
    );
  }
}
