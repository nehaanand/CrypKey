import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'file:///D:/neha/HybridWorkspace/CrypKey/lib/loginRegister/loginRegister.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/database_helper.dart';


class SplashScreenPage extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage> implements ScreenContract  {
  var currentDateTime=0;
  var coinListInsertionDateTime=0;
  bool _loded = false;
  DatabaseHelper dbCon = new DatabaseHelper();
  // bool _load = false;

  final routes = <String, WidgetBuilder>{
    Login1.tag: (context) => Login1(),
  };


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

  }


  @override
  void initState() {
    super.initState();
    setState(() {
      ScreenPrsenter _presenter;

      _presenter = new ScreenPrsenter(this);

      _presenter.coinsList();
    });

    currentDateTime=new DateTime.now().millisecondsSinceEpoch;
    print(currentDateTime);


    new Future.delayed(const Duration(seconds: 3), () {

//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (BuildContext context) => new Login1()));

    });
  }

  @override
  void onLoginSuccess(ModelHomePage user) {

  }

  @override
  void onApiErrorCoinsList(String errorTxt) {

  }

  @override
  void onApiSuccessCoinsList(List coins) {
    _loded = true;

//
      dbCon.syncCoinData(coins).then((value){

        coinListInsertionDateTime=new DateTime.now().millisecondsSinceEpoch;
      Navigator.of(context).pushReplacement(
          new MaterialPageRoute(builder: (BuildContext context) => new Login1()));
      });



  }

  @override
  void onLoginError(String errorTxt) {

  }

  @override
  void onApiSuccessCoinDetails(ModelCoinDetails coindetails) {
  }

  @override
  void onApiErrorCoinsDetails(String errorTxt) {

  }
}