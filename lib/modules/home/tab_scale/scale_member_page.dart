import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_ui_config.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_controller.dart';
import 'package:get/get.dart';
import '../../../application/ui/components/alert_message_app.dart';
import '../../../application/ui/messages/messages_mixin.dart';
import '../../../models/user_model.dart';

class ScaleMemberPage extends StatefulWidget {
  late final VoidCallback onTapSave;

  ScaleMemberPage({super.key}) {
    onTapSave = Get.arguments;
  }

  @override
  State<ScaleMemberPage> createState() => _ScaleMemberPageState();
}

class _ScaleMemberPageState extends State<ScaleMemberPage> {
  final controller = Get.find<ScaleController>();

  List<UserModel> get users => controller.userRx.value;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = false;

        await showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Atenção'),
              content: Text('Deseja realmente sair? o processo de geração da escala será cancelado!'),
              actions: [
                TextButton(
                  onPressed: () {
                    result = true;
                    Navigator.of(context).pop();
                  }, 
                  child: Text('Sim')
                ),
                TextButton(
                  onPressed: () {
                    result = false;
                    Navigator.of(context).pop();
                  },
                  child: Text('Não')
                )
              ],
            );
          }
        );

        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Colaboradores'),
          actions: [
            IconButton(
              onPressed: () {
                showDialog(
                  context: context, 
                  builder: (context) {
                    return AlertDialog(
                      title: Text('Info'),
                      content: Text('Caso queira alterar a ordem de colaboradores, pressione o card e altere a posição!'),
                    );
                  }
                );
              }, 
              icon: Icon(
                Icons.info_sharp,
                color: AppUiConfig.colorRed,
              )
            )
          ],
        ),
        floatingActionButton: Obx(() {
          return ElevatedButton.icon(
            onPressed: widget.onTapSave,
            icon: Icon(Icons.check),
            label: Text(controller.usersSelectedTotal)
          );
        }),
        body: users.isEmpty ? _builderFuture() : _builderList()
      ),
    );
  }

  Widget _builderFuture() {
    return FutureBuilder<List<UserModel>>(
      future: controller.fetchAllUsers(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return AlertMessageApp(
            messageModel: MessageModel(
              message: snapshot.error.toString(),
              type: MessageType.error
            ),
          );
        }

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        WidgetsBinding.instance.addPostFrameCallback((_) {
          controller.userRx.value = snapshot.data!;  
        });

        return _builderList();
      }
    );
  }

  Widget _builderList() {
    return Obx(() {
      return ReorderableListView.builder(
        onReorder: (oldIndex, newIndex) {
          if(newIndex > oldIndex) {
            newIndex = newIndex - 1;
          }
          final user = users.removeAt(oldIndex);
          users.insert(newIndex, user);
        },
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];

          return Container(
            key: ValueKey(user),
            child: SwitchListTile(
              value: user.isSelected,
                onChanged: (bool value) => setState(() => user.isSelected = value),
                title: Text(
                  user.displayName.toUpperCase(),
                  style: TextStyle(color: Colors.grey, fontSize: 12),
                )
              )
            );
          }
        );
      }
    );
  }
}
