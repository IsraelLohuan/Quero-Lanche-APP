import 'package:gestao_escala/application/services/auth/auth_service.dart';
import 'package:gestao_escala/application/ui/loader/loader_mixin.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:uuid/uuid.dart';

import '../../application/services/auth/auth_service.dart';
import '../../application/utils/constants.dart';
import '../../application/utils/extensions.dart';
import '../../application/utils/utils.dart';
import '../../models/user_model.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final AuthService authService;
  final ILoginRepository loginRepository;
  final loading = false.obs;
  final message = Rxn<MessageModel>();
  final _getStorage = GetStorage();

  final isLogin = true.obs;
  final obscureText = true.obs;
  final isSavedEmail = false.obs;

  LoginController({required this.loginRepository, required this.authService});

  String get titleButton =>  isLogin.value ? 'Logar' : 'Cadastrar';
  String get alertBottom =>  isLogin.value ? 'Não possui uma conta? ' : 'Já é cadastrado? ';
  String get actionBottom => isLogin.value ? 'Cadastrar' : 'Logar';

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
    isSavedEmail.value = Get.arguments['email'].toString().isNotEmpty; 
  }

  Future<void> auth(String name, String email, String password) async {

    email = GetUtils.removeAllWhitespace(email);

    try {
      loading(true);

      final user = UserModel(
        email: email, 
        displayName: name, 
        uid: Uuid().v1(), 
        password: password
      );

      authService.userModel = isLogin.value ? await loginRepository.login(email, password) : await loginRepository.register(user);
    
      loading(false);

      if(isSavedEmail.value) {
        _getStorage.write(Constants.KEY_EMAIL, user.email);
      } else {
        _getStorage.remove(Constants.KEY_EMAIL);
      }

      Get.offNamed('/home');
    } catch(e) {
      loading(false);
      message(MessageModel.error(title: 'Autenticação', message: Utils.messageException(e)));
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