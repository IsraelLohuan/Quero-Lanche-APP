import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:gestao_escala/repositories/login/login_repository.dart';
import 'package:get/get.dart';
import '../services/auth_service.dart';

class ApplicationBindings implements Bindings {
  @override
  dependencies() {
    Get.put(AuthService());
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
  }
}