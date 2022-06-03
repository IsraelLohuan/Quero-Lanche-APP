
import 'package:get/get.dart';

import '../../models/user_model.dart';

class AuthService extends GetxService {

  late UserModel _userModel;

  set userModel(UserModel user) => _userModel = user;
  UserModel get user => _userModel;
}