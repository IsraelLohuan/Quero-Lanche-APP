import 'package:gestao_escala/application/services/app/i_info_app.dart';

class AppService {
  final IInfoApp infoApp;

  late String _versionApp;

  String get versionApp => _versionApp;
  
  AppService(this.infoApp);

  Future loadVersionApp() async {
    _versionApp = await infoApp.getAppVersion();
  } 
}