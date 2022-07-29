import 'package:gestao_escala/modules/home/home_bindings.dart';
import 'package:gestao_escala/modules/home/home_page.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_member_page.dart';
import 'package:gestao_escala/modules/login/login_guard.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../application/modules/module.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home', 
      page: () => HomePage(),
      bindings: [
        HomeBindings(),
      ],
      middlewares: [
        LoginGuard()
      ]
    ),
    GetPage(
      name: '/scale_members', 
      page: () => ScaleMemberPage(),
      middlewares: [
        LoginGuard()
      ]
    )
  ];
}