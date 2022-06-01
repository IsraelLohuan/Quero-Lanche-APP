import 'package:firebase_auth/firebase_auth.dart';
import 'package:gestao_escala/application/auth/auth_service.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  final AuthService authService;

  HomeController({required this.authService});

  User? get user => authService.user;
}