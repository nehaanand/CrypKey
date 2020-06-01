import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class NetworkUtil {
  // next three lines makes this class a Singleton
  static NetworkUtil _instance = new NetworkUtil.internal();

  NetworkUtil.internal();

  factory NetworkUtil() => _instance;

  final JsonDecoder _decoder = new JsonDecoder();

//  Future<dynamic> get(String uri) async {
//    try {
//      return await http.get(Uri.encodeFull(uri)).then((http.Response response) {
//        final String res = response.body;
//        final int statusCode = response.statusCode;
//
//        if (statusCode < 200 || statusCode > 400 || json == null) {
//          throw new Exception("Error while fetching data");
//        }
//
//        return _decoder.convert(res);
//      });
//    }
//    catch(error){
//      print(error.toString());
//    }
//  }
  Future<dynamic> get(String url) {
    return http.get(Uri.encodeFull(url)).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;
      print(response.body.runtimeType);

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

  Future<dynamic> post(String url, {Map headers, body}) async {
    return await http.post(Uri.encodeFull(url), body: body, headers: {
      "Content-Type": "application/json"
    }).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      } else {}
      return _decoder.convert(res);
    });
  }
}
