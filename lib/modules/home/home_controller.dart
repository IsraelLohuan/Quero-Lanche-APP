
import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final AuthService authService;
  final MemberService memberService;

  HomeController({
    required this.authService, 
    required this.memberService
  });

  UserModel get user => authService.user;

  final RxInt indexTab = RxInt(0);
  
  void onSelectedItemTab(int index) {
    indexTab.value = index;
  }

  String get titlePage => indexTab.value == 0 ? 'Escalas' : 'Colaboradores';
}