import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/loginRegister/loginRegister.dart';

class HomeScreen extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // bool _load = false;

  final routes = <String, WidgetBuilder>{
    HomeScreen.tag: (context) => HomeScreen(),
  };


  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Home Screen'),
        ),
        body: Builder(
          builder: (context) => new Container(
            decoration: BoxDecoration(

              image: DecorationImage(
                  image: AssetImage('assets/background.jpeg'),
                  fit: BoxFit.fill),
            ),
          ),
        ),
      ),
      routes: routes,
    );

  }


  @override
  void initState() {
    super.initState();

  }
}