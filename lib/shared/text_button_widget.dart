import 'package:flutter/material.dart';

class TextButtonWidget extends StatelessWidget {
  final text;
  final onPressed;

  const TextButtonWidget({Key? key, this.text, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(text),
      style: TextButton.styleFrom(
        primary: Colors.grey,
      ),
    );
  }
}
