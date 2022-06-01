import 'package:get/get.dart';

class SplashController extends GetxController {
 
  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration(seconds: 5), () => Get.offNamed('/login'));
  }
}