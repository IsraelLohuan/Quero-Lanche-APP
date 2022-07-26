
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/services/app/app_service.dart';
import 'package:gestao_escala/application/services/auth/auth_service.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/application/utils/constants.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_list_page.dart';
import 'package:get/get.dart';
import '../../models/user_model.dart';
import 'tab_member/members_page.dart';

class HomeController extends GetxController with MessagesMixin {

  static const NAVIGATOR_KEY = 1;

  final AppService appService;
  final AuthService authService;
  final message = Rxn<MessageModel>();

  final _tabs = ['/scales', '/members', '/exit'];

  final RxBool buttonAdmActivate = false.obs;

  @override
  void onInit() {
    super.onInit();
    messageListener(message);
  }

  HomeController({
    required this.authService, 
    required this.appService
  });

  String get yearCurrent => DateTime.now().year.toString();
  String get versionApp  => appService.versionApp;
  UserModel get user => authService.user;

  final RxInt indexTab = RxInt(0);
  
  void onSelectedItemTab(int index) {
    indexTab.value = index;

    if (_tabs[index] == '/exit') {
      authService.logout();
    } else {
      Get.toNamed(_tabs[index], id: NAVIGATOR_KEY);
    }
  }

  Route? onGeneratedRouter(RouteSettings settings) {
    if (settings.name == '/scales') {
      return GetPageRoute(
        settings: settings,
        page: () => ScaleListPage(),
        transition: Transition.fadeIn,
      );
    }

    return GetPageRoute(
      settings: settings,
      page: () => MembersPage(),
      transition: Transition.fadeIn,
    );
  }

  String get titlePage => indexTab.value == 0 ? 'Escala' : 'Colaboradores';

  void onChangedFieldLoggedAdmin(String data) => buttonAdmActivate.value = data.isNotEmpty;

  String? validatorFieldLoggedAdmin(String? value) {
    if(value!.isEmpty) {
      return 'Necessário inserir a senha!';
    }

    if(value != Constants.PASSWORD_ADMIN) {
      return 'Senha inválida! veja o README do Github!';
    }

    return null;
  }

  void loggedAdmin() {
    Get.back();
    authService.admin = true;
    message(MessageModel(title: 'Acesso Administrador', message: 'Você agora está logado como Gestor!', type: MessageType.sucess));
  }
}