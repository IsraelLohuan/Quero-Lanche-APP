import 'package:flutter/material.dart';
import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/modules/home/home_controller.dart';
import 'package:get/get.dart';
import '../../../models/user_model.dart';
import 'components/card_member.dart';

class MembersPage extends GetView<HomeController> {
   
  const MembersPage({Key? key}) : super(key: key);
   
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<UserModel>>(
      future: Get.find<MemberService>().fetchAll(),
      initialData: null,
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