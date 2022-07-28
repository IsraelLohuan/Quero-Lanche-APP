
import 'package:gestao_escala/modules/splash/domain/usecases/get_email_saved.dart';
import 'package:get/get.dart';

class SplashController extends GetxController {
  final GetEmailSaved getEmailSaved;
 
  SplashController(this.getEmailSaved);

  @override
  void onInit() {
    super.onInit();
    Future.delayed(
      Duration(seconds: 5),
      () => getEmailSaved().then((email) => Get.offAndToNamed('/login', arguments: {'email': email}))
    );
  }
}
