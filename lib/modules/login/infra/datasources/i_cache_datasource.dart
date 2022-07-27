abstract class ICacheDataSource {
  void save(String key, String value);
  void delete(String key);
}