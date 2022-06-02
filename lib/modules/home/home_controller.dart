
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/auth/auth_service.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final AuthService authService;

  HomeController({required this.authService});

  UserModel get user => authService.user;

  final RxInt indexTab = RxInt(0);
  
  void onSelectedItemTab(int index) {
    indexTab.value = index;
  }
}