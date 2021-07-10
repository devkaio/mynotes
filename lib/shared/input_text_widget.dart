import 'package:flutter/material.dart';

class InputTextWidget extends StatelessWidget {
  final controller;
  final textInputType;
  final label;
  final hintText;
  final validator;
  final focusNode;
  final bool obscureText;

  const InputTextWidget({
    Key? key,
    this.controller,
    this.textInputType = TextInputType.text,
    required this.label,
    required this.hintText,
    this.validator,
    this.focusNode,
    required this.obscureText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: TextFormField(
        controller: controller,
        validator: validator,
        focusNode: focusNode,
        keyboardType: textInputType,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(
            color: Color(0xFF3EBC90),
          ),
          hintText: hintText,
          hintStyle: TextStyle(
            color: Color(0xFFAEAAAA),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(32),
              bottomRight: Radius.circular(32),
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          filled: true,
          fillColor: Color(0xFFFEFEFE),
          contentPadding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
          focusedErrorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Color(0x00000000),
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(32),
            ),
          ),
        ),
        onEditingComplete: () {
          FocusScope.of(context).nextFocus();
        },
        textInputAction: TextInputAction.next,
      ),
    );
  }
}
