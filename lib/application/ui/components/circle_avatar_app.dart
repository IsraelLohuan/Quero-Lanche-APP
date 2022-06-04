import 'package:flutter/material.dart';

class CircleAvatarApp extends StatelessWidget {

  final String name;
  final double size;

  CircleAvatarApp({ Key? key, required this.name, this.size = 30}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: Container(
        width: size,
        height: size,
        color: Colors.green,
        child: Center(child: Text(name[0], style: TextStyle(color: Colors.white,))),
      ),
    );
  }
}