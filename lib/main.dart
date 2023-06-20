import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linguabot/pages/splash-page.dart';
import 'package:linguabot/models/message_model.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/utils/constants.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

void main() async {
  await Hive.initFlutter();
  await initializeHive();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: kMyTheme,
      debugShowCheckedModeBanner: false,
      home: const SplashPage(),
    );
  }
}

Future<void> initializeHive() async {
  Hive.registerAdapter(MessageAdapter());
  Hive.registerAdapter(UserModelAdapter());
  await Hive.openBox<Message>('messages');
  await Hive.openBox<UserModel>('users');
}
