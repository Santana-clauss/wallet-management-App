import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/transcationcontroller.dart';
import 'package:flutter_app/model/transaction.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Transcationcontroller transcationcontroller = Get.put(Transcationcontroller());

class Transcation extends StatelessWidget {
  // ignore: avoid_types_as_parameter_names
  Transcation({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: getTranscations(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(
            () => ListView.builder(
              itemCount: transcationcontroller.transcationList.length,
              itemBuilder: (context, index) {
                return Row(
                  children: [
                    Icon(Icons.category),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          transcationcontroller
                              .transcationList[index].fromWalletId,
                          style: TextStyle(fontSize: 20),
                        ),
                        Text(
                          transcationcontroller
                              .transcationList[index].toWalletId,
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          transcationcontroller.transcationList[index].amount
                              .toString(),
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
        }
      },
    );
  }
}

Future<void> getTranscations() async {
  try {
    final response = await http.get(Uri.parse(
        'https://sanerylgloann.co.ke/wallet_app/read_users.php}'));
    if (response.statusCode == 200) {
      final serverResponse = json.decode(response.body);
      final transcationResponse =serverResponse['transcations'] as List<dynamic>;
      final transcationList = transcationResponse .map((transaction) => TransactionModel.fromJson(transaction)).toList();
      transcationcontroller.updateTranscationList(transcationList);
    } else {
      print('Server error: ${response.statusCode}');
    }
  } catch (error) {
    print('Error: $error');
    throw error;
  }
}
