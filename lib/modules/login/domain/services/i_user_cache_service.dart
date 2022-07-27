
abstract class IUserCacheService {
  void saveUser(String key, String email);
  void removeUser(String key);
}