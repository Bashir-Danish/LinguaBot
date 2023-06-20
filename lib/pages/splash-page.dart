import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/pages/home-page.dart';
import 'package:linguabot/utils/constants.dart';
import 'package:linguabot/pages/auth-page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> redirectPage() async {
    Box userBox;
   if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }
    UserModel? user = userBox.get('user');

    if (user != null && user is UserModel) {
      if (user.token != null && user.token != '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => MyHomePage()),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AuthPage()),
        );
      }
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => AuthPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 25),
              child: const Column(
                children: [
                  Text(
                    'Welcome to',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: kPrimaryColor,
                    ),
                  ),
                  Text(
                    'LinguaBot',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Bitter',
                        fontSize: 36,
                        fontWeight: FontWeight.w900,
                        color: kPrimaryColor,
                        letterSpacing: 5),
                  ),
                ],
              ),
            ),
            const Expanded(
              child: CardBox(
                title: 'Chat',
                text:
                    'Conversion practice, exercises,feedback and personalization with chatbot. Translation assistance and cultural info included.',
              ),
            ),
            const Expanded(
              child: CardBox(
                title: 'Translate',
                text:
                    'You can translate individual words and their various forms. Additionally, your app has the capability to translate entire sentences and provide paraphrases',
              ),
            ),
            const Expanded(
              child: CardBox(
                title: 'Voice',
                text:
                    'Mic captures voice, converts to text, matched with correct pronunciations, feedback given. User can have exercises to improve',
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: IconButton(
                onPressed: () {
                  redirectPage();
                },
                icon: const Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: kPrimaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CardBox extends StatelessWidget {
  final String title;
  final String text;

  const CardBox({Key? key, required this.title, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFFFFFFFF),
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                return FittedBox(
                  fit: BoxFit.scaleDown,
                  child: SizedBox(
                    width: constraints.maxWidth,
                    child: Text(
                      text,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
