import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/alert_message_app.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
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
        onPressed: () => null,
        child: Icon(Icons.add),
      ),
    );  
  }

  void showDialogUsers() {
    showDialog(
      context: Get.context!, 
      builder: (context) {
        return AlertDialog(
          title: Text('Selecione os Colaboradores Para Criação da Escala'),
          content: Container(),
        );
      }
    );
  }
}