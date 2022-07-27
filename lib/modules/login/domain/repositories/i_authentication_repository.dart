
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

abstract class IAuthenticationRepository {
  Future<UserModel> login(String email, String password);
}