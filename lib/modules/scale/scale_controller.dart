import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController {

  final MemberService memberService;

  List<UserModel> allUsers = [];
  RxList<UserModel> usersSelected = <UserModel>[].obs;

  ScaleController({required this.memberService});

  Future<List<UserModel>> fetchAllUsers() async {
    allUsers = await memberService.fetchAll(); 

    usersSelected.clear();

    if(allUsers.length == 1) {
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
    }

    return allUsers;
  }

  bool userInList(UserModel user) => usersSelected.contains(user);

  void onChangedSwitch(bool result, UserModel user) {

    if(userInList(user) && result == false) {
      usersSelected.remove(user);
      return;
    } 
      
    if(result) {
      usersSelected.add(user);
    }
  }
}