
import 'package:get/get_navigation/src/routes/get_route.dart';
import '../../../application/modules/module.dart';
import 'home_bindings.dart';
import 'home_page.dart';

class HomeModule extends Module {
  @override
  List<GetPage> routers = [
    GetPage(
      name: '/home', 
      page: () => HomePage(),
      bindings: [
        HomeBindings(),
      ]
    ),
  /*  GetPage(
      name: '/scale_members', 
      page: () => ScaleMemberPage()
    )*/
  ];
}