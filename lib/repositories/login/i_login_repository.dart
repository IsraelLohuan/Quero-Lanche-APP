
import 'package:gestao_escala/modules/models/user_model.dart';

abstract class ILoginRepository {
  Future<UserModel?> findAccountByEmail(String email);
  Future<UserModel> login(String email, String password);
  Future<UserModel> register(UserModel user);
}