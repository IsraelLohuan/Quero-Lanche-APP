import 'package:gestao_escala/application/services/remote_data/i_remote_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RemoteDataAdapter implements IRemoteData {
  @override
  Future<String?> get(String key) async {
    final prefs = await SharedPreferences.getInstance(); 
    return prefs.getString(key);
  }
  
  @override
  Future insert(String key, String value) async {
    final prefs = await SharedPreferences.getInstance(); 
    await prefs.setString(key, value);
  }
}