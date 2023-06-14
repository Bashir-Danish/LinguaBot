import 'package:flutter/material.dart';
import 'package:linguabot/pages/splash-page.dart';
import 'package:linguabot/utils/constants.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kMyTheme,
      debugShowCheckedModeBanner: false,
      home:const SplashPage(),
    );
  }
}
