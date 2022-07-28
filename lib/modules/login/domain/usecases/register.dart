import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

import '../repositories/i_authentication_repository.dart';

class Register {
  IAuthenticationRepository repository;

  Register({
    required this.repository
  });

  Future<UserModel> call(UserModel userModel) async {
    return await repository.register(userModel);
  }
}