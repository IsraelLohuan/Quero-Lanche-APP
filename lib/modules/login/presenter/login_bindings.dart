
import 'package:gestao_escala/modules/login/domain/repositories/i_authentication_repository.dart';
import 'package:gestao_escala/modules/login/domain/services/i_user_cache_service.dart';
import 'package:gestao_escala/modules/login/domain/usecases/authentication.dart';
import 'package:gestao_escala/modules/login/external/datasources/authentication_datasource_impl.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_authentication_datasource.dart';
import 'package:gestao_escala/modules/login/infra/repositories/authentication_repository_impl.dart';
import 'package:gestao_escala/modules/login/infra/services/user_cache_service_impl.dart';
import 'package:gestao_escala/modules/login/presenter/login_controller.dart';
import 'package:get/get.dart';

class LoginBindings implements Bindings {
  @override
  dependencies() {
    Get.lazyPut<IAuthenticationDataSource>(() => AuthenticationDataSourceImpl());
    Get.lazyPut<IAuthenticationRepository>(() => AuthenticationRepositoryImpl(Get.find()));
    Get.lazyPut<IUserCacheService>(() => UserCacheServiceImpl(Get.find()));
    Get.lazyPut<Authentication>(() => Authentication(
      repository: Get.find(), 
      cacheService: Get.find()
    ));
    Get.put(LoginController(Get.find())); 
  }
}