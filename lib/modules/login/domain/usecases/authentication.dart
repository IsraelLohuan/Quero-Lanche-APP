
import 'package:dartz/dartz.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
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

  Future<Either<Failure, UserModel>> auth(AuthenticationParams params, bool isSavedEmail) async {
    final result = await repository.login(params.email, params.password);

    if(result.isRight()) {
      final user = result.fold((l) => null, (r) => r);
      isSavedEmail ? cacheService.saveUser('key', user!.email) : cacheService.removeUser('key');
    }

    return result;
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

