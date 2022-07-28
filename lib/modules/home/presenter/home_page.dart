import 'dart:async';

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/home/presenter/home_controller.dart';
import 'package:get/get.dart';
import '../../shared/presenter/app_img_config.dart';
import '../../shared/presenter/components/circle_avatar_app.dart';
import '../../shared/presenter/components/form_field_app.dart';

class HomePage extends GetView<HomeController> {
   
  HomePage({Key? key}) : super(key: key);
  
  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
 // final scaleController = Get.find<ScaleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(controller.titlePage, style: TextStyle(fontSize: 24),)),
      ),
      backgroundColor: Colors.white,
      body: Navigator(
        initialRoute: '/scales',
        onGenerateRoute: controller.onGeneratedRouter,
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
      ),
      drawer: Drawer(
        child: StreamBuilder(
          stream: /*scaleController.streamDaysScale*/StreamController().stream,
          builder: (context, snapshot) {
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(/*controller.user.displayName*/''),
                  accountEmail: Text(/*controller.user.email*/''),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    child: CircleAvatarApp(name: /*controller.user.displayName*/'', size: 70, sizeText: 17,),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('Meus Lanches Pagos'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12,)),
                  subtitle: Text(/*scaleController.getDataPaid(true).toString()*/''),
                ),
                ListTile(
                  leading: Icon(Icons.money_off_outlined),
                  title: Text('Meus Lanches a Pagar'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12,)),
                  subtitle: Text(/*scaleController.getDataPaid(false).toString()*/''),
                ),
                Obx(() {
                  return Visibility(
                    visible: /*controller.authService.isAdmin == false*/true,
                    child: InkWell(
                      onTap: () => showDialogStaff(context),
                      child: ListTile(
                        leading: Icon(Icons.verified_user),
                        title: Text('Acessar como Gestor'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12,)),
                      ),
                    )
                  );
                }),
                ListTile(
                  leading: Icon(Icons.info),
                  title: Text('Sobre'.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12),),
                  onTap: () {
                    showDialog(
                      context: context, 
                      builder: (context) {
                        return AlertDialog(
                          title: Image.asset(AppImgConfig.logoGroup, width: 150, height: 150,),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(child: Text('Quero Lanche')),
                              SizedBox(height: 8,),
                              Text(
                                'Aplicativo para definição de Escala.',
                                style: TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              SizedBox(height: 14,),
                              Center(
                                child: Text(
                                  'Copyright @${controller.yearCurrent}, All Rights Reserved.\nPowered by Grupo H. Egídio',
                                  style: TextStyle(color: Colors.grey, fontSize: 8),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              SizedBox(height: 8,),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Text(
                                  'Versão: ${/*controller.versionApp*/''}',
                                  style: TextStyle(color: Colors.grey, fontSize: 8),
                                ),
                              )
                            ],
                          ),
                        );
                      }
                    );
                  },
                )
              ],
            );
          }
        ),
      ),
      bottomNavigationBar: Obx(() {
        return BottomNavyBar(
          selectedIndex: controller.indexTab.value,
          showElevation: true,
          itemCornerRadius: 24,
          curve: Curves.easeIn,
          onItemSelected: controller.onSelectedItemTab,
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
              icon: const Icon(Icons.apps),
              title: const Text('Escala'),
              activeColor: Get.theme.primaryColorDark,
              textAlign: TextAlign.center,
            ),
            BottomNavyBarItem(
              icon: const Icon(Icons.people),
              title: const Text('Colaboradores'),
              activeColor: Get.theme.primaryColorDark,
              textAlign: TextAlign.center,
            ),
             BottomNavyBarItem(
              icon: const Icon(Icons.exit_to_app),
              title: const Text('Sair'),
              activeColor: Get.theme.primaryColorDark,
              textAlign: TextAlign.center,
            ),
          ],
        );
      })
    );
  }

  showDialogStaff(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Login'),
          content: Container(
            height: 180,
            child: Form(
              key: _keyForm,
              child: Column(
                children: [
                  FormFieldApp(
                    onChanged: (value) => controller.onChangedFieldLoggedAdmin(value),
                    prefixIcon: Icon(Icons.person, color: Get.theme.iconTheme.color,),
                    hintText: 'Senha',
                    validator: (String? value) => controller.validatorFieldLoggedAdmin(value), 
                    controller: TextEditingController(),
                  ),
                  Container(
                    width: Get.width,
                    child: Obx(() {
                      if(controller.buttonAdmActivate.value) {
                        return ElevatedButton(
                          onPressed: () {
                            if(_keyForm.currentState!.validate()) {
                              controller.loggedAdmin();
                            }
                          }, 
                          child: Text('Acessar')
                        );
                      }
                      
                      return ElevatedButton(
                        onPressed: null, 
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.grey)
                        ),
                        child: const Text('Acessar'),
                      );
                    }),
                  )
                ],
              ),
            ),
          ),    
        );
      }
    );  
  }
}