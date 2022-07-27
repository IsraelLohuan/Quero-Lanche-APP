
import 'package:gestao_escala/modules/splash/domain/services/i_email_cache_service.dart';
import 'package:gestao_escala/modules/splash/domain/usecases/get_email_saved.dart';
import 'package:gestao_escala/modules/splash/infra/services/email_cache_service_impl.dart';
import 'package:gestao_escala/modules/splash/presenter/splash_controller.dart';
import 'package:get/get.dart';

class SplashBindings implements Bindings {
  @override
  dependencies() {
    Get.lazyPut<IEmailCacheService>(() => EmailCacheServiceImpl(Get.find()));
    Get.lazyPut(() => GetEmailSaved(Get.find()));
    Get.lazyPut(() => SplashController(Get.find())); 
  }
}