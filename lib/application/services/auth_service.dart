
import 'package:get/get.dart';

import '../../models/user_model.dart';

class AuthService extends GetxService {

  UserModel? _userModel;

  set userModel(UserModel user) => _userModel = user;
  UserModel get user => _userModel!;

  void logout() {
    _userModel = null;
   // Get.offAllNamed('/');
  }
}