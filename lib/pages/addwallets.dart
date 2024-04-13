import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

LoginController loginController = Get.put(LoginController());
class AddWallets extends StatelessWidget {
  //final int userId; // User ID obtained upon login

  const AddWallets({Key? key,})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: customText(label: "Add Wallets",labelColor: appWhiteColor,fontSize: 30,),
        backgroundColor: Colors.green,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            addAllWallets(context);
          },
          child: Text('Add Wallets and Proceed to Homepage'),
        ),
      ),
    );
  }

  Future<void> addAllWallets(BuildContext context) async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/addwallets.php'),
        body: {
          'user_id': loginController.user_id.value.toString,
          'wallet_type': '',
        },
      );
      if (response.statusCode == 200) {
        print('All wallets added successfully');
        Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
      } else {
        print('Failed to add wallets: ${response.reasonPhrase}');
        
      }
    } catch (error) {
      print('Error adding wallets: $error');
    
    }
  }
}