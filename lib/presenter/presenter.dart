import 'dart:convert';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'package:flutter_app/coinDetails/model/modelMarketChart.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/coinList/model/modelCoinsList.dart';
import 'package:flutter_app/apiCalling/restApis.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScreenContract {

  void onLoginSuccess(ModelHomePage user);

  void onLoginError(String errorTxt);

  void onApiSuccessCoinsList(List coins);
  void onApiSuccessCoinDetails(ModelCoinDetails coindetails);
  void onApiSuccessMarketChart(ModelMarketChart coindetails);

  void onApiErrorCoinsList(String errorTxt);
  void onApiErrorCoinsDetails(String errorTxt);
  void onApiErrorMarketChart(String errorTxt);
}

class ScreenPrsenter {
  ScreenContract _view;
  MobileRestDatasource api = new MobileRestDatasource();

  ScreenPrsenter(this._view);

  doLogin(String username) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await api.login(username);
      _view.onLoginSuccess(user);
    } on Exception catch(error) {
      _view.onLoginError(error.toString());
    }
  }

  coinsList() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = await api.coinslist();
      _view.onApiSuccessCoinsList(user);
    } on Exception catch(error) {
      print(error);
      _view.onApiErrorCoinsList(error.toString());
    }
  }

  coinsDetails(String coinID) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var coindetails = await api.coinsDetails(coinID);
      _view.onApiSuccessCoinDetails(coindetails);
    } on Exception catch(error) {
      print(error);
      _view.onApiErrorCoinsDetails(error.toString());
    }
  }
  marketChart(String coinID,String currency,String noOfDays) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var marketChart = await api.marketChart(coinID,currency,noOfDays);
      _view.onApiSuccessMarketChart(marketChart);
    } on Exception catch(error) {
      print(error);
      _view.onApiErrorMarketChart(error.toString());
    }
  }
}
