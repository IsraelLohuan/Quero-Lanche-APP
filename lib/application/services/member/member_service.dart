
import 'package:gestao_escala/repositories/member/i_member_repository.dart';
import 'package:get/get.dart';

import '../../../models/user_model.dart';

class MemberService extends GetxService {

  IMemberRepository repository;
 
  MemberService({required this.repository});

  Future<List<UserModel>> fetchAll() async => await repository.fetchAllMembers();
}