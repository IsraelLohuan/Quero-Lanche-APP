
import 'package:get/get.dart';

import '../../models/user_model.dart';

class AuthService extends GetxService {

  final RxBool _isAdmin = false.obs;

  UserModel? _userModel;

  set userModel(UserModel user) => _userModel = user;
  UserModel get user => _userModel!;

  set admin(bool value) => _isAdmin.value = value;
  bool get isAdmin => _isAdmin.value;

  void logout() {
    _userModel = null;
    _isAdmin.value = false;
    Get.offAllNamed('/');
  }
}