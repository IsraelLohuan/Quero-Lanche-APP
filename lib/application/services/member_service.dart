import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:gestao_escala/repositories/member/i_member_repository.dart';
import 'package:get/get.dart';

class MemberService extends GetxService {

  IMemberRepository repository;
  List<UserModel> members;

  MemberService({required this.members, required this.repository});

  Future<List<UserModel>> fetchAll() async {
    members = await repository.fetchAllMembers();
    return members;
  }
}