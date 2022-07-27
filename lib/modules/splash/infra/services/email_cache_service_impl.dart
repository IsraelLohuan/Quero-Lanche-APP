import 'package:gestao_escala/modules/shared/infra/datasources/i_cache_datasource.dart';
import 'package:gestao_escala/modules/splash/domain/services/i_email_cache_service.dart';

class EmailCacheServiceImpl implements IEmailCacheService {
  final ICacheDataSource cacheDataSource;

  EmailCacheServiceImpl(this.cacheDataSource);

  @override
  String? getEmail(String key) => cacheDataSource.get(key);
}