import 'package:gestao_escala/modules/scale/scale_controller.dart';
import 'package:get/get.dart';

class ScaleBindings implements Bindings {

  @override
  dependencies() {
    Get.put(ScaleController());
  }
}