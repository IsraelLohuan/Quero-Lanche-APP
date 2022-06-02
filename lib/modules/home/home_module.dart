import 'package:gestao_escala/modules/home/home_bindings.dart';
import 'package:gestao_escala/modules/home/home_page.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../application/modules/module.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home', 
      page: () => HomePage(),
      bindings: [
        HomeBindings()
      ]
    )
  ];
}