import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:gestao_escala/repositories/login/login_repository.dart';
import 'package:gestao_escala/repositories/member/member_repository.dart';
import 'package:get/get.dart';

import '../../repositories/member/i_member_repository.dart';
import '../services/auth_service.dart';
import '../services/member_service.dart';

class ApplicationBindings implements BindingsInterface {
  @override
  dependencies() {
    Get.put(AuthService());
    Get.lazyPut<ILoginRepository>(() => LoginRepository());
    Get.lazyPut<IMemberRepository>(() => MemberRepository());
    Get.lazyPut(() => MemberService(members: [], repository: Get.find()));
  }
}