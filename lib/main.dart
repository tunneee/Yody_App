/*
 * MainPage
 * *
 * Feature:
 * Initialize Firebase
 * Root Page of App
 * hidden Debug banner
 * Primary Color grey 
 */
import 'package:clothing_store_app_ui/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //
  // ***
  // Firebase Root Config
  // ***
  //
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yody',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: MainPage(),
    );
  }
}
