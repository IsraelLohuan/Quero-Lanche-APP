
import 'package:get/get.dart';
import 'home_controller.dart';

class HomeBindings implements Bindings{
  @override
  dependencies() {
    Get.put(HomeController());
  }
} 