
import 'dart:async';
import 'package:gestao_escala/application/services/auth/auth_service.dart';
import 'package:gestao_escala/application/services/member/member_service.dart';
import 'package:gestao_escala/application/ui/loader/loader_mixin.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/application/utils/date_utils.dart';
import 'package:gestao_escala/application/utils/utils.dart';
import 'package:gestao_escala/models/day_model.dart';
import 'package:gestao_escala/models/user_model.dart';
import 'package:gestao_escala/repositories/scale/i_scale_repository.dart';
import 'package:get/get.dart';

class ScaleController extends GetxController with LoaderMixin, MessagesMixin {

  final IScaleRepository scaleRepository;
  final MemberService memberService;
  final AuthService authService;
  final RxBool _isStateButtonCreateScale = true.obs;
  final RxBool _isLoading = false.obs;
  final _messageModel = Rxn<MessageModel>();
  final StreamController<List<DayModel>?> _streamDaysScale = StreamController<List<DayModel>?>.broadcast();
  final Rx<DayModel?> _daySelected = Rx<DayModel?>(null);
  final Rx<List<UserModel>> userRx = Rx<List<UserModel>>([]);
  List<UserModel> allUsers = [];
  List<DayModel>? daysScale;

  bool _isPaid(DayModel dayInfo)     => dayInfo.day.isBefore(DateTime.now()); 
  Stream get streamDaysScale         => _streamDaysScale.stream;
  bool get isActivateAddScale        => _isStateButtonCreateScale.value;
  String get usersSelectedTotal      => usersSelected.length.toString();
  List<UserModel> get usersSelected  => userRx.value.where((user) => user.isSelected).toList();
  DayModel? get daySelected          => _daySelected.value;
 
  ScaleController({
    required this.scaleRepository, 
    required this.memberService, 
    required this.authService
  });
 
  void setDaySelected(DayModel? user) => _daySelected.value = user;

  void updateStateActionButton() {
    if(daysScale != null) {
      _isStateButtonCreateScale.value = daysScale!.isEmpty;
      return;
    }

    _isStateButtonCreateScale.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    loaderListener(_isLoading); 
    messageListener(_messageModel);
    fetchScale();
  }

  List<DayModel> _getNextDays(List<DayModel> allDays) {
    List<DayModel> nextDays = allDays.where((result) => result.day.isAfter(DateTime.now())).toList();
    return nextDays;
  }

  updateListScale(List<DayModel> value) {
    daysScale = value;
    final days = _getNextDays(daysScale!);
    _streamDaysScale.add(days);
  }

  Future<void> fetchScale() async {
    try {
      updateListScale(await scaleRepository.fetchAllDays());
    } catch(e) {
      _streamDaysScale.addError(Utils.messageException(e));
    } 

    updateStateActionButton();
  }

  Future<void> deleteScale() async {
    try {
      _isLoading(true);
      await scaleRepository.deleteScale();
      updateListScale([]);
    } catch(e) {
      _isLoading(false);
      _messageModel(
        MessageModel.error(title: 'OPS', message: Utils.messageException(e))
      );
    }

    _isLoading(false);
    updateStateActionButton();
  }

  Future<List<UserModel>> fetchAllUsers() async {
    allUsers = await memberService.fetchAll(); 

    if(allUsers.length == 1) {
      throw Exception('N??o ?? poss??vel continuar com a opera????o, necess??rio no m??nimo 2 Usu??rios cadastrados :(');
    }

    return allUsers;
  }

  List<DayModel> _generateScale() {
    final fridays = DateUtils.getAllfridayDayFromYear();

    List<DayModel> daysModel = [];

    int index = 0;

    for(DateTime day in fridays) {
      daysModel.add(DayModel(day: day, userResponsible: usersSelected[index]));
      index = (index >= usersSelected.length - 1) ? 0 : index + 1;
    } 

    return daysModel;
  }

  Future<bool> onCreatedScale() async {
    final totalUsersSelected = int.parse(usersSelectedTotal);
    final daysScale = _generateScale();

    if(totalUsersSelected <= 1) {
      throw Exception('Necess??rio no m??nimo 2 Usu??rios selecionados!');
    }

    if(totalUsersSelected > daysScale.length) {
      throw Exception('O total de usu??rios selecionados ultrapassa o restante de sextas feiras do ano!\n\n');
    }

    await scaleRepository.createScale(daysScale);
    await fetchScale();

    return true;
  }

  int getDataPaid(bool value) {
    if(daysScale?.isEmpty == true) {
      return 0;
    }

    final values = daysScale?.where((info) {
      return info.userResponsible.displayName == authService.user.displayName && _isPaid(info) == value;
    });

    return values?.length ?? 0;
  }

  Future executeChangeBetweenUsers(DayModel daySelectForChanged) async {
    try {
      _isLoading(true);
      await _updateDayModel(daySelected!, newUser: daySelectForChanged.toJson()['user']);
      await _updateDayModel(daySelectForChanged, newUser: daySelected!.toJson()['user']);
      setDaySelected(null);
      fetchScale();
      _isLoading(false);
    } catch(error) {
      _isLoading(false);
      _messageModel(
        MessageModel.error(
          title: 'Info',
          message: 'Algo de inesperado ocorreu ao realizar atualiza????o!'
        )
      );
    } 
  }

  Future _updateDayModel(DayModel day, {required Map newUser}) async {
    final json = <String, Object>{
      'day': day.toJson()['day'],
      'user': newUser
    };

    await scaleRepository.updateScale(
      id: day.id, 
      data: json
    );
  }
}