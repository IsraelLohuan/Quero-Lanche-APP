import 'package:gestao_escala/modules/login/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements BindingsInterface {
  @override
  dependencies() {
    Get.put(LoginController(loginRepository: Get.find())); 
  }
}