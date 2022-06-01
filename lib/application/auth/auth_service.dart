import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {

  User? user;

  Future<void> init() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) { 
      this.user = user;
      user == null ? Get.offAllNamed('/login') : Get.offAllNamed('/home'); 
    });
  }
}