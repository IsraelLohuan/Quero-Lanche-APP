import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomeBindings implements BindingsInterface {
  @override
  dependencies() {
    Get.put(HomeController(authService: Get.find(), memberService: Get.find()));
  }
}