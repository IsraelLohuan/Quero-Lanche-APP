
import 'package:gestao_escala/modules/login/domain/services/i_user_cache_service.dart';
import 'package:gestao_escala/modules/shared/infra/datasources/i_cache_datasource.dart';

class UserCacheServiceImpl implements IUserCacheService {
  final ICacheDataSource cacheDataSource;

  UserCacheServiceImpl(this.cacheDataSource);

  @override
  void saveUser(String key, String email) => cacheDataSource.save(key, email);

  @override
  void removeUser(String key) => cacheDataSource.delete(key);
}