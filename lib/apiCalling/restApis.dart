import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'package:flutter_app/coinDetails/model/modelMarketChart.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';
import 'package:flutter_app/commonFiles/network_util.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/coinList/model/modelCoinsList.dart';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';

class MobileRestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();

  Future<ModelHomePage> login(String empdetails) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    try {
      var url = Uri(
          scheme: 'http',
          host: 'tlog.grouptci.in',
          path: 'WebServices/TCIL_SuppApp_WebServices_Demo/SuppAppService.svc/getSuppAppOTP');

      var url1 = Uri.decodeComponent(url.toString());

      return _netUtil
          .post(url1, body: empdetails)
          .then((dynamic res) {
        print("errormess " + res["objAppResultStatus"]["MESSAGE"]);
        if (res["objAppResultStatus"]["STATUS"] == "VALIDATION" ||
            res["objAppResultStatus"]["STATUS"] == "ERROR") {
          throw new Exception(res["objAppResultStatus"]["MESSAGE"]);
        } else {
          return new ModelHomePage.map(res["objAppResultStatus"]);
        }
      });
    } catch (error) {
      print("abccc" + error);
    }
  }

  Future<List> coinslist() async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'api.coingecko.com',
          path: 'api/v3/coins/list');

      var url1 = Uri.decodeComponent(url.toString());

      return _netUtil
          .get(url1)
          .then((dynamic res) {

      List<dynamic> list = [];
        for(var i =0; i<res.length;i++){
          list.add(new ModelCoinsList.fromJson(res[i]));
        }


        return list ;
//        }
      });
    } catch (error) {
      print("abccc" + error);
    }
  }
  Future<ModelCoinDetails> coinsDetails(String coinID) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'api.coingecko.com',
          path: 'api/v3/coins/'+coinID);

      var url1 = Uri.decodeComponent(url.toString());

      return _netUtil
          .get(url1)
          .then((dynamic res) {
//
//        List<dynamic> list = [];
//        for(var i =0; i<res.length;i++){
//          list.add(new ModelCoinDetails.fromJson(res[i]));
//        }
        return ModelCoinDetails.fromJson(res) ;

      });
    } catch (error) {
      print("abccc" + error);
    }
  }
  Future<ModelMarketChart> marketChart(String coinID,String currency,String noOfDays) async {
    try {
      var url = Uri(
          scheme: 'https',
          host: 'api.coingecko.com',
          path: 'api/v3/coins/'+coinID+"/market_chart?vs_currency="+currency+"&days="+noOfDays);

      var url1 = Uri.decodeComponent(url.toString());

      return _netUtil
          .get(url1)
          .then((dynamic res) {
        return ModelMarketChart.fromJson(res) ;

      });
    } catch (error) {
      print("abccc" + error);
    }
  }

}
