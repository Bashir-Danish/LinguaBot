import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

   TextWidget({super.key,required this.label,this.color,this.fontSize =18,this.fontWeight });

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: TextStyle(
        color: color ?? Colors.grey,
        fontSize: fontSize,
        fontWeight: fontWeight?? FontWeight.w500
      ),
    );
  }
}