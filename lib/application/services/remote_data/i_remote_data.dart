abstract class IRemoteData {
  Future<String?> get(String key);
  Future insert(String key, String value);
}