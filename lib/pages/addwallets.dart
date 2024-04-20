// ignore_for_file: use_build_context_synchronously, avoid_print, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

LoginController loginController = Get.put(LoginController());
var store = GetStorage();
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
            addAllWallets();
          },
          child: Text('Add Wallets and Proceed to login'),
        ),
      ),
    );
  }

  Future<void> addAllWallets() async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/addwallets.php'),
        body: {
          'user_id': store.read("userid").toString(),  
          'wallet_type': '',
        },
      );
      if (response.statusCode == 200) {
        print('All wallets added successfully');
        Get.offAndToNamed('/login');
      } else {
        print('Failed to add wallets: ${response.reasonPhrase}');
        
      }
    } catch (error) {
      print('Error adding wallets: $error');
    
    }
  }
}
