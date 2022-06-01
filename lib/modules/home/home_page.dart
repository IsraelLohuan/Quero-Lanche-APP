import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
   
  const HomePage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(controller.user!.displayName!),),
      body: Container(
        child: Center(
          child: Image.network(controller.user!.photoURL!),
        ),
      ),
    );
  }
}