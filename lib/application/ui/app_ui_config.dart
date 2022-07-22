import 'package:flutter/material.dart';
import 'package:gestao_escala/application/utils/utils.dart';

class AppUiConfig {

  AppUiConfig._();

  static String get title => 'Gestão de Escala';
  static Color get colorMain => Color.fromRGBO(49, 43, 70, 1);
  static Color get colorBackground => Colors.white;
  static Color get colorRed => Color.fromARGB(255, 192, 9, 64);

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: colorMain,
    primarySwatch: Utils.buildMaterialColor(colorMain),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: colorMain),
      titleTextStyle: TextStyle(
        color: Color(0xff222222),
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    ),
  );
}