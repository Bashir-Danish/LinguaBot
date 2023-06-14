import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VoicePage extends StatelessWidget {
  const VoicePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Voice page clicked');
      },
      child:const Center(
        child: Text('Voice Page'),
      ),
    );
  }
}
