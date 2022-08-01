import 'package:floating_action_bubble/floating_action_bubble.dart';
import 'package:flutter/material.dart';
import 'package:gestao_escala/application/ui/app_ui_config.dart';
import 'package:gestao_escala/application/ui/components/alert_message_app.dart';
import 'package:gestao_escala/application/ui/messages/messages_mixin.dart';
import 'package:gestao_escala/application/utils/extensions.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_controller.dart';
import 'package:gestao_escala/modules/home/tab_scale/scale_member_page.dart';
import 'package:get/get.dart';
import 'components/card_date.dart';


class ScaleListPage extends StatefulWidget {

  const ScaleListPage({ Key? key }) : super(key: key);

  @override
  State<ScaleListPage> createState() => _ScaleListPageState();
}

class _ScaleListPageState extends State<ScaleListPage> with SingleTickerProviderStateMixin {

  final controller = Get.find<ScaleController>();

  late Animation<double> _animation;
  late AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 260),
    );

    final curvedAnimation = CurvedAnimation(curve: Curves.easeInOut, parent: _animationController);
    _animation = Tween<double>(begin: 0, end: 1).animate(curvedAnimation);
    
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: controller.streamDaysScale,
        initialData: controller.daysScale,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {  
          if(snapshot.hasError) {
            return AlertMessageApp(
              messageModel: MessageModel(message: snapshot.error.toString().exception(), type: MessageType.info)
            );
          }

          if(!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          if(controller.daysScale!.isEmpty) {
            return AlertMessageApp(
              messageModel: MessageModel(message: 'Não há escala gerada para este Ano!', type: MessageType.info)
            );  
          }

          return ListView.builder(
            itemCount: controller.daysScale!.length,
            itemBuilder: (context, index) {
              return CardDate(
                dayInfo: controller.daysScale![index]
              );
            }
          );
        },
      ),
      floatingActionButton: Obx(() => builderButton(context))
    );  
  }

  Widget builderButton(BuildContext context) {
    final button = controller.isActivateAddScale ? builderButtonAddScale() : buildFloatingActionBubble();

    return Visibility(
      visible: controller.authService.isAdmin,
      child: button,
    );
  }

  Widget builderButtonAddScale() {
    return FloatingActionButton(
      onPressed: () => Get.to(ScaleMemberPage(onTapSave: () => _onFinishSelectedMember(),)),
      child: Icon(Icons.add),
    );
  }

  Widget buildFloatingActionBubble() {
    return FloatingActionBubble(
      items: [
        Bubble(
          title: "Incluir Novo Membro",
          iconColor :Colors.white,
          bubbleColor : AppUiConfig.colorMain,
          icon: Icons.people,
          titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
          onPress: () {
            final page = ScaleMemberPage(
              onTapSave: () => showDialogMemberInserted(),
              insertNewMember: true,
            );

            _animationController.reverse();
            Get.to(page);
          },
        ),
        Bubble(
          title: "Remover Escala",
          iconColor :Colors.white,
          bubbleColor : AppUiConfig.colorMain,
          icon: Icons.delete,
          titleStyle:TextStyle(fontSize: 16 , color: Colors.white),
          onPress: () {
            _animationController.reverse();
            showModalBottomSheet(
              context: context, 
              builder: (context) => builderModalContainer(context)
            );
          },
        ),
      ],
      animation: _animation,
      onPress: () => _animationController.isCompleted ? _animationController.reverse() : _animationController.forward(),
      iconColor: AppUiConfig.colorMain,
      iconData: Icons.info,
      backGroundColor: Colors.white,
    );
  }

  Container builderModalContainer(BuildContext context) {
    return Container(
      height: 250,
      child: Column(
        children: [
          AlertMessageApp(messageModel: MessageModel(message: 'Você está prestes a remover a escala gerada deste ano! Deseja realizar esta ação?\nObs: O processo pode levar alguns segundos.', type: MessageType.info)),
          SizedBox(height: 10,),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(onPressed: () => onClickRemoveScale(context), icon: Icon(Icons.thumb_up), label: Text('Sim')),
              SizedBox(width: 10,),
              ElevatedButton.icon(onPressed: () => Navigator.of(context).pop(), icon: Icon(Icons.thumb_down), label: Text('Não')),
            ],
          )
        ],
      ),
    );
  }

  void _onFinishSelectedMember() {
    Get.back();
    showDialogGenerateScale();
  }

  void onClickRemoveScale(BuildContext context) {
    Navigator.of(context).pop();
    controller.deleteScale();
  }

  void showDialogMemberInserted() {
    Get.defaultDialog(
      title: 'Informação',
      content: builderFutureContentDialog(
        future: controller.onCreatedScale(),
        messageSucess: 'Colaborador inserido com sucesso!'
      ),
    );
  }

  void showDialogGenerateScale() {
    Get.defaultDialog(
      title: 'Informação',
      content: builderFutureContentDialog(
        future: controller.onCreatedScale(),
        messageSucess: 'Escala deste Ano Gerada com sucesso!'
      ),
    );
  }

  FutureBuilder<bool> builderFutureContentDialog({required Future<bool> future, required String messageSucess}) {
    return FutureBuilder<bool>(
      future: future,
      builder: (context, snapshot) {
        if(snapshot.hasError) {
          return AlertMessageApp(
            messageModel: MessageModel(message: snapshot.error.toString().exception(), type: MessageType.error),
          );
        }

        if(!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return AlertMessageApp(
          messageModel: MessageModel(message: messageSucess, type: MessageType.sucess),
        );
      }
    );
  }
}