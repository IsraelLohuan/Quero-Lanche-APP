import 'package:gestao_escala/models/user_model.dart';

class DayModel {
  String month;
  int day;
  late UserModel userResponsible;

  DayModel({required this.month, required this.day});
}