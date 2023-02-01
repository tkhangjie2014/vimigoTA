import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vimigota/homepage.dart';
import 'package:vimigota/onboarding.dart';

var initScreen = 0 ;

Future main() async{

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = (await prefs.getInt("initScreen"))!;
  await prefs.setInt("initScreen", 1);
  log('initScreen ${initScreen}');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'User Attendance',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: initScreen == 1 ? "first" : "/",
      routes: {
        '/': (context) => const HomePage(),
        "first": (context) => const OnBoardingScreen(),
      },
      //home: const OnBoardingScreen(),
      //const HomePage(),
    );
  }
}

