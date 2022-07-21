import 'package:flutter/material.dart';
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

  List<UserModel>? users;

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
        ),
        floatingActionButton: Obx(() {
          return ElevatedButton.icon(
            onPressed: widget.onTapSave,
            icon: Icon(Icons.check),
            label: Text(controller.usersSelectedTotal));
        }),
        body: users == null ? _builderFuture() : _builderList()
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

        users = snapshot.data!;

        return _builderList();
      }
    );
  }

  Widget _builderList() {
    return ReorderableListView.builder(
      onReorder: (oldIndex, newIndex) {
        setState(() {
          if(newIndex > oldIndex) {
            newIndex = newIndex - 1;
          }
          final user = users!.removeAt(oldIndex);
          users!.insert(newIndex, user);
          controller.rebuildListOrder(users!);
        });
      },
      itemCount: users!.length,
      itemBuilder: (context, index) {
        final user = users![index];

        return Container(
          key: ValueKey(user),
          child: Obx(() {
            return SwitchListTile(
              value: controller.userInList(user),
              onChanged: (bool value) => controller.onChangedSwitch(value, user),
              title: Text(
                user.displayName.toUpperCase(),
                style: TextStyle(color: Colors.grey, fontSize: 12),
              )
            );
          }),
        );
      }
    );
  }
}
