import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/usercontroller.dart';
import 'package:flutter_app/model/usermodel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;


var iconList = [
  Icons.home,
  Icons.holiday_village,
  Icons.vaccines,
  Icons.work,
  Icons.work_off,
  Icons.work_outline,
  Icons.workspaces_filled,
  Icons.workspaces_outline,
  Icons.wrap_text,
  Icons.wrong_location,
];

UserController userController = Get.put(UserController());

class Users extends StatelessWidget {
  const Users({super.key});

  @override
  Widget build(BuildContext context) {
    getStudentList();

    return Column(
      children: [
        SizedBox(height: 200),
        Obx(
          () => userController.loadingUser.value
              ? Center(child: Text("Loading..."))
              : ListView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.blueAccent),
                            color: Colors.blueAccent.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10)),
                        height: 200,
                        width: 200,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                                "${userController.UserList[index].sname}"),
                            Icon(
                              iconList[index],
                              color: Colors.blueAccent,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: userController.UserList.length,
                ),
        ),
      ],
    );
  }

  Future<void> getStudentList() async {
    http.Response response =
        await http.get(Uri.parse("https://sanerylgloann.co.ke/wallet_app/read_user.php"));
    if (response.statusCode == 200) {
      var studentResponse = json.decode(response.body);
      var studentData = studentResponse['data'];
      List<UserModel> students = List<UserModel>.from(
          studentData.map((std) => UserModel.fromJson(std)));
      var student =
          studentData.map((std) => UserModel.fromJson(studentData));
      userController.updateStudentList(student);
      //if login  focus on success message
    } else {
      print("Server error ${response.statusCode}");
    }
    userController.loadingUser.value = false;
  }
}
