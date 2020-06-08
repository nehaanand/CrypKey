import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter_app/loginRegister/splashscreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: SplashScreenPage()
    );
  }

}