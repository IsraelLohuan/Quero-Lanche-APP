
import 'package:gestao_escala/modules/login/domain/repositories/i_authentication_repository.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';

import '../services/i_user_cache_service.dart';

class Authentication {
  IAuthenticationRepository repository;
  IUserCacheService cacheService;
  
  Authentication({
    required this.repository,
    required this.cacheService
  });

  Future<UserModel> call(AuthenticationParams params, bool isSavedEmail) async {
    final user = await repository.login(params.email, params.password);
    isSavedEmail ? cacheService.saveUser('key', user.email) : cacheService.removeUser('key');
    return user;
  }
}

class AuthenticationParams {
  final String name;
  final String email;
  final String password;

  AuthenticationParams({
    required this.name,
    required this.email,
    required this.password
  });
}

