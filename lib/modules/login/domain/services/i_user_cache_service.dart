import 'package:dartz/dartz.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';

abstract class IUserCacheService {
  Either<Failure, bool> saveUser(String key, String email);
  Either<Failure, bool> removeUser(String key);
}