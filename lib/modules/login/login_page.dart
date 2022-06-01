
import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_img_config.dart';
import 'package:gestao_escala/modules/login/login_controller.dart';
import 'package:get/get.dart';
import '../../application/ui/app_ui_config.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class LoginPage extends GetView<LoginController> {
   
  LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    timeDilation = 5;

    return Scaffold(
      backgroundColor: AppUiConfig.colorMain,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'splash',
            child: Image.asset(AppImgConfig.logo),
          ),
          AnimatedCard(
            direction: AnimatedCardDirection.left, 
            initDelay: Duration(milliseconds: 0), 
            duration: Duration(seconds: 1),
            child: Center(
              child: builderButtonAuth(),
            ),
          )
        ],
      )
    );
  }

  Container builderButtonAuth() {
    return Container(
      width: 180,
      height: 40,
      decoration: BoxDecoration(  
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImgConfig.google, width: 15,),
          SizedBox(width: 18,),
          Text('Login')
        ],
      )
    );
  }
}