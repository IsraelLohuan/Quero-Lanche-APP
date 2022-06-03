import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';

import '../../application/services/member_service.dart';
import '../../repositories/member/i_member_repository.dart';
import '../../repositories/member/member_repository.dart';

class HomeBindings implements Bindings{
  @override
  dependencies() {
    Get.lazyPut<IMemberRepository>(() => MemberRepository());
    Get.lazyPut(() => MemberService(repository: Get.find()));
    Get.put(HomeController(authService: Get.find()));
  }
}