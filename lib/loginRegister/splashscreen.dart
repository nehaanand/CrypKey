import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'file:///D:/neha/HybridWorkspace/CrypKey/lib/loginRegister/loginRegister.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/database_helper.dart';
import 'package:flutter_app/coinDetails/model/modelMarketChart.dart';
import 'dart:collection';

class SplashScreenPage extends StatefulWidget {
  static String tag = 'splash-page';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreenPage>
    implements ScreenContract {
  var currentDateTime = 0;
  var coinListInsertionDateTime = 0;
  bool _loded = false;
  DatabaseHelper dbCon = new DatabaseHelper();

  // bool _load = false;

  TextEditingController noOfDaysController = new TextEditingController();
  TextEditingController noOfEntriesOnGraphController =
      new TextEditingController();
  TextEditingController minutesInADayController = new TextEditingController();
  final routes = <String, WidgetBuilder>{
    Login1.tag: (context) => Login1(),
  };

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
//      _presenter.marketChart("01coin", "inr", "1");
    });

    currentDateTime = new DateTime.now().millisecondsSinceEpoch;
    print(currentDateTime);

    new Future.delayed(const Duration(seconds: 3), () {
//      Navigator.of(context).pushReplacement(
//          new MaterialPageRoute(builder: (BuildContext context) => new Login1()));
    });
  }

  @override
  void onLoginSuccess(ModelHomePage user) {}

  @override
  void onApiErrorCoinsList(String errorTxt) {}

  @override
  void onApiSuccessCoinsList(List coins) {
    _loded = true;

//
    dbCon.syncCoinData(coins).then((value) {
      coinListInsertionDateTime = new DateTime.now().millisecondsSinceEpoch;
      Navigator.of(context).pushReplacement(new MaterialPageRoute(
          builder: (BuildContext context) => new Login1()));
    });
  }

  @override
  void onLoginError(String errorTxt) {}

  @override
  void onApiSuccessCoinDetails(ModelCoinDetails coindetails) {}

  @override
  void onApiErrorCoinsDetails(String errorTxt) {}

  @override
  void onApiSuccessMarketChart(ModelMarketChart marketChart) {
    print("ModelMarketChart_Success");
    HashMap map = HashMap();
    noOfDaysController.text = "1";
    noOfEntriesOnGraphController.text = "10";
    int minutesInADay = int.parse(noOfDaysController.text) * 60 * 24;
    HashMap mapNoOfEntries = HashMap();

    double initialValue = 0 +
        minutesInADay / //  0+1440/10=144
            double.parse(noOfEntriesOnGraphController.text);
    var arr = [];

    HashMap mapGroupOfEntries = HashMap();

    for (int j = 0; j < int.parse(noOfEntriesOnGraphController.text); j++) {
      if (j == 0) {
        mapNoOfEntries.putIfAbsent(j, () => initialValue);
      } else {
        initialValue = initialValue +
            minutesInADay / //  0+1440/10=144
                double.parse(noOfEntriesOnGraphController.text);
        mapNoOfEntries.putIfAbsent(j, () => initialValue);
      }
    }
    print(mapNoOfEntries);

    try {
      for (int k = 0; k < mapNoOfEntries.length; k++) {
        for (int i = 0; i < marketChart.prices.length; i++) {
          var open = marketChart.prices[0][0];
          var close = marketChart.prices[marketChart.prices.length-1][0] + mapNoOfEntries[k];

          if (marketChart.prices[i][0] > open &&
              marketChart.prices[i][0] < close) {
            arr.add(marketChart.prices[i][0]);
          }
          print("open " + open.toString() + " close " + close.toString());
          print("frstgroup " + arr.toString());
        }
      }
    } catch (error) {
      print(error);
    }
  }

  @override
  void onApiErrorMarketChart(String errorTxt) {}
}
