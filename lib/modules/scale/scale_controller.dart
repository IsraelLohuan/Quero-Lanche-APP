import 'dart:convert';

import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController {

  final MemberService memberService;

  List<UserModel> allUsers = [];
  final RxList<UserModel> _usersSelected = <UserModel>[].obs;

  ScaleController({required this.memberService});

  String get usersSelectedTotal => _usersSelected.length.toString();
  bool userInList(UserModel user) => _usersSelected.contains(user);
  
  Future<List<UserModel>> fetchAllUsers() async {
    allUsers = await memberService.fetchAll(); 
    _usersSelected.clear();

    if(allUsers.length == 1) {
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
    }

    return allUsers;
  }

  void onChangedSwitch(bool result, UserModel user) {
    result == false ?  _usersSelected.remove(user) : _usersSelected.add(user);
  }
}