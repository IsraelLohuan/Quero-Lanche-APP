import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_img_config.dart';
import 'package:gestao_escala/modules/splash/splash_controller.dart';

import '../../application/app_manager.dart';

class SplashPage extends StatefulWidget {

  const SplashPage({ Key? key }) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final controller = SplashController();

  @override
  void initState() {
    super.initState();
    AppManager.initSingletons();
    controller.goToLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Hero(
          tag: 'splash',
          child: Image.asset(AppImgConfig.logo)
        ),
      ),  
    );
  }
}
