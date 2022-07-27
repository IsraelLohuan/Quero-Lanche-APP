
import 'package:gestao_escala/modules/login/domain/services/i_user_cache_service.dart';
import 'package:gestao_escala/modules/login/infra/datasources/i_cache_datasource.dart';

class UserCacheServiceImpl implements IUserCacheService {
  final ICacheDataSource cacheDataSource;

  UserCacheServiceImpl(this.cacheDataSource);

  @override
  bool saveUser(String key, String email) {
    try {
      cacheDataSource.save(key, email); 
      return true;
    } catch(_) {
      return false;
    }
  }

  @override
   bool removeUser(String key) {
    try {
      cacheDataSource.delete(key);
      return true;
    } catch(_) {
      return false;
    }
  }
}