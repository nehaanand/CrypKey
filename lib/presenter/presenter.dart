import 'dart:convert';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/coinList/model/modelCoinsList.dart';
import 'package:flutter_app/apiCalling/restApis.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ScreenContract {

  void onLoginSuccess(ModelHomePage user);

  void onLoginError(String errorTxt);

  void onApiSuccessCoinsList(ModelCoinsList user);

  void onApiErrorCoinsList(String errorTxt);


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
      _view.onApiErrorCoinsList(error.toString());
    }

  }

}
