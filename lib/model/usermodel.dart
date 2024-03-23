class UserModel {
  final String  email;
  final String fname;
  
  UserModel({required this.email, required this.fname,});
  //converts json string into objects
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        email: json['email'] ?? "", fname: json[''] ?? "");
  }
}
