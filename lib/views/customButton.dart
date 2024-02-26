// ignore_for_file: sort_child_properties_last

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/views/customText.dart';


class customButton extends StatelessWidget {
  final String buttonLabel;
  final VoidCallback? action;
  const customButton({
    super.key,
    this.action,
    required this.buttonLabel,
  });

  //final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: action,
        child: customText(
          label: buttonLabel,
          labelColor: appWhiteColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: appGreenColor,
          elevation: 10,
          padding: const EdgeInsets.all(20),
          shadowColor: primaryColor,
        

        ),
        );
  }
}
