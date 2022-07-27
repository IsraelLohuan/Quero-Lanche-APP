
import 'package:flutter/material.dart';
import 'package:gestao_escala/modules/login/presenter/login_controller.dart';
import 'package:gestao_escala/modules/shared/presenter/app_img_config.dart';
import 'package:gestao_escala/modules/shared/presenter/app_ui_config.dart';
import 'package:gestao_escala/modules/shared/presenter/components/form_field_app.dart';
import 'package:get/get.dart';
import 'package:wc_form_validators/wc_form_validators.dart';

class LoginPage extends GetView<LoginController> {
   
  LoginPage({Key? key, isLogin = true}) : super(key: key);

  final GlobalKey<FormState> _keyForm = GlobalKey<FormState>();
  final TextEditingController _edtName = TextEditingController();
  final TextEditingController _edtEmail = TextEditingController(text: Get.arguments['email']);
  final TextEditingController _edtPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Obx(() {
        return Form(
          key: _keyForm,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                Hero(
                  tag: 'splash',
                  child: Image.asset(AppImgConfig.logo, width: 280, height: 280,),
                ),
                Visibility(
                  visible: !controller.isLogin.value,
                  child: FormFieldApp(
                    controller: _edtName,
                    prefixIcon: Icon(Icons.person, color: Get.theme.iconTheme.color,),
                    hintText: 'Nome',
                    validator: Validators.compose([
                      Validators.required('Campo obrigatório, favor preencher!'),
                      Validators.minLength(4, 'Quantidade de Caracteres inválido!')
                    ]),
                  ),
                ),
                FormFieldApp(
                  controller: _edtEmail,
                  prefixIcon: Icon(Icons.email, color: Get.theme.iconTheme.color,),
                  hintText: 'E-mail',
                  validator: (String? value) => controller.validateEmail(value)
                ),
                Obx(() {
                  return FormFieldApp(
                    controller: _edtPassword,
                    obscureText: controller.obscureText.value,
                    prefixIcon: GestureDetector(
                      onTap: () => controller.tooglePassword(),
                      child: Icon(Icons.remove_red_eye, color: controller.obscureText.value ? Colors.grey : Get.theme.iconTheme.color,)
                    ),
                    hintText: 'Senha',
                    validator: Validators.compose([
                      Validators.required('Campo obrigatório, favor preencher!'),
                      Validators.minLength(5, 'Quantidade de caracteres inválido!'),
                    ]),
                  );
                }),
                Visibility(
                  visible: controller.isLogin.value,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('Lembrar Email', style: TextStyle(color: Colors.grey, fontSize: 13),),
                      Obx(() {
                        return Switch(
                          value: controller.isSavedEmail.value, 
                          onChanged: (bool? value) => controller.toogleEmailSaved(value)
                        );
                      })
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                  onTap: () async {
                    if(_keyForm.currentState!.validate()) {
                      await controller.auth(_edtName.text, _edtEmail.text, _edtPassword.text);
                    }
                  },
                  child: Container(
                    width: Get.width,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppUiConfig.colorMain,
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Center(
                      child: Text(controller.titleButton, style: TextStyle(color: Colors.white, fontSize: 18),),
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(controller.alertBottom, style: TextStyle(color: Colors.grey),),
                    OutlinedButton(
                      onPressed: () => onTapText(), 
                      child: Text(
                        controller.actionBottom, 
                        style: TextStyle(fontWeight: FontWeight.bold, color: AppUiConfig.colorMain),
                      ),
                    )
                  ],
                ),
              ],
            ),
          )
        );
      }),
    );
  }

  void onTapText() {
    _edtEmail.clear();
    _edtPassword.clear();
    controller.onTapActionTitle();
  }
}

