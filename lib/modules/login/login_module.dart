import 'package:gestao_escala/modules/login/login_bindings.dart';
import 'package:gestao_escala/modules/login/login_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../application/modules/module.dart';

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