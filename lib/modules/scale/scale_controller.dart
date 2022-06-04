
import 'dart:async';

import 'package:gestao_escala/application/services/member_service.dart';
import 'package:gestao_escala/application/utils/date_utils.dart';
import 'package:gestao_escala/models/day_model.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:gestao_escala/repositories/scale/i_scale_repository.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController {

  final IScaleRepository scaleRepository;
  final MemberService memberService;

  final StreamController<List<DayModel>> _streamDaysScale = StreamController<List<DayModel>>.broadcast();

  Stream get streamDaysScale => _streamDaysScale.stream;

  List<UserModel> allUsers = [];
  List<DayModel> daysScale = [];

  final RxList<UserModel> _usersSelected = <UserModel>[].obs;
  
  ScaleController({required this.scaleRepository, required this.memberService});

  String get usersSelectedTotal => _usersSelected.length.toString();
  bool userInList(UserModel user) => _usersSelected.contains(user);
  
  @override
  void onInit() {
    super.onInit();
    fetchScale();
  }

  Future<void> fetchScale() async {
    try {
      daysScale = await scaleRepository.fetchAllDays();
      _streamDaysScale.add(daysScale);
    } catch(e) {
      _streamDaysScale.addError(e.toString());
    } 
  }

  Future<List<UserModel>> fetchAllUsers() async {
    allUsers = await memberService.fetchAll(); 
    _usersSelected.clear();

    if(allUsers.length == 1) {
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
    }

    return allUsers;
  }

  void onChangedSwitch(bool result, UserModel user) {
    result == false ?  _usersSelected.remove(user) : _usersSelected.add(user);
  }

  List<DayModel> generateScale() {
    final fridays = DateUtils.getAllfridayDayFromYear();

    List<DayModel> daysModel = [];

    int index = 0;

    for(DateTime day in fridays) {
      daysModel.add(DayModel(day: day, userResponsible: _usersSelected[index]));
      index = (index >= _usersSelected.length - 1) ? 0 : index + 1;
    } 

    return daysModel;
  }

  Future<bool> onCreatedScale() async {
    if(int.parse(usersSelectedTotal) <= 1) {
      throw Exception('Necessário no mínimo 2 Usuários selecionados!');
    }

    await scaleRepository.createScale(generateScale());
    await fetchScale();

    return true;
  }
}