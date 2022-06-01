import 'package:gestao_escala/application/ui/loader/loader_mixin.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/repositories/login/i_login_repository.dart';
import 'package:get/get.dart';

class LoginController extends GetxController with LoaderMixin, MessagesMixin {

  final ILoginRepository loginRepository;
  final loading = false.obs;
  final message = Rxn<MessageModel>();

  LoginController({required this.loginRepository});

  @override
  void onInit() {
    super.onInit();
    loaderListener(loading);
    messageListener(message);
  }

  Future<void> login() async {
    try {
      loading(true);
      await loginRepository.login();
      loading(false);
    } catch(e) {
      loading(false);
      message(MessageModel.error(title: 'Login', message: 'Erro ao realizar Login'));
    }
  }
}