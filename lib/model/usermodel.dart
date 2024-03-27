class UserModel {
  final int userId;
  final String username;
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  UserModel({
    required this.userId,
    required this.username,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['user_id'],
      username: json['username'],
      firstName: json['fname'],
      lastName: json['lname'],
      email: json['email'],
      phone: json['phone'],
      password: json['password'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'username': username,
      'fname': firstName,
      'lname': lastName,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }
}
