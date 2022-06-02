import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_img_config.dart';
import 'package:gestao_escala/modules/splash/splash_controller.dart';
import 'package:get/get.dart';

class SplashPage extends GetView<SplashController> {
   
  const SplashPage({Key? key}) : super(key: key);
   
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