import 'dart:core';

class ModelCurrencies {
  String currencyName,currencyValue;


  ModelCurrencies({this.currencyName, this.currencyValue});

  ModelCurrencies.fromJson(Map<String, dynamic> json) {
    currencyName = json['currencyName'];
    currencyValue = json['currencyValue'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['currencyName'] = this.currencyName;
    data['currencyValue'] = this.currencyValue;
    return data;
  }
}
//class ModelCurrencies {
//
//
//  String currencyName,currecnyValue;
//
//  ModelCurrencies(this.currencyName,this.currecnyValue);
//
//  ModelCurrencies.map(dynamic obj,dynamic obj1) {
//
//    this.currencyName = obj1;
//    this.currecnyValue = obj;
//  }
//  String get _currencyName => currencyName;
//  String get _currecnyValue => currecnyValue;
//
//  Map<String, dynamic> toMap() {
//    var map = new Map<String, dynamic>();
//    map["_currencyName"] = currencyName;
//    map["_currecnyValue"] = currecnyValue;
//    return map;
//  }
//}