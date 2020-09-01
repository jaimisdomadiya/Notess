import 'package:FIREBASELOGIN/HomePage.dart';
import 'package:FIREBASELOGIN/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'SigninPage.dart';
import 'SignupPage.dart';

void main() =>  runApp(MyApp());

// First put jason file in android and ios
// use  gradle in android
// same ios
// yaml for flutter

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    return MaterialApp(
      title: 'Notes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: NoteList(),
      routes: <String, WidgetBuilder>{
        '/SigninPage': (BuildContext context) => SigninPage(),
        '/SignupPage': (BuildContext context) => SignupPage(),
        '/Profile': (BuildContext context) => Profile(),
        '/NoteList': (BuildContext context) => NoteList(),

      },
    );
  }
}
