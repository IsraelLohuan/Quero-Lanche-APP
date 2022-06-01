
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_ui_config.dart';
import 'package:gestao_escala/modules/home/home_module.dart';
import 'package:gestao_escala/modules/login/login_module.dart';
import 'package:gestao_escala/modules/splash/splash_module.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'application/bindings/application_bindings.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  
  runApp(const App());
}

class App extends StatelessWidget {

  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppUiConfig.title,
      initialBinding: ApplicationBindings(),
      theme: AppUiConfig.theme,
      debugShowCheckedModeBanner: false,
      getPages: [
        ...SplashModule().routers,
        ...LoginModule().routers,
        ...HomeModule().routers
      ],
    );
  }
}
