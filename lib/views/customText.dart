import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';

class customText extends StatelessWidget {
  final String label;
  final Color labelColor;
  final double fontSize;
  const customText({
    super.key, 
    required this.label,
    this.labelColor=appGreyColor,
    this.fontSize=16, });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
          color: labelColor,fontSize:fontSize, fontWeight: FontWeight.bold,),
    );
  }
}
