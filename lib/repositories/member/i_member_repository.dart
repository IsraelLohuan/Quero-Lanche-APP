import 'package:gestao_escala/modules/models/user_model.dart';

abstract class IMemberRepository {
  Future<List<UserModel>> fetchAllMembers();
}