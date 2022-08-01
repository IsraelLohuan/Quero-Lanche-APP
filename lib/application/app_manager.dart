import 'package:gestao_escala/application/services/app/i_info_app.dart';
import 'package:gestao_escala/application/services/app/info_app_adapter.dart';
import 'package:gestao_escala/application/services/remote_data/i_remote_data.dart';
import 'package:gestao_escala/application/services/remote_data/remote_data_adapter.dart';
import 'package:gestao_escala/repositories/scale/scale_repository.dart';
import 'package:get/get.dart';

import '../modules/home/home_controller.dart';
import '../modules/home/tab_scale/scale_controller.dart';
import '../modules/login/login_controller.dart';
import '../repositories/login/i_login_repository.dart';
import '../repositories/login/login_repository.dart';
import '../repositories/member/i_member_repository.dart';
import '../repositories/member/member_repository.dart';
import '../repositories/scale/i_scale_repository.dart';
import 'services/app/app_service.dart';
import 'services/auth/auth_service.dart';
import 'services/member/member_service.dart';

class AppManager {
  static void initSingletons() {
    Get.put<IRemoteData>(RemoteDataAdapter());
    Get.put(AuthService(Get.find()));
    Get.put<IInfoApp>(InfoAppAdapter());
    Get.put(AppService(Get.find())..loadVersionApp());

    /* Dependências Módulo Login */
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
    Get.lazyPut(() => LoginController(
      loginRepository: Get.find(), 
      authService: Get.find()
    )); 

    /* Dependências Módulo Home */
    Get.put<IScaleRepository>(ScaleRepository());
    Get.lazyPut<IMemberRepository>(() => MemberRepository());
    Get.lazyPut(() => MemberService(repository: Get.find()));
    Get.put(HomeController(
      authService: Get.find(),
      appService:  Get.find()
    ));
    Get.put(ScaleController(
      scaleRepository: Get.find(), 
      memberService: Get.find(), 
      authService: Get.find()
    ));
  }
}