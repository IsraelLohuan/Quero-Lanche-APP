
import 'dart:async';
import 'package:gestao_escala/application/services/auth_service.dart';
import 'package:gestao_escala/application/services/member_service.dart';
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

  final StreamController<List<DayModel>> _streamDaysScale = StreamController<List<DayModel>>.broadcast();

  Rx<List<UserModel>> userRx = Rx<List<UserModel>>([]);
  List<UserModel> allUsers = [];
  List<DayModel>? daysScale;

  final RxBool _isStateButtonCretaeScale = true.obs;
  final RxBool _isLoading = false.obs;
  final _messageModel = Rxn<MessageModel>();

  ScaleController({required this.scaleRepository, required this.memberService, required this.authService});
 
  bool isPaid(DayModel dayInfo)   => dayInfo.day.isBefore(DateTime.now()); 
  Stream get streamDaysScale      => _streamDaysScale.stream;
  bool get isActivateAddScale     => _isStateButtonCretaeScale.value;
  String get usersSelectedTotal   => usersSelected.length.toString();

  List<UserModel> get usersSelected => userRx.value.where((user) => user.isSelected).toList();

  void updateStateActionButton() {
    if(daysScale != null) {
      _isStateButtonCretaeScale.value = daysScale!.isEmpty;
      return;
    }

    _isStateButtonCretaeScale.value = true;
  }

  @override
  void onInit() {
    super.onInit();
    loaderListener(_isLoading); 
    messageListener(_messageModel);
    fetchScale();
  }

  updateListScale(List<DayModel> value) {
    daysScale = value;
    _streamDaysScale.add(value);
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
      throw Exception('Não é possível continuar com a operação, necessário no mínimo 2 Usuários cadastrados :(');
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
    if(int.parse(usersSelectedTotal) <= 1) {
      throw Exception('Necessário no mínimo 2 Usuários selecionados!');
    }

    await scaleRepository.createScale(_generateScale());
    await fetchScale();

    return true;
  }

  int getDataPaid(bool value) {
    if(daysScale?.isEmpty == true) {
      return 0;
    }

    final values = daysScale?.where((info) {
      return info.userResponsible.displayName == authService.user.displayName && isPaid(info) == value;
    });

    return values?.length ?? 0;
  }
}