import 'package:flutter/material.dart';

const kBaseUrl = 'http://192.168.20.246:5000';
const kScaffoldBackgroundColor = Color(0xFFFBFBFB);
const kPrimaryColor = Color(0xFF6C82F9);
Color secondaryColor = Color(0xFFE8F5E9);

final kMyTheme = ThemeData(
  primarySwatch: Colors.blue,
  scaffoldBackgroundColor: kScaffoldBackgroundColor,
  appBarTheme: kAppBarTheme,
);

const kAppBarTheme = AppBarTheme(
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

TextStyle kTitleStyle = const TextStyle(
  fontSize: 24,
  fontWeight: FontWeight.bold,
  color: kPrimaryColor,
);

Map<String, String> kTags = {
  'Greetings': 'How can I greet someone in English?',
  'Grammar': 'Can you provide information about the grammar rules in English?',
  'Part of Speech':
      'Could you explain the concept of parts of speech in English?',
  'Tenses': 'Can you tell me about the different tenses in English grammar?',
  'Pronouns': 'What are the different types and uses of pronouns in English?',
  'Sentence Structure': 'How is the sentence structure organized in English?',
  'Nouns': 'What are the rules for using nouns in English sentences?',
  'Verbs': 'Could you provide an overview of verb conjugation in English?',
  'Adjectives':
      'What are the functions and placement of adjectives in English?',
  'Adverbs': 'Tell me about the role and usage of adverbs in English grammar.',
  'Prepositions':
      'Can you explain the usage of prepositions in English sentences?',
  'Conjunctions':
      'What are the different types of conjunctions and their functions in English?',
  'Subject-Verb Agreement':
      'What are the rules for subject-verb agreement in English?',
  'Punctuation':
      'Could you explain the proper usage of punctuation marks in English?',
  'Articles': 'When and how should articles be used in English sentences?',
  'Comparatives and Superlatives':
      'Can you provide examples of comparatives and superlatives in English?',
  'Conditional Sentences':
      'How do conditional sentences work in English grammar?',
  'Direct and Indirect Speech':
      'What are the rules for converting direct speech to indirect speech in English?',
  'Phrasal Verbs':
      'Tell me about the usage and meanings of phrasal verbs in English.',
  'Clauses':
      'What are the different types of clauses and their functions in English?',
  'Modal Verbs': 'Could you explain the uses of modal verbs in English?',
  'Word Order': 'What is the correct word order in English sentences?'
};
