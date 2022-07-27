
import 'package:gestao_escala/modules/login/domain/errors/errors.dart';
import 'package:gestao_escala/modules/login/domain/usecases/authentication.dart';
import 'package:gestao_escala/modules/shared/domain/entities/user_model.dart';
import 'package:get/get.dart';
import '../../shared/presenter/loader/loader_mixin.dart';
import '../../shared/presenter/messages/messages_mixin.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final Authentication authentication;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
 
  final isLogin = true.obs;
  final obscureText = true.obs;
  final isSavedEmail = false.obs;

  String get titleButton =>  isLogin.value ? 'Logar' : 'Cadastrar';
  String get alertBottom =>  isLogin.value ? 'Não possui uma conta? ' : 'Já é cadastrado? ';
  String get actionBottom => isLogin.value ? 'Cadastrar' : 'Logar';

  LoginController(this.authentication);

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    isSavedEmail.value = Get.arguments['email'].toString().isNotEmpty; 
  }

  Future<void> auth(String name, String email, String password) async {
    try {
      email = GetUtils.removeAllWhitespace(email);
      loading(true);
      await authentication(
        AuthenticationParams(name: name, email: email, password: password),
        isSavedEmail.value
      );
      loading(false);
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