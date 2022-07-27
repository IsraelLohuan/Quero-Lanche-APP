import 'package:flutter/material.dart';

class FormFieldApp extends StatelessWidget {

  final Widget prefixIcon;
  final String hintText;
  final String? Function(String? value)? validator;
  final bool? obscureText;
  final TextEditingController controller;
  final Function(String value)? onChanged;

  FormFieldApp({
    Key? key,
    required this.prefixIcon,
    required this.hintText, 
    required this.controller,
    this.validator,
    this.obscureText,
    this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      child: TextFormField(
          onChanged: onChanged,
          controller: controller,
          obscureText: obscureText ?? false,
          validator: validator,
          maxLines: 1,
          style: TextStyle(fontSize: 17),
          textAlignVertical: TextAlignVertical.center,
          decoration: InputDecoration(
          filled: true,
          prefixIcon: prefixIcon,
          border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.all(Radius.circular(10))),
          fillColor: Theme.of(context).inputDecorationTheme.fillColor,
          contentPadding: EdgeInsets.zero,
          hintText: hintText,
        ),
      ),
    );
  }
}