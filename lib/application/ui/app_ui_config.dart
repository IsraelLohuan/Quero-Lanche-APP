import 'package:flutter/material.dart';

class AppUiConfig {

  AppUiConfig._();

  static String get title => 'Gestão de Escala';
  static Color get colorMain => Color.fromRGBO(49, 43, 70, 1);
  static Color get colorBackground => Colors.white;

  static ThemeData get theme => ThemeData(
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(
        color: Color(0xff222222),
        fontSize: 18,
        fontWeight: FontWeight.w500
      ),
    ),
  );
}