import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_ui_config.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_controller.dart';
import 'package:get/get.dart';
import '../../../application/ui/components/alert_message_app.dart';
import '../../../application/ui/messages/messages_mixin.dart';
import '../../../models/user_model.dart';
import 'package:gestao_escala/application/utils/extensions.dart';

class ScaleMemberPage extends StatefulWidget {
  late final bool insertNewMember;
  late final VoidCallback onTapSave;

  ScaleMemberPage({
    required this.onTapSave, 
    this.insertNewMember = false, 
    super.key
  });

  @override
  State<ScaleMemberPage> createState() => _ScaleMemberPageState();
}

class _ScaleMemberPageState extends State<ScaleMemberPage> {
  late ScaleController controller;

  List<UserModel> get users => controller.allUsersRx.value;

  @override
  void initState() {
    super.initState();
    controller = Get.find<ScaleController>()..setInsertNewMember(widget.insertNewMember);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        bool result = false;

        await Get.defaultDialog(
          title: 'Atenção',
          content: Text(
            'Caso queira alterar a ordem de colaboradores, pressione o card e altere a posição!'
          ),
          onCancel: () => result = false,
          onConfirm: () {
            result = true;
            Get.back();
          },
          textCancel: 'Cancelar',
          textConfirm: 'Sair',
          confirmTextColor: Colors.white
        );

        return result;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Colaboradores'),
          actions: [
            IconButton(
              onPressed: () {
                showDialogInfo();
              }, 
              icon: Icon(
                Icons.info_sharp,
                color: AppUiConfig.colorRed,
              )
            )
          ],
        ),
        floatingActionButton: StreamBuilder(
          stream: controller.allUsersRx.stream,
          builder: (context, snapshot) {
            return ElevatedButton.icon(
              onPressed: widget.onTapSave,
              icon: Icon(Icons.check),
              label: Text(controller.usersSelectedTotal.toString())
            );
          }
        ),
        body: users.isEmpty ? _builderFuture() : _builderList()
      ),
    );
  }

  Future<dynamic> showDialogInfo() {
    return Get.defaultDialog(
      title: 'Info',
      content: Text('Caso queira alterar a ordem de colaboradores, pressione o card e altere a posição!')
    );
  }

  Widget _builderFuture() {
    return FutureBuilder<bool>(
      future: controller.fetchAllUsers(),
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return AlertMessageApp(
            messageModel: MessageModel(
              message: snapshot.error.toString().exception(),
              type: MessageType.error
            ),
          );
        }

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return _builderList();
      }
    );
  }

  Widget _builderList() {
    return Obx(() {
      return ReorderableListView.builder(
        buildDefaultDragHandles: false,
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
          
          return ReorderableDragStartListener(
            key: ValueKey(user),
            index: index,
            child: Visibility(
              visible: controller.isVisibleCardSwitch(user),
              child: Container(
                padding: EdgeInsets.all(20),
                child: SwitchListTile(
                  value: user.isSelected,
                    onChanged: (bool value) => setState(() => user.isSelected = value),
                    title: Text( 
                      user.displayName.toUpperCase(),
                      style: TextStyle(color: Colors.grey, fontSize: 12),
                    )
                  )
                ),
              ),
            );
          }
        );
      }
    );
  }
}
