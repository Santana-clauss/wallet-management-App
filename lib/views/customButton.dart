import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/views/customText.dart';


class customButton extends StatelessWidget {
  final String buttonLabel;
  const customButton({
    super.key,
    
    required this.buttonLabel,
  });

  //final TextEditingController userNameController;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: () {
        //  print("Button clicked ${userNameController.text}");
        },
        child: customText(
          label: buttonLabel,
          labelColor: appWhiteColor,
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          elevation: 10,
          padding: const EdgeInsets.all(20),
          shadowColor: primaryColor,
        

        ),
        );
  }
}
