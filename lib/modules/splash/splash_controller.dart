import 'package:gestao_escala/application/utils/constants.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
 
  final _getStorage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    getData().then((email) =>  Get.offAndToNamed('/login', arguments: {'email': email}));
  }

  Future<String> getData() async {
    String? emailSaved = _getStorage.read(Constants.KEY_EMAIL);
    return emailSaved ?? '';
  }
}