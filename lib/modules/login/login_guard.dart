import 'package:flutter/cupertino.dart';
import 'package:gestao_escala/application/services/auth/auth_service.dart';
import 'package:get/get.dart';

class LoginGuard extends GetMiddleware {
  @override 
  RouteSettings? redirect(String? route) {
    final authService = Get.find<AuthService>();
    return authService.isLogged ? null : RouteSettings(name: '/');
  }
}