import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/controllers/logincontroller.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;

LoginController loginController = Get.put(LoginController());
final store = GetStorage();
class UpdateProfile extends StatefulWidget {
  final int userId;

  const UpdateProfile({Key? key, required this.userId}) : super(key: key);

  @override
  _UpdateProfileState createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController();
    lastNameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    fetchUserDetails();
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    super.dispose();
  }

  Future<void> fetchUserDetails() async {
    try {
      final userId = store.read("userid") ?? "default_user_id";
      final response = await http.get(
        Uri.parse(
          'https://sanerylgloann.co.ke/wallet_app/profile.php?user_id=$userId',
        ),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final userDetails = data['userDetails'];
        setState(() {
          firstNameController.text = userDetails['fname'] ?? '';
          lastNameController.text = userDetails['lname'] ?? '';
          emailController.text = userDetails['email'] ?? '';
          phoneController.text = userDetails['phone'] ?? '';
        });
      } else {
        throw Exception(
          'Failed to load user details. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetching user details: $e');
    }
  }

  Future<void> updateUserDetails() async {
    try {
      final response = await http.post(
        Uri.parse('https://sanerylgloann.co.ke/wallet_app/update_profile.php'),
        body: {
          'user_id': widget.userId.toString(),
          'fname': firstNameController.text,
          'lname': lastNameController.text,
          'email': emailController.text,
          'phone': phoneController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data['success']) {
          // Handle success
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profile updated successfully')),
          );
        } else {
          // Handle failure
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(data['message'])),
          );
        }
      } else {
        throw Exception('Failed to update user profile');
      }
    } catch (e) {
      print('Error updating user profile: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text('Edit Profile'),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: 'Phone'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: updateUserDetails,
              child: Text('Update Profile'),
            ),
          ],
        ),
      ),
    );
  }
}
