
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
  final Rx<List<UserModel>> allUsersRx = Rx<List<UserModel>>([]);
  List<DayModel>? daysScale;
  bool _insertNewMember = false;

  bool _isPaid(DayModel dayInfo)     => dayInfo.day.isBefore(DateTime.now()); 
  Stream get streamDaysScale         => _streamDaysScale.stream;
  bool get isActivateAddScale        => _isStateButtonCreateScale.value;
  int get usersSelectedTotal         => usersSelected.length;
  List<UserModel> get usersSelected  => allUsersRx.value.where((user) => user.isSelected).toList();
  DayModel? get daySelected          => _daySelected.value;
 
  ScaleController({
    required this.scaleRepository, 
    required this.memberService, 
    required this.authService
  });
 
  void setInsertNewMember(bool value) => _insertNewMember = value;

  bool isVisibleCardSwitch(UserModel user) {
    if(_insertNewMember && _userInList(user)) {
      return false;
    }
      
    return true;
  }

  bool _userInList(UserModel user) {
    if(daysScale != null) {
      final insertInList = daysScale!.firstWhereOrNull((day) => day.userResponsible.displayName == user.displayName);
      return insertInList != null;
    }
    return false;
  }

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

  List<DayModel> getNextDays() {
    final allDays = daysScale ?? [];
    List<DayModel> nextDays = allDays.where((result) => result.day.isAfter(DateTime.now())).toList();
    return nextDays;
  }

  updateListScale(List<DayModel> value) {
    daysScale = value;
    _streamDaysScale.add(getNextDays());
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

  Future<bool> fetchAllUsers() async {
    allUsersRx.value = await memberService.fetchAll(); 

    if(allUsersRx.value.length == 1) {
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
    }
    
    for(var user in allUsersRx.value) {
      if(_userInList(user)) {
        user.isSelected = true;
      }
    }

    return true;
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

  List<DayModel> _onGenerateScale() {
    final daysScale = _generateScale();

    if(usersSelectedTotal <= 1 && !_insertNewMember) {
      throw Exception('Necessário no mínimo 2 Usuários selecionados!');
    }

    if(usersSelectedTotal > daysScale.length) {
      throw Exception('O total de usuários selecionados ultrapassa o restante de sextas feiras do ano!\n\n');
    }

    return daysScale;
  }

  Future<bool> scaleManagerOperation({required bool isUpdate}) async {
    final List<DayModel> scale = _onGenerateScale();

    isUpdate ? await scaleRepository.updateAllScale(scale) : await scaleRepository.createScale(scale);
    
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
          message: 'Algo de inesperado ocorreu ao realizar atualização!'
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