import 'package:gestao_escala/modules/login/infra/datasources/i_cache_datasource.dart';
import 'package:get_storage/get_storage.dart';

class CacheDataSourceImpl implements ICacheDataSource {

  final _getStorage = GetStorage();

  @override
  void save(String key, String value) => _getStorage.write(key, value);

  @override
  void delete(String key) => _getStorage.remove(key);
}