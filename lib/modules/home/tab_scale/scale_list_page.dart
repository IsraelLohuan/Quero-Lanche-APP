import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/alert_message_app.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/application/utils/extensions.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_controller.dart';
import 'package:get/get.dart';
import 'components/card_date.dart';

class ScaleListPage extends GetView<ScaleController> {
   
  const ScaleListPage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: controller.streamDaysScale,
        initialData: controller.daysScale,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          if(snapshot.hasError) {
            return AlertMessageApp(
              messageModel: MessageModel(message: snapshot.error.toString(), type: MessageType.info)
            );
          }

          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if(controller.daysScale!.isEmpty) {
            return AlertMessageApp(
              messageModel: MessageModel(message: 'Não há escala gerada para este Ano!', type: MessageType.info)
            );  
          }

          return ListView.builder(
            itemCount: controller.daysScale!.length,
            itemBuilder: (context, index) {
              return CardDate(
                dayInfo: controller.daysScale![index]
              );
            }
          );
        },
      ),
      floatingActionButton: Obx(() {
        if(controller.isActivateAddScale) {
          return Visibility(
            visible: controller.authService.isAdmin,
            child: FloatingActionButton(
              onPressed: () => Get.toNamed('/scale_members', arguments: () => _onFinishSelectedMember()),
              child: Icon(Icons.add),
            ),
          );
        }

        return Visibility(
          visible: controller.authService.isAdmin,
          child: FloatingActionButton(
            onPressed: () => showModalBottomSheet(
              context: context, 
              builder: (context) => builderModalContainer(context)
            ),
            child: Icon(Icons.delete),
          ),
        );
      })
    );  
  }

  Container builderModalContainer(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          AlertMessageApp(messageModel: MessageModel(message: 'Você está prestes a remover a escala gerada deste ano! Deseja realizar esta ação?\nObs: O processo pode levar alguns segundos.', type: MessageType.info)),
          SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed: () => onClickRemoveScale(context), icon: Icon(Icons.thumb_up), label: Text('Sim')),
              SizedBox(width: 10,),
              ElevatedButton.icon(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.thumb_down), label: Text('Não')),
            ],
          )
        ],
      ),
    );
  }

  void _onFinishSelectedMember() {
    Get.back();
    showDialogGenerateScale();
  }

  void onClickRemoveScale(BuildContext context) {
    Navigator.of(context).pop();
    controller.deleteScale();
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
                    messageModel: MessageModel(message: snapshot.error.toString().exception(), type: MessageType.error),
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
}