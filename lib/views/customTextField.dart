// ignore: file_names
// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

// ignore: camel_case_types
class customTextField extends StatelessWidget {
  final IconData? icon;
  final bool hideText;
  final bool isPassword;
  final String? hint;
  const customTextField({
    super.key,
    required this.userFieldController,
    this.icon,
    this.hideText=false,
    this.isPassword=false,
    this.hint
  });

  final TextEditingController userFieldController;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorRadius:  Radius.elliptical(5, 0),
      controller: userFieldController,
      decoration:  InputDecoration(
        hintText:hint,
        border:OutlineInputBorder(
          borderRadius:const BorderRadius.all(Radius.circular(10))),
          prefixIcon: Icon(icon),
          // ignore: sized_box_for_whitespace
          suffixIcon: isPassword?Icon(Icons.visibility):Container(height: 8,width: 8,)), 
          obscureText: hideText,
    );
    
  }
}
