
import 'package:get/get.dart';
import '../modules/shared/external/datasources/cache_datasource_impl.dart';
import '../modules/shared/infra/datasources/i_cache_datasource.dart';

class AppBindings implements Bindings {
  @override
  dependencies() {
    Get.lazyPut<ICacheDataSource>(() => CacheDataSourceImpl());
  }
}

   