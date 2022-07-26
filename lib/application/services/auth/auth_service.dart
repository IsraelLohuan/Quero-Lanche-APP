
import 'dart:convert';

import 'package:gestao_escala/application/services/remote_data/i_remote_data.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';

class AuthService extends GetxService {
  final IRemoteData remote;
  final RxBool _isAdmin = false.obs;

  UserModel? _userModel;

  bool get isAdmin => _isAdmin.value;
  UserModel get user => _userModel!;

  set userModel(UserModel user) {
    _userModel = user;
    remote.insert('user', json.encode(user.toJson()));
  }

  set admin(bool value) {
    _isAdmin.value = value;
    _userModel?.isAdmin = value;
    userModel = _userModel!;
  }
  
  AuthService(this.remote);

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future getUser() async {
    final value = await remote.get('user');
    if(value != null) {
      _userModel ??= UserModel.fromJson(json.decode(value));
      _isAdmin.value = _userModel?.isAdmin ?? false;
    }
  }

  void logout() {
    _userModel = null;
    _isAdmin.value = false;
    Get.offAllNamed('/');
  }
}