import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/circle_avatar_app.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';

import '../scale/scale_controller.dart';

class HomePage extends GetView<HomeController> {
   
  HomePage({Key? key}) : super(key: key);
  
  final scaleController = Get.find<ScaleController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: Obx(() => Text(controller.titlePage, style: TextStyle(fontSize: 24),)),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem<String>(value: '0', child: ListTile(leading: Icon(Icons.filter_alt), title: Text('Filtros'),)),
            ]
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Navigator(
        initialRoute: '/scales',
        onGenerateRoute: controller.onGeneratedRouter,
        key: Get.nestedKey(HomeController.NAVIGATOR_KEY),
      ),
      drawer: Drawer(
        child: StreamBuilder(
          stream: scaleController.streamDaysScale,
          builder: (context, snapshot) {
            return ListView(
              children: [
                UserAccountsDrawerHeader(
                  accountName: Text(controller.user.displayName),
                  accountEmail: Text(controller.user.email),
                  currentAccountPicture: CircleAvatar(
                    radius: 30.0,
                    child: CircleAvatarApp(name: controller.user.displayName, size: 70, sizeText: 17,),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.monetization_on),
                  title: Text('Meus Lanches Pagos'),
                  subtitle: Text(scaleController.getDataPaid(true).toString()),
                ),
                ListTile(
                  leading: Icon(Icons.money_off_outlined),
                  title: Text('Meus Lanches a Pagar'),
                  subtitle: Text(scaleController.getDataPaid(false).toString()),
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
}