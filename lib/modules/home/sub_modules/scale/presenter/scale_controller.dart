import 'dart:async';
import 'package:gestao_escala/application/utils/utils.dart';
import 'package:gestao_escala/modules/home/sub_modules/scale/domain/usecases/generate_scale.dart';
import 'package:get/get.dart';
import '../../../../shared/domain/entities/day_model.dart';
import '../../../../shared/domain/entities/user_model.dart';
import '../../../../shared/presenter/loader/loader_mixin.dart';
import '../../../../shared/presenter/messages/messages_mixin.dart';

class ScaleController extends GetxController with LoaderMixin, MessagesMixin {
  final GenerateScale generateScale;

  final IScaleRepository scaleRepository;

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
    required this.generateScale
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

  Future<bool> onCreatedScale() async {
    if(int.parse(usersSelectedTotal) <= 1) {
      throw Exception('Necessário no mínimo 2 Usuários selecionados!');
    }

    await scaleRepository.createScale(generateScale(usersSelected));
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