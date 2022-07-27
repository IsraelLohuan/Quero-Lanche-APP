

import 'package:gestao_escala/modules/login/presenter/login_bindings.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../../application/modules/module.dart';
import 'login_page.dart';

class LoginModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: "/login", 
      page: () => LoginPage(),
      bindings: [
        LoginBindings()
      ]
    )
  ];
}