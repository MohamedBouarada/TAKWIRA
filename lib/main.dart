// @dart=2.9
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:takwira_front/animation/FadeAnimation.dart';
import 'package:takwira_front/screens/login.dart';
import 'package:takwira_front/screens/signup.dart';
import 'package:takwira_front/screens/homePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      
      home: HomePage(),
    );
  }
}