import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class ApplicationBindings implements Bindings {
  @override
  dependencies() {
    Get.put(AuthService());
  }
}