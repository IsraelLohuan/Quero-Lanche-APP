import 'package:gestao_escala/modules/login/login_controller.dart';
import 'package:get/get.dart';

import '../../repositories/login/i_login_repository.dart';
import '../../repositories/login/login_repository.dart';

class LoginBindings implements Bindings {
  @override
  dependencies() {
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
    Get.put(LoginController(loginRepository: Get.find(), authService: Get.find())); 
  }
}