import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<MyApp> {
  // bool _load = false;


//  final routes = <String, WidgetBuilder>{
//    WelcomeScreen.tag: (context) => WelcomeScreen(),
//  };




  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,   //interaction with view model and livedata,viewmodel,kivedata(mediator,transformers),handling lifecycle,
//        appBar: AppBar(
//          title: Text('Registration'),
//        ),
        body: Builder(
          builder: (context) => new Center(
            child: new Image.asset('assets/header.png'),
          ),
        ),
      ),
    );

  }

  @override
  void initState() {
    super.initState();
    new Future.delayed(const Duration(seconds: 3), () {

//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (BuildContext context) => new WelcomeScreen()));

    });
  }
}