import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_ui_config.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends GetView<HomeController> {
   
  const HomePage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppUiConfig.colorMain,
      body: Stack(
        children: [
          Container(
            color: AppUiConfig.colorMain,
            height: 200,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 16, right: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  builderUserInfo(),
                  Icon(Icons.exit_to_app, color: Colors.white,)
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 540,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(50),
                  topRight: Radius.circular(50)
                )
              ),
            ),
          ),
        ] 
      )
    );
  }

  Row builderUserInfo() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: Image.network(
            controller.user!.photoURL!,
            width: 50,
            height: 50,
          ),
        ),
        SizedBox(width: 10,),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${controller.user!.displayName!},',
              style: GoogleFonts.roboto(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold
                )
              ),
            ),
            Text(
              'Seja Bem Vindo!',
              style: TextStyle(color: Colors.white, fontSize: 15)
            )
          ],
         ),       
      ],
    );
  }
}