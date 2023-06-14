
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TranslatePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Translate page clicked');
      },
      child: Center(
        child: Text('Translate Page'),
      ),
    );
  }
}
