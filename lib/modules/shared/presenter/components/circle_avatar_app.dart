import 'package:flutter/material.dart';

class CircleAvatarApp extends StatelessWidget {

  final String name;
  final double size;
  final bool isFirstName;
  final double sizeText;

  CircleAvatarApp({ Key? key, required this.name, this.isFirstName = true, this.size = 30, this.sizeText = 12}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: size,
        height: size,
        color: Colors.green,
        child: Center(child: Text(isFirstName ? name[0] : name, style: TextStyle(color: Colors.white, fontSize: sizeText))),
      ),
    );
  }
}