import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/firstscreen.dart';
import 'package:flutter_app/firstscreenwithtabs.dart';

class SplashScreenPage extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> {
  // bool _load = false;

  final routes = <String, WidgetBuilder>{
    Login.tag: (context) => Login(),
    Login1.tag: (context) => Login1(),
  };
  // startTime() async {

  //   // var _duration = new Duration(seconds: 2);
  //   //     new Future.delayed(const Duration(seconds: 4));

  //   // return new Timer(_duration, navigationPage);
  // }

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;
    return MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Registration'),
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
    // return new Scaffold(
    //   body: new Center(
    //     child: new Image.asset('assets/splashimage.jpg'),

    //   ),

    // );
  }


  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {
      // Navigator.of(context)
      //   ..pop()
      //   ..pushNamed(/WelcomeScreen.tag);
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => new Login1()));

    });
  }
}