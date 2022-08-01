
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../application/utils/constants.dart';
import '../login/login_page.dart';

class SplashController {
 
  final _getStorage = GetStorage();

  void goToLogin() {
    Future.delayed(
      Duration(seconds: 5),
      () => getEmailSaved().then((email) =>  Get.off(LoginPage(email: email,)))
    );
  }

  Future<String> getEmailSaved() async {
    String? emailSaved = _getStorage.read(Constants.KEY_EMAIL);
    return emailSaved ?? '';
  }
}