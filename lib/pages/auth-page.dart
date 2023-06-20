import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:linguabot/models/user_model.dart';
import 'package:linguabot/services/api_services.dart';
import 'package:linguabot/utils/constants.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:linguabot/pages/home-page.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthPage extends StatefulWidget {
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _signUpLoader = false;
  bool _loginLoader = false;
  PageController _pageController = PageController();

  late TextEditingController _loginEmailController;

  late TextEditingController _loginPassController;

  late TextEditingController _signupUsrenameController;

  late TextEditingController _signupEmailController;

  late TextEditingController _signupPassController;
  String? errorMessage;
  late Box userData;
  @override
  void initState() {
    _loginEmailController = TextEditingController();
    _loginPassController = TextEditingController();
    _signupEmailController = TextEditingController();
    _signupPassController = TextEditingController();
    _signupUsrenameController = TextEditingController();

    super.initState();
  }

  void dispose() {
    _loginEmailController.dispose();
    _loginPassController.dispose();
    _signupUsrenameController.dispose();
    _signupEmailController.dispose();
    _signupPassController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   title: const Text(
        //     'Get Started',
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //         fontFamily: 'Bitter',
        //         fontSize: 25,
        //         fontWeight: FontWeight.w900,
        //         color: kPrimaryColor,
        //         letterSpacing: 5),
        //   ),
        //   automaticallyImplyLeading: false,
        //   centerTitle: true,
        // ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: DefaultTextStyle(
                  style: const TextStyle(
                    fontFamily: 'Bitter',
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: kPrimaryColor,
                    letterSpacing: 5,
                  ),
                  child: AnimatedTextKit(
                    repeatForever: true,
                    animatedTexts: [
                      WavyAnimatedText('Get Started'),
                    ],
                    isRepeatingAnimation: true,
                  ),
                ),
              ),
              SizedBox(
                height: 500,
                child: PageView(
                  controller: _pageController,
                  children: [
                    Card(
                      elevation: 4.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(0),
                          bottomLeft: Radius.circular(0),
                          bottomRight: Radius.circular(30),
                        ),
                      ),
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Login',
                              style: TextStyle(
                                  fontFamily: 'Bitter',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 5),
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                controller: _loginEmailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                controller: _loginPassController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(height: 25),
                            _loginLoader
                                ? const SpinKitDualRing(
                                    color: kPrimaryColor,
                                    size: 25,
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      login();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('Login'),
                                  ),
                            TextButton(
                              onPressed: () {
                                _pageController.animateToPage(
                                  1,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOutCubic,
                                );
                              },
                              child: const Text('Create Account'),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              errorMessage ?? '',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    Card(
                      elevation: 4.0,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(0),
                          topRight: Radius.circular(30),
                          bottomLeft: Radius.circular(30),
                          bottomRight: Radius.circular(0),
                        ),
                      ),
                      margin: const EdgeInsets.all(16.0),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'SignUp',
                              style: TextStyle(
                                  fontFamily: 'Bitter',
                                  fontSize: 25,
                                  fontWeight: FontWeight.w900,
                                  color: Colors.black,
                                  letterSpacing: 5),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                controller: _signupUsrenameController,
                                decoration: const InputDecoration(
                                  labelText: 'Username',
                                  prefixIcon: Icon(Icons.person),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                controller: _signupEmailController,
                                decoration: const InputDecoration(
                                  labelText: 'Email',
                                  prefixIcon: Icon(Icons.email),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 20.0),
                              child: TextField(
                                controller: _signupPassController,
                                decoration: const InputDecoration(
                                  labelText: 'Password',
                                  prefixIcon: Icon(Icons.lock),
                                ),
                                obscureText: true,
                              ),
                            ),
                            const SizedBox(height: 25),
                            _signUpLoader
                                ? const SpinKitDualRing(
                                    color: kPrimaryColor,
                                    size: 25,
                                  )
                                : ElevatedButton(
                                    onPressed: () {
                                      signup();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: kPrimaryColor,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: const Text('SignUp'),
                                  ),
                            TextButton(
                              onPressed: () {
                                _pageController.animateToPage(
                                  0,
                                  duration: Duration(milliseconds: 400),
                                  curve: Curves.easeInOutCubic,
                                );
                              },
                              child: const Text('Already have account'),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              errorMessage ?? '',
                              style: const TextStyle(
                                color: Colors.red,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  //// -------------------- ّFunctions ------------------////

  Future<void> signup() async {
    Box userBox;
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }
    String username = _signupUsrenameController.text;
    String email = _signupEmailController.text;
    String password = _signupPassController.text;
    setState(() {
      _signUpLoader = true;
      errorMessage = '';
    });
    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      setState(() {
        _signUpLoader = true;
        errorMessage = 'Please fill inputs';
      });
    }
    try {
      var response = await ApiService.signup(username, email, password);

      if (response.containsKey('error')) {
        setState(() {
          errorMessage = response['error'];
          _signUpLoader = false;
        });
      }
    } catch (e) {
      // print('SignUp error: $e');
    } finally {
      setState(() {
        _signUpLoader = false;
      });
    }
    UserModel? user = userBox.get('user');

    if (user != null && user is UserModel) {
      if (user.token != null && user.token != '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    }
  }

  Future<void> login() async {
    Box userBox;
    if (Hive.isBoxOpen('users')) {
      userBox = Hive.box<UserModel>('users');
    } else {
      userBox = await Hive.openBox<UserModel>('users');
    }

    String email = _loginEmailController.text;
    String password = _loginPassController.text;

    if (email.isEmpty || password.isEmpty) {
      setState(() {
        errorMessage = 'Please fill inputs';
      });
      return;
    }
    setState(() {
      _loginLoader = true;
      // errorMessage = '';
    });
    try {
      var response = await ApiService.login(email, password);

        print(response);
     if (response.containsKey('error')) {
        setState(() {
          errorMessage = response['error'];
          _loginLoader = false;
        });
      }
    } catch (e) {
      // print('Login error: $e');
    } finally {
      setState(() {
        _loginLoader = false;
      });
    }
    UserModel? user = userBox.get('user');

    if (user != null && user is UserModel) {
      if (user.token != null && user.token != '') {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const MyHomePage()),
        );
      }
    }
  }
}
