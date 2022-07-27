
abstract class IUserCacheService {
  bool saveUser(String key, String email);
  bool removeUser(String key);
}