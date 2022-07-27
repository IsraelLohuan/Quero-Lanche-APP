
import 'package:gestao_escala/modules/splash/presenter/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  dependencies() {
    Get.put(SplashController()); 
  }
}