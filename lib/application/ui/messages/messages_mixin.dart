import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin MessagesMixin on GetxController {
  void messageListener(Rxn<MessageModel> message) {
    ever<MessageModel?>(message, (model) {
      if (model != null) {
        Get.snackbar(
          model.title ?? '',
          model.message,
          backgroundColor: model.type.color(),
          colorText: Colors.white
        );
      }
    });
  }
}

class MessageModel {
  final String? title;
  final String message;
  final MessageType type;

  MessageModel({
    this.title,
    required this.message,
    required this.type,
  });

  MessageModel.error({
    this.title,
    required this.message,
  }) : type = MessageType.error;

  MessageModel.info({
    this.title,
    required this.message,
  }) : type = MessageType.info;
}

enum MessageType { error, info, sucess }

extension MessageTypeExtension on MessageType {

  IconData icon() {
    switch(this) {
     case MessageType.error:
        return Icons.error; 
      case MessageType.info:
        return Icons.warning;
      case MessageType.sucess:
        return Icons.check; 
    }
  }

  Color color() {
    switch(this) {
      case MessageType.error:
        return Colors.red; 
      case MessageType.info:
        return Colors.amber;
      case MessageType.sucess:
        return Colors.green;
    }
  }
}
