
import 'package:gestao_escala/application/services/app/i_info_app.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InfoAppAdapter implements IInfoApp {
  @override
  Future<String> getAppVersion() async => (await PackageInfo.fromPlatform()).buildNumber;
}