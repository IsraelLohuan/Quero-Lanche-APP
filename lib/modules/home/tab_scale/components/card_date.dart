import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/models/day_model.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:gestao_escala/application/utils/date_utils.dart' as utildate;
import '../../../../application/ui/components/circle_avatar_app.dart';
import '../scale_controller.dart';

class CardDate extends GetView<ScaleController> {

  final DayModel dayInfo;

  CardDate({ Key? key, required this.dayInfo }) : super(key: key);

  UserModel get user => dayInfo.userResponsible;
  
  @override
  Widget build(BuildContext context) {

    String name = user.displayName;

    return AnimatedCard(
      child: Card(
        child: ListTile(
          leading: CircleAvatarApp(name: '${dayInfo.day.day} $monthStr', isFirstName: false, size: 60,),
          title: Text(name.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 14),),
          subtitle: Text(DateFormat("dd/MM/yyyy").format(dayInfo.day)),
          trailing: Obx(() {
            return Visibility(
              visible: controller.authService.isAdmin,
              child: _builderDayTrailling(),
            );
          })
        )
      ),
    );
  }

  Widget _builderDayTrailling() {
    if(controller.daySelected == null) {
      return _builderTextAction(
        'Realizar Troca de Dia', 
        onTap: () => controller.setDaySelected(dayInfo)
      ); 
    } 
            
    if(controller.daySelected == dayInfo) {
      return _builderTextAction(
        'Selecionado', 
        color: Colors.green,
        onTap: () => controller.setDaySelected(null)
      );
    }

    return _builderTextAction(
      'Realizar Troca', 
      onTap: () => Get.defaultDialog(
        title: 'Atenção',
        content: Text(
          'Você está prester a realizar a troca entre os colaboradores: ${user.displayName} e ${controller.daySelected!.userResponsible.displayName}. Deseja realmente realizar está ação?'
        ),
        onConfirm: () {
          Get.back();
          controller.executeChangeBetweenUsers(dayInfo);
        },
        onCancel: () => Get.back(),
        textCancel: 'Cancelar',
        textConfirm: 'Realizar Troca',
        confirmTextColor: Colors.white
      )
    );
  }

  Widget _builderTextAction(String text, {VoidCallback? onTap, Color? color}) {
    return TextButton(
      onPressed: onTap, 
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: color ?? Colors.grey,
          fontSize: 11,
          fontWeight: FontWeight.bold
        ),
      )
    );
  }

  String get monthStr {
    String? month = utildate.DateUtils.getMonth(dayInfo.day);
    return month!.substring(0, 3);
  }
}