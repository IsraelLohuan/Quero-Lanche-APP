abstract class ICacheDataSource {
  void save(String key, String value);
  void delete(String key);
  String get(String key);
}