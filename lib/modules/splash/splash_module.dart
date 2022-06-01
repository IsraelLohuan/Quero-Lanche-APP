import 'package:gestao_escala/modules/splash/splash_bindings.dart';
import 'package:gestao_escala/modules/splash/splash_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../../application/modules/module.dart';

class SplashModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: "/", 
      page: () => const SplashPage(),
      bindings: [
        SplashBindings()
      ]
    )
  ];
}