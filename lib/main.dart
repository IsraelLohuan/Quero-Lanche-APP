
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/shared/presenter/app_ui_config.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'modules/login/presenter/login_module.dart';
import 'modules/splash/presenter/splash_bindings.dart';
import 'modules/splash/presenter/splash_module.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: _buildOptionsFirebase()
  );

  await GetStorage.init();
  runApp(const App());
}

FirebaseOptions? _buildOptionsFirebase() {
  try {
    if(Platform.isAndroid) {
      return null;  
    }
  } catch(_) {
    return FirebaseOptions(
      apiKey: 'AIzaSyB8GB0TsbUwA-APxaoQyfyO-RtT6HG2fs4', 
      appId: '1:409952614013:web:937dc1977d3c501c036314', 
      messagingSenderId: '409952614013', 
      projectId: 'gestaoescalalanche-f3c98'
    );
  }
  
  return null;
}

class App extends StatelessWidget {

  const App({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: AppUiConfig.title,
      theme: AppUiConfig.theme,
      debugShowCheckedModeBanner: false,
      initialBinding: SplashBindings(),
      getPages: [
        ...SplashModule().routers,
        ...LoginModule().routers,
      ],
    );
  }
}
