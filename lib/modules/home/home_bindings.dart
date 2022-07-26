import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_controller.dart';
import 'package:get/get.dart';
import '../../application/services/member/member_service.dart';
import '../../repositories/member/i_member_repository.dart';
import '../../repositories/member/member_repository.dart';
import '../../repositories/scale/i_scale_repository.dart';
import '../../repositories/scale/scale_repository.dart';

class HomeBindings implements Bindings{
  @override
  dependencies() {
    Get.put<IScaleRepository>(ScaleRepository());
    Get.lazyPut<IMemberRepository>(() => MemberRepository());
    Get.lazyPut(() => MemberService(repository: Get.find()));
    Get.put(HomeController(
      authService: Get.find(),
      appService:  Get.find()
    ));
    Get.put(ScaleController(scaleRepository: Get.find(), memberService: Get.find(), authService: Get.find()));
  }
}