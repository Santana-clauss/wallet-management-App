// import 'package:flutter/material.dart';
// import 'package:flutter_app/config/const.dart';
// import 'package:flutter_app/controllers/controllers.dart';
// import 'package:flutter_app/model/walletsmodels.dart';
// import 'package:flutter_app/views/customText.dart';
// import 'package:flutter_app/views/customtbutton.dart';
// import 'package:get/get.dart';

// class AddWalletsPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Add Wallets'),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(20.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             WalletSelectionButton(
//               title: 'Savings Account',
//               onPressed: () {
//                 HomeController.to.addWallet(
//                   AddWallet(
//                     title: 'Savings Account',
//                     balance: 0, // Set initial balance as needed
//                     color: Colors.green,
//                   ),
//                 );
//                 Get.back(); // Go back to the previous screen
//               },
//             ),
//             SizedBox(height: 20),
//             WalletSelectionButton(
//               title: 'Visa Card',
//               onPressed: () {
//                 HomeController.to.addWallet(
//                   Wallet(
//                     title: 'Visa Card',
//                     balance: 0, // Set initial balance as needed
//                     color: Colors.yellow,
//                   ),
//                 );
//                 Get.back(); // Go back to the previous screen
//               },
//             ),
//             SizedBox(height: 20),
//             WalletSelectionButton(
//               title: 'KCB Card',
//               onPressed: () {
//                 HomeController.to.addWallet(
//                   Wallet(
//                     title: 'KCB Card',
//                     balance: 0, // Set initial balance as needed
//                     color: Colors.blue,
//                   ),
//                 );
//                 Get.back(); // Go back to the previous screen
//               },
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class WalletSelectionButton extends StatelessWidget {
//   final String title;
//   final VoidCallback onPressed;

//   const WalletSelectionButton({
//     required this.title,
//     required this.onPressed,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return ElevatedButton(
//       onPressed: onPressed,
//       child: customText(label: title),
//     );
//   }
// }
