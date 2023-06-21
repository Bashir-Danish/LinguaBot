import 'package:flutter/material.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/pages/splash-page.dart';
import 'package:linguabot/pages/translate-page.dart';
import 'package:linguabot/pages/chat-page.dart';
import 'package:linguabot/pages/voice-page.dart';
import 'package:linguabot/services/api_services.dart';
import 'package:linguabot/utils/constants.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late String username;    
  late TabController _tabController;
  final ValueNotifier<bool> msgClearedNotifier = ValueNotifier(false);
  @override
  void initState() {
    Box userBox;
    super.initState();
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = Hive.openBox<UserModel>('users') as Box;
    }
    UserModel user = userBox.get('user');
    username = user.username;
    _tabController = TabController(length: 3, vsync: this, initialIndex: 1);
  }

  @override
  void dispose() {
    _tabController.dispose();
    Hive.close();
    super.dispose();
  }

  Future<void> logout() async {
    Box userBox;
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }
    await userBox.clear();
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const SplashPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(100.0),
        child: AppBar(
          elevation: 2,
          title: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(
                  'assets/images/openai_logo.jpg',
                  width: 25,
                  height: 25,
                  fit: BoxFit.cover,
                ),
              ),
              const Text('LinguaBot'),
            ],
          ),
          automaticallyImplyLeading: false,
          actions: [
            PopupMenuButton<String>(
              itemBuilder: (BuildContext context) => [
                PopupMenuItem<String>(
                  value: 'logout',
                  child: TextButton(
                    onPressed: () {
                      logout();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          username,
                          style: const TextStyle(color: Colors.black),
                        ),
                        const Icon(
                          Icons.logout,
                          color: Colors.black,
                          size: 16,
                        )
                      ],)
                  ),
                ),
                PopupMenuItem<String>(
                  value: 'reset_chat',
                  child: TextButton(
                    onPressed: () async{
                      setState(() {
                        msgClearedNotifier.value = true;
                      });
                      await ApiService.resetChat();
                    },
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Reset',
                          style: TextStyle(color: Colors.black),
                        ),
                        Icon(
                          Icons.restart_alt,
                          color: Colors.black,
                          size: 16,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.translate),
                ),
              ),
              Tab(
                icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.chat),
                ),
              ),
              Tab(
                icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.mic),
                ),
              ),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 255, 255, 255),
            ),
            indicatorColor: kPrimaryColor,
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.grey,
          ),
          centerTitle: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TranslatePage(),
          ChatPage(
            msgClearedNotifier: msgClearedNotifier,
          ),
          const VoicePage(),
        ],
      ),
    );
  }
}
