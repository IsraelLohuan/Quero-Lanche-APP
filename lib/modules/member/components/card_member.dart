import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/components/circle_avatar_app.dart';
import '../../../models/user_model.dart';

class CardMember extends StatelessWidget {

  final UserModel user;

  const CardMember({ Key? key, required this.user }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedCard(
      child: Card(
        child: ListTile(
          leading: CircleAvatarApp(name: user.displayName),
          title: Text(user.displayName.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 14),),
        )
      ),
    );
  }
}