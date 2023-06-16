import 'package:flutter/material.dart';

const kBaseUrl = 'http://192.168.20.246:5000';
const kScaffoldBackgroundColor = Color(0xFFFBFBFB);
const kPrimaryColor= Color(0xFF6C82F9);
Color secondaryColor = Color(0xFFE8F5E9);


final kMyTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  appBarTheme:kAppBarTheme,
);

const kAppBarTheme =AppBarTheme(
    backgroundColor: Colors.white,
    elevation: 0,
    iconTheme: IconThemeData(
      color: Colors.black,
    ),
    titleTextStyle: TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    ),
  );

final kTagStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.grey,
  backgroundColor: Colors.white,
  shape: RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20),
    side: const BorderSide(color: Color(0xFF6C82F9)),
  ),
  elevation: 2,
);

TextStyle kTitleStyle =const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);



Map<String, String> kTags = {
    'Grammar': 'Tell me about grammar of English',
    'Part of Speech': 'Tell me about Part of Speech of English',
    'Tenses': 'Tell me about grammar of tense',
  };