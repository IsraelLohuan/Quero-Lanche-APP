import 'package:gestao_escala/application/auth/auth_service.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:gestao_escala/repositories/login/login_repository.dart';
import 'package:get/get.dart';

class ApplicationBindings implements BindingsInterface {
  @override
  dependencies() {
    Get.put(AuthService());
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
  }
}