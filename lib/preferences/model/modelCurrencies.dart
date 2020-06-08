import 'dart:core';
class ModelCurrencies {


  String currencyName,currecnyValue;

  ModelCurrencies(this.currencyName,this.currecnyValue);

  ModelCurrencies.map(dynamic obj,dynamic obj1) {

    this.currencyName = obj1;
    this.currecnyValue = obj;
  }
  String get _currencyName => currencyName;
  String get _currecnyValue => currecnyValue;

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();
    map["_currencyName"] = currencyName;
    map["_currecnyValue"] = currecnyValue;
    return map;
  }
}