import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController {

  final MemberService memberService;

  List<UserModel> allUsers = [];
  List<UserModel> usersSelected = [];

  ScaleController({required this.memberService});

  Future<List<UserModel>> fetchAllUsers() async {
    allUsers = await memberService.fetchAll(); 

    if(allUsers.length == 1) {
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
    }

    return allUsers;
  }
}