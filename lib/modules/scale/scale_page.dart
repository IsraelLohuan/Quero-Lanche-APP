import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/alert_message_app.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:gestao_escala/modules/scale/components/card_date.dart';
import 'package:gestao_escala/modules/scale/scale_controller.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ScalePage extends GetView<ScaleController> {
   
  const ScalePage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: controller.streamDaysScale,
        initialData: controller.daysScale,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          if(snapshot.hasError) {
            return AlertMessageApp(messageModel: MessageModel(message: snapshot.error.toString(), type: MessageType.info));
          }

          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: controller.daysScale.length,
            itemBuilder: (context, index) => CardDate(dayInfo: controller.daysScale[index])
          );
        },
      ),
      floatingActionButton: Obx(() {
        if(controller.isActivateAddScale) {
          return FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context, 
              builder: (context) {
                return Container(
                  height: 250,
                  child: Column(
                    children: [
                      AlertMessageApp(messageModel: MessageModel(message: 'Você está prestes a remover a escala gerada deste ano! Deseja realizar esta ação?\nObs: O processo pode levar alguns segundos...', type: MessageType.info)),
                      SizedBox(height: 10,),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton.icon(onPressed: () {
                            Navigator.of(context).pop();
                            controller.deleteScale();
                          }, icon: Icon(Icons.thumb_up), label: Text('Sim')),
                          SizedBox(width: 10,),
                          ElevatedButton.icon(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.thumb_down), label: Text('Não')),
                        ],
                      )
                    ],
                  ),
                );
              }
            ),
            child: Icon(Icons.delete),
          );
        }

        return FloatingActionButton(
          onPressed: () => showDialogUsers(),
          child: Icon(Icons.add),
        );
      })
    );  
  }

  void showDialogGenerateScale() {
    showDialog(
      context: Get.context!,
      builder: (context) {
        return AlertDialog(
          title: Text('Nova Escala'),
          content: Container(
            height: 300,
            width: 300,
            child: FutureBuilder<bool>(
              future: controller.onCreatedScale(),
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

                return AlertMessageApp(
                  messageModel: MessageModel(message: 'Escala deste Ano Gerada com sucesso :)', type: MessageType.sucess),
                );
              }
            ),
          ),
        );
      }
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
                          onPressed: () {
                            Get.back();
                            showDialogGenerateScale();
                          }, 
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