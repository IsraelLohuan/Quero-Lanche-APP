import 'package:flutter/material.dart';

import '../messages/messages_mixin.dart';

class AlertMessageApp extends StatelessWidget {

  final MessageModel messageModel;

  AlertMessageApp({Key? key, required this.messageModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(messageModel.type.icon(), color: messageModel.type.color(), size: 60,),
          SizedBox(height: 10,),
          Text(
            messageModel.message,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 17
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}