import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/home/components/members/members_page.dart';
import 'package:gestao_escala/modules/home/components/scale/scale_page.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';

class HomePage extends GetView<HomeController> {
   
  HomePage({Key? key}) : super(key: key);
   
  final List<Widget> bodys = [
    ScalePage(), 
    MembersPage()
  ];

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
      body: Obx(() => bodys[controller.indexTab.value]),
      drawer: Drawer(child: Text(''),),
      floatingActionButton: FloatingActionButton(
        onPressed: () {  },
        child: Icon(Icons.add),
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
          ],
        );
      })
    );
  }
}