import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import '../../../models/user_model.dart';

class CardMember extends StatelessWidget {

  final UserModel user;

  const CardMember({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      child: Card(
        child: ListTile(
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 30,
              height: 30,
              color: Colors.green,
              child: Center(child: Text(user.displayName[0], style: TextStyle(color: Colors.white,))),
            ),
          ),
          title: Text(user.displayName.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 14),),
        )
      ),
    );
  }
}