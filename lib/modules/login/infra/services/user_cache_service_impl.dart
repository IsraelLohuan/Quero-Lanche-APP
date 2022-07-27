import 'package:dartz/dartz.dart';
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/login/domain/services/i_user_cache_service.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_cache_datasource.dart';

class UserCacheServiceImpl implements IUserCacheService {
  final ICacheDataSource cacheDataSource;

  UserCacheServiceImpl(this.cacheDataSource);

  @override
  Either<Failure, bool> saveUser(String key, String email) {
    try {
      cacheDataSource.save(key, email); 
      return Right(true);
    } catch(_) {
      return Left(FailureCache());
    }
  }

  @override
  Either<Failure, bool> removeUser(String key) {
    try {
      cacheDataSource.delete(key);
      return Right(true);
    } catch(_) {
      return Left(FailureCache());
    }
  }
}