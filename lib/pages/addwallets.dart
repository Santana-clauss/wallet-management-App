import 'package:flutter/material.dart';
import 'package:flutter_app/config/const.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:flutter_app/views/customButton.dart';
import 'package:flutter_app/views/customText.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

LoginController loginController = Get.put(LoginController());
var store = GetStorage();

class AddWallets extends StatelessWidget {
  const AddWallets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: customText(
            label: "Track Wallets",
            labelColor: appWhiteColor,
            fontSize: 30,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            customText(
              label: "You are about to add the following default wallets:",
              fontSize: 18,
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView(
                children: [
                  _buildWalletItem(
                      name: "Equity",
                      icon: Icons.account_balance_wallet,
                      color: Colors.green),
                  _buildWalletItem(
                      name: "VISA",
                      icon: Icons.account_balance,
                      color: Colors.blue),
                  _buildWalletItem(
                      name: "KCB Card",
                      icon: Icons.account_balance,
                      color: Colors.blue),
                ],
              ),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor:greenColor,
                  foregroundColor: appWhiteColor,
                  elevation: 10,
                  padding: const EdgeInsets.all(20),
                  shadowColor: primaryColor,),
                onPressed: () {
                  addAllWallets();
                },
                child: Text('Add Wallets and Proceed to Login'),
              ),
              
            ),
            // GestureDetector(
            //   onTap: () {
            //     addAllWallets();
            //   },
            //   child: customButton(buttonLabel: 
            //   "Add Wallets and Proceed to Login",
            //   ),
            // )
          ],
        ),
      ),
    );
  }

  Widget _buildWalletItem(
      {required String name, required IconData icon, required Color color}) {
    return ListTile(
      leading: Icon(
        icon,
        color: color,
      ),
      title: Text(name),
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
