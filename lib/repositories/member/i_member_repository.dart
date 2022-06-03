
import '../../models/user_model.dart';

abstract class IMemberRepository {
  Future<List<UserModel>> fetchAllMembers();
}