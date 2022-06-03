import 'package:gestao_escala/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {
  @override
  dependencies() {
    Get.put(LoginController(loginRepository: Get.find(), authService: Get.find())); 
  }
}