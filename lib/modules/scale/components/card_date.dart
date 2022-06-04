import 'package:animated_card/animated_card.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/models/day_model.dart';
import 'package:intl/intl.dart';
import 'package:gestao_escala/application/utils/date_utils.dart' as utildate;
import '../../../application/ui/components/circle_avatar_app.dart';

class CardDate extends StatelessWidget {

  final DayModel dayInfo;

  CardDate({ Key? key, required this.dayInfo }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    String name = dayInfo.userResponsible.displayName;

    return AnimatedCard(
      child: Card(
        child: ListTile(
          leading: CircleAvatarApp(name: '${dayInfo.day.day} $monthStr', isFirstName: false, size: 60,),
          title: Text(name.toUpperCase(), style: TextStyle(color: Colors.grey, fontSize: 14),),
          subtitle: Text(DateFormat("dd/MM/yyyy").format(dayInfo.day)),
          trailing: Text(isPaid() ? 'Pago'.toUpperCase() : 'Devendo'.toUpperCase()),
        )
      ),
    );
  }

  bool isPaid() => dayInfo.day.isBefore(DateTime.now()); 

  String get monthStr {
    String? month = utildate.DateUtils.getMonth(dayInfo.day);

    return month!.substring(0, 3);
  }
}