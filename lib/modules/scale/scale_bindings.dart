import 'package:gestao_escala/modules/scale/scale_controller.dart';
import 'package:gestao_escala/repositories/scale/i_scale_repository.dart';
import 'package:gestao_escala/repositories/scale/scale_repository.dart';
import 'package:get/get.dart';

class ScaleBindings implements Bindings {

  @override
  dependencies() {
    Get.put<IScaleRepository>(ScaleRepository());
    Get.put(ScaleController(scaleRepository: Get.find() ,memberService: Get.find()));
  }
}