import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/home/components/members/components/card_member.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:get/get.dart';

class MembersPage extends GetView<HomeController> {
   
  const MembersPage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: controller.memberService.fetchAll(),
      initialData: controller.memberService.members,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return Text(snapshot.error.toString());
        }

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final List<UserModel> users = snapshot.data!;

        return ListView.builder(
          itemCount: users.length,
          itemBuilder: (context, index) => CardMember(user: users[index])
        );
      },
    );
  }
}