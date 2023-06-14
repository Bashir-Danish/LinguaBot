import 'package:flutter/material.dart';
import 'package:linguabot/pages/translate-page.dart';
import 'package:linguabot/pages/chat-page.dart';
import 'package:linguabot/pages/voice-page.dart';
import 'package:linguabot/utils/constants.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          elevation: 2,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:const EdgeInsets.all(8.0),
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
          bottom: TabBar(
            controller: _tabController,
            tabs: const [
              Tab(
                icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.translate
                  ),
                ),
              ),
              Tab(
              icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.chat
                  ),
                ),
              ),
              Tab(
               icon: SizedBox(
                  height: 12,
                  child: Icon(Icons.mic
                  ),
                ),
              ),
            ],
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: const Color.fromARGB(255, 255, 255, 255)
            ),
            indicatorColor: kPrimaryColor,
            labelColor: kPrimaryColor,
            unselectedLabelColor: Colors.grey,
            // indicatorSize: TabBarIndicatorSize.label
          ),
          centerTitle: true,
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          TranslatePage(),
          ChatPage(),
          VoicePage(),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.translate),
      //       label: 'Translate',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.chat),
      //       label: 'Chat',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.mic),
      //       label: 'Voice',
      //     ),
      //   ],
      //   currentIndex: _tabController.index,
      //   selectedItemColor: Colors.blue,
      //   unselectedItemColor: Colors.grey,
      //   onTap: (index) {
      //     setState(() {
      //       _tabController.index = index;
      //     });
      //   },
      // ),
    );
  }
}
