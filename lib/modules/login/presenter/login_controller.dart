
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/login/domain/usecases/authentication.dart';
import 'package:gestao_escala/modules/login/domain/usecases/register.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../shared/presenter/loader/loader_mixin.dart';
import '../../shared/presenter/messages/messages_mixin.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final Authentication authentication;
  final Register register;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
 
  final isLogin = true.obs;
  final obscureText = true.obs;
  final isSavedEmail = false.obs;

  String get titleButton =>  isLogin.value ? 'Logar' : 'Cadastrar';
  String get alertBottom =>  isLogin.value ? 'Não possui uma conta? ' : 'Já é cadastrado? ';
  String get actionBottom => isLogin.value ? 'Cadastrar' : 'Logar';

  LoginController({
    required this.authentication,
    required this.register
  });

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    isSavedEmail.value = Get.arguments['email'].toString().isNotEmpty; 
  }

  Future<void> executeOperation(String name, String email, String password) async {
    final params = AuthenticationParams(name: name, email: GetUtils.removeAllWhitespace(email), password: password);
    loading(true);
    try {
      isLogin.value ? await _login(params) : await _register(params);
      Get.offNamed('/home');
    } on Failure catch(e) {
      loading(false);
      message(
        MessageModel.error(
          title: 'Autenticação', 
          message: e.messageError
        )
      );
    }
  }

  Future<void> _login(AuthenticationParams params) async => await authentication(params, isSavedEmail.value);

  Future<void> _register(AuthenticationParams params) async {
    final userModel = UserModel(
      email: params.email, 
      displayName: params.name, 
      uid: Uuid().v4(), 
      password: params.password
    );
    await register(userModel);
  }

  void onTapActionTitle() => isLogin.value = !isLogin.value;
  void tooglePassword() => obscureText.value = !obscureText.value;
  void toogleEmailSaved(bool? result) => isSavedEmail.value = result!;

  String? validateEmail(String? value) {

    if(value!.isEmpty) {
      return 'Campo obrigatório, favor preencher!';
    }

    if(!GetUtils.isEmail(GetUtils.removeAllWhitespace(value))) {
      return 'E-mail inválido, favor preencher novamente!';
    }

    return null;
  }
}