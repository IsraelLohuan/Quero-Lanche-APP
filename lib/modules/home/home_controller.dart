
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:gestao_escala/modules/home/home_page.dart';
import 'package:gestao_escala/modules/member/members_page.dart';
import 'package:gestao_escala/modules/scale/scale_bindings.dart';
import 'package:gestao_escala/modules/scale/scale_page.dart';
import 'package:get/get.dart';

import '../../models/user_model.dart';

class HomeController extends GetxController {

  static const NAVIGATOR_KEY = 1;

  final AuthService authService;
  
  final _tabs = ['/scales', '/members', '/exit'];

  HomeController({
    required this.authService, 
  });

  UserModel get user => authService.user;

  final RxInt indexTab = RxInt(0);
  
  void onSelectedItemTab(int index) {
    indexTab.value = index;

    if (_tabs[index] == '/exit') {
      print('exit');
    } else {
      Get.toNamed(_tabs[index], id: NAVIGATOR_KEY);
    }
  }

  Route? onGeneratedRouter(RouteSettings settings) {
    if (settings.name == '/scales') {
      return GetPageRoute(
        settings: settings,
        page: () => ScalePage(),
        transition: Transition.fadeIn,
        bindings: [
          ScaleBindings()
        ]
      );
    }

    return GetPageRoute(
      settings: settings,
      page: () => MembersPage(),
      transition: Transition.fadeIn,
    );
  }

  String get titlePage => indexTab.value == 0 ? 'Escala' : 'Colaboradores';
}