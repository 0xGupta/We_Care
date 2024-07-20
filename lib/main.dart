import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:we_care/signup_page.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'package:we_care/firebase_options.dart';
import 'package:we_care/learncenter.dart';
import 'package:we_care/questions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupPage(),
        '/learncenter': (context) => LearnCenter(),
        '/QuestionnairePage': (context) => QuestionnairePage(),
      },
    );
  }
}
