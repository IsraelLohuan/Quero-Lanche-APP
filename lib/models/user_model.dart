class UserModel {
  late String email;
  late String displayName;
  late String uid;
  late String password;

  UserModel({required this.email, required  this.displayName, required this.uid, required this.password});

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    uid = json['uid'];
    password = json['password'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'uid': uid,
      'password': password
    };
  }
}