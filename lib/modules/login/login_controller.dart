import 'package:gestao_escala/application/auth/auth_service.dart';
import 'package:gestao_escala/application/ui/loader/loader_mixin.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/modules/models/user_model.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:get/get.dart';
import 'package:uuid/uuid.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final AuthService authService;
  final ILoginRepository loginRepository;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  final isLogin = true.obs;
  final showPassword = false.obs;

  LoginController({required this.loginRepository, required this.authService});

  String get titleButton =>  isLogin.value ? 'Logar' : 'Cadastrar';
  String get alertBottom =>  isLogin.value ? 'Não possui uma conta? ' : 'Já é cadastrado? ';
  String get actionBottom => isLogin.value ? 'Cadastrar' : 'Logar';

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> auth(String name, String email, String password) async {
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
      Get.offNamed('/home');
    } catch(e) {
      loading(false);
      message(MessageModel.error(title: 'Autenticação', message: e.toString()));
    } 
  }

  void onTapActionTitle() => isLogin.value = !isLogin.value;
  void tooglePassword() => showPassword.value = !showPassword.value;
}