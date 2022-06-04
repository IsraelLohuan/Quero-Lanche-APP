import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/alert_message_app.dart';
import 'package:gestao_escala/application/ui/components/circle_avatar_app.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:gestao_escala/modules/scale/scale_controller.dart';
import 'package:get/get.dart';

class ScalePage extends GetView<ScaleController> {
   
  const ScalePage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AlertMessageApp(
        messageModel: MessageModel(message: 'Não há escala cadastrada para este Ano!', type: MessageType.info)
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialogUsers(),
        child: Icon(Icons.add),
      ),
    );  
  }

  void showDialogUsers() {
    showDialog(
      context: Get.context!, 
      builder: (context) {
        return AlertDialog(
          title: Text('Selecione os Colaboradores'),
          content: Container(
            height: 300,  
            width: 300,
            child: FutureBuilder<List<UserModel>>(
              future: controller.fetchAllUsers(),
              builder: (context, snapshot) {
                if(snapshot.hasError) {
                  return AlertMessageApp(
                    messageModel: MessageModel(message: snapshot.error.toString(), type: MessageType.error),
                  );
                }

                if(!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }

                List<UserModel> users = snapshot.data!;

                return Stack(
                  children: [
                    ListView.builder(
                      itemCount: users.length,
                      itemBuilder: (context, index) {
                        final user = users[index];
                      
                        return Obx(() {
                          return SwitchListTile(
                            value: controller.userInList(user), 
                            onChanged: (bool value) => controller.onChangedSwitch(value, user),
                            title: Text(user.displayName.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 12),)
                          );
                        });
                      }
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Obx(() {
                        return  ElevatedButton.icon(
                          onPressed: () => print('teste'), 
                          icon: Icon(Icons.check), 
                          label: Text(controller.usersSelectedTotal)
                        );
                      }),
                    )
                  ], 
                );
              }
            ),
          ),
        );
      }
    );
  }
}