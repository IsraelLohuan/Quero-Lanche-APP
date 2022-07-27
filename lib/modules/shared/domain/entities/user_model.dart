class UserModel {
  late String email;
  late String displayName;
  late String uid;
  late String password;
  late bool isSelected;
  bool? isAdmin;

  UserModel({
    required this.email, 
    required this.displayName, 
    required this.uid, 
    required this.password
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    displayName = json['displayName'];
    uid = json['uid'];
    password = json['password'];
    isSelected = false;
    isAdmin = json['isAdmin'];
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'displayName': displayName,
      'uid': uid,
      'password': password,
      'isAdmin': isAdmin
    };
  }
}