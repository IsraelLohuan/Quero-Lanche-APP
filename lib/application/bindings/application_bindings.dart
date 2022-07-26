import 'package:gestao_escala/application/services/app/app_service.dart';
import 'package:gestao_escala/application/services/app/i_info_app.dart';
import 'package:gestao_escala/application/services/app/info_app_adapter.dart';
import 'package:gestao_escala/application/services/auth/auth_service.dart';
import 'package:gestao_escala/application/services/remote_data/i_remote_data.dart';
import 'package:gestao_escala/application/services/remote_data/remote_data_adapter.dart';
import 'package:get/get.dart';
import '../services/auth/auth_service.dart';

class ApplicationBindings implements Bindings {
  @override
  dependencies() {
    Get.put<IRemoteData>(RemoteDataAdapter());
    Get.put(AuthService(Get.find()));
    Get.put<IInfoApp>(InfoAppAdapter());
    Get.put(AppService(Get.find())..loadVersionApp());
  }
}