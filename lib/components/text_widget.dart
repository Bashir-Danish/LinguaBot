import 'package:flutter/material.dart';

class TextWidget extends StatelessWidget {
  final String label;
  final double fontSize;
  final Color? color;
  final FontWeight? fontWeight;

   TextWidget({super.key,required this.label,this.color,this.fontSize =18,this.fontWeight });

  @override
  Widget build(BuildContext context) {
   double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double responsiveFontSize = (fontSize / 414.0) * screenWidth; 
    return Text(
      label,
      style: TextStyle(
        color: color ?? Colors.grey,
        fontSize: responsiveFontSize,
        fontWeight: fontWeight?? FontWeight.w500,
        fontFamily: 'Lexend'
      ),
    );
  }
}