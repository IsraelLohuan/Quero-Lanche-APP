import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gestao_escala/models/user_model.dart';

class DayModel {
  late DateTime day;
  late UserModel userResponsible;
  late String id;

  DayModel({required this.day, required this.userResponsible});

  DayModel.fromJson(Map<String, dynamic> json) {
    day = (json['day'] as Timestamp).toDate(); 
    userResponsible = UserModel.fromJson(json['user']);
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    return {
      'day': day,
      'user': userResponsible.toJson(),
    };
  } 
}