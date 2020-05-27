import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/coinList/model/modelCoinsList.dart';

class CoinList extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _CoinListState createState() => _CoinListState();
}

class _CoinListState extends State<CoinList> implements ScreenContract{
  // bool _load = false;

  final routes = <String, WidgetBuilder>{
    CoinList.tag: (context) => CoinList(),
  };

  @override
  void initState() {
    super.initState();

    _loadCounter();
  }


  _loadCounter() async {

    setState(() {
      ScreenPrsenter _presenter;

      _presenter = new ScreenPrsenter(this);


        _presenter.coinsList();

    });
  }

  @override
  Widget build(BuildContext context) {

    double width=MediaQuery.of(context).size.width;
    double height=MediaQuery.of(context).size.height;


    return MaterialApp(
      home: new Scaffold(
        resizeToAvoidBottomPadding: false,
        appBar: AppBar(
          title: Text('Coins List'),
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
  void onApiErrorCoinsList(String errorTxt) {
    // TODO: implement onApiErrorCoinsList
  }

  @override
  void onLoginSuccess(ModelHomePage user) {

  } //  @override
//  void onApiSuccessCoinsList(String errorTxt) {
//    // TODO: implement onApiErrorCoinsList
//  }
  @override
  void onLoginError(String errorTxt) {
    // TODO: implement onLoginError
  }

  @override
  void onApiSuccessCoinsList(ModelCoinsList user) {

  }

//  @override
//  void onLoginSuccess(String errorTxt) {
//    // TODO: implement onLoginError
//  }

}