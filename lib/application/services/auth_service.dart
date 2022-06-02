
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:get/get.dart';

class AuthService extends GetxService {

  late UserModel _userModel;

  set userModel(UserModel user) => _userModel = user;
  UserModel get user => _userModel;
}