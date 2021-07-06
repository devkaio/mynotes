import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final text;
  final fontSize;
  final color;
  final fontWeight;
  const TextWidget(
      {Key? key, this.text, this.fontSize, this.color, this.fontWeight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(18, 8, 18, 8),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          color: color,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
