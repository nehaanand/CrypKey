import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/coinDetails/coinDetails.dart';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'package:flutter_app/coinDetails/model/modelMarketChart.dart';
import 'package:flutter_app/database_helper.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserProfile extends StatefulWidget {
  static String tag = 'user-profile-page';

  @override
  UserProfileState createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> implements ScreenContract {
  double height = 0.0, width = 0.0;
  bool _loded = false;
  List _searchResult = [];
  List _userDetails = [];
  final TextEditingController currencyTextController = TextEditingController();
  final TextEditingController languageTextController = TextEditingController();
  final TextEditingController coinTextController = TextEditingController();
  final databaseReference = Firestore.instance;

  DatabaseHelper dbCon = new DatabaseHelper();
  TextEditingController searchController = new TextEditingController();

  final scaffoldKey = new GlobalKey<ScaffoldState>();
  List answer_rfq_list = new List();
  Future<List> list1;
  final routes = <String, WidgetBuilder>{
    CoinDetails.tag: (context) => CoinDetails(),
  };
  AutoCompleteTextField searchTextField;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return MaterialApp(
      title: 'Crypkey',
      theme: ThemeData(
        primaryColor: const Color(0xFF006994),
      ),
      home: new Scaffold(
        key: scaffoldKey,
        appBar: AppBar(
          title: Text('Coins List'),
        ),
//        body: (searchController.text.isEmpty)
//            ? FutureBuilder<List>(
//          future: dbCon.getCoinsData(),
//          initialData: List(),
//          builder: (context, snapshot) {
//            return snapshot.hasData
//                ? new Column(children: <Widget>[
//              Container(
//                color: Theme.of(context).primaryColor,
//                child: new Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new Card(
//                    child: new ListTile(
//                      leading: new Icon(Icons.search),
//                      title: new TextField(
//                        controller: searchController,
//                        decoration: new InputDecoration(
//                            hintText: 'Search',
//                            border: InputBorder.none),
//                        onChanged: onSearchTextChanged,
//                      ),
//                      trailing: new IconButton(
//                        icon: new Icon(Icons.cancel),
//                        onPressed: () {
//                          searchController.clear();
//                          onSearchTextChanged('');
//                        },
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              new Expanded(
//                  child: ListView.builder(
//                      itemBuilder:
//                          (BuildContext context, int position) {
//                        return GestureDetector(
//                            child: Card(
//                                child: ListTile(
////                                                leading: Image.asset(
////                                                    "assets/loc.png"),
//                                    title: Text(snapshot
//                                        .data[position].row[1]),
//                                    trailing: Text(snapshot
//                                        .data[position].row[2]))),
//                            onTap: () {
//                              Scaffold.of(context).showSnackBar(
//                                  SnackBar(
//                                      content: Text(snapshot
//                                          .data[position].row[0])));
//
//                              Navigator.of(context).pushReplacement(
//                                  new MaterialPageRoute(
//                                      builder: (BuildContext
//                                      context) =>
//                                      new CoinDetails(
//                                          coinID: snapshot
//                                              .data[position]
//                                              .row[0])));
//                            });
//                      },
//                      itemCount: 10)),
//
////                        child: ListView.builder(
////                      itemCount: snapshot.data.length,
////
////                      itemBuilder: (_, int position) {
////                        final item = snapshot.data[position].toString();
////                        //get your item data here ...
////                        print("clickeditem "+item);
////                        return Card(
////                            child: ListTile(
////                                leading: Image.asset("assets/loc.png"),
////                                title: Text(snapshot.data[position].row[1]),
////                                trailing:
////                                    Text(snapshot.data[position].row[2])));
////                      },
////                    )
//
////                    ),
//              Container(
//                  padding: EdgeInsets.all(5.0),
//                  height: 68.0,
//                  color: const Color(0xFF006994),
//                  child: Row(
//                    mainAxisAlignment:
//                    MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Container(
//                          padding:
//                          EdgeInsets.only(top: 5.0, left: 20.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.home,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "HOME",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                      Container(
//                          padding:
//                          EdgeInsets.only(top: 5.0, left: 10.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.add,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "ADD",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                      Container(
//                          padding: EdgeInsets.only(
//                              top: 5.0, left: 10.0, right: 10.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.graphic_eq,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "MARKETS",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                    ],
//                  )),
//            ])
//                : Center(
//              child: CircularProgressIndicator(),
//            );
//          },
//        )
//            : FutureBuilder<List>(
//          future: dbCon.filterList(searchController.text),
//          initialData: List(),
//          builder: (context, snapshot) {
//            return snapshot.hasData
//                ? new Column(children: <Widget>[
//              Container(
//                color: Theme.of(context).primaryColor,
//                child: new Padding(
//                  padding: const EdgeInsets.all(8.0),
//                  child: new Card(
//                    child: new ListTile(
//                      leading: new Icon(Icons.search),
//                      title: new TextField(
//                        controller: searchController,
//                        decoration: new InputDecoration(
//                            hintText: 'Search',
//                            border: InputBorder.none),
//                        onChanged: onSearchTextChanged,
//                      ),
//                      trailing: new IconButton(
//                        icon: new Icon(Icons.cancel),
//                        onPressed: () {
//                          searchController.clear();
//                          onSearchTextChanged('');
//                        },
//                      ),
//                    ),
//                  ),
//                ),
//              ),
//              new Expanded(
//                  child: ListView.builder(
//                    itemCount: snapshot.data.length,
//                    itemBuilder: (_, int position) {
//                      final item = snapshot.data[position];
//                      //get your item data here ...
//                      return Card(
//                          child: ListTile(
////                                      leading: Image.asset("assets/loc.png"),
//                              title:
//                              Text(snapshot.data[position].row[1]),
//                              trailing: Text(
//                                  snapshot.data[position].row[2])));
//                    },
//                  )),
//              Container(
//                  padding: EdgeInsets.all(5.0),
//                  height: 68.0,
//                  color: const Color(0xFF006994),
//                  child: Row(
//                    mainAxisAlignment:
//                    MainAxisAlignment.spaceBetween,
//                    children: <Widget>[
//                      Container(
//                          padding:
//                          EdgeInsets.only(top: 5.0, left: 20.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.home,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "HOME",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                      Container(
//                          padding:
//                          EdgeInsets.only(top: 5.0, left: 10.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.add,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "ADD",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                      Container(
//                          padding: EdgeInsets.only(
//                              top: 5.0, left: 10.0, right: 10.0),
//                          child: Column(children: <Widget>[
//                            Icon(
//                              Icons.graphic_eq,
//                              color: Colors.white,
//                              size: 30.0,
//                              semanticLabel: 'Password',
//                            ),
//                            Container(
//                                padding: EdgeInsets.only(top: 5.0),
//                                child: Text(
//                                  "MARKETS",
//                                  style: TextStyle(
//                                      fontSize: 14.0,
//                                      color: Colors.white),
//                                ))
//                          ])),
//                    ],
//                  )),
//            ])
//                : Center(
//              child: CircularProgressIndicator(),
//            );
//          },
//        ),
        body: Column(
          children: <Widget>[
            Container(
                height: 50.0,

                margin: EdgeInsets.only(top: 20.0, left: 10.0, right: 10.0),
                padding: EdgeInsets.all(0),
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: true,
//                    style: TextStyle(color: Colors.black54, fontSize: 16.0),

                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                        color: Colors.black38),
                    controller: currencyTextController,
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          ),
                        hintText: 'Currency Name'),
                  ),
                  suggestionsCallback: (pattern) async {
                    if(currencyTextController.text.length!=0){
                    return await dbCon.filterCurrencies(pattern);
                  }},
                  itemBuilder: (context, suggestion) {
                    return GestureDetector(
                        onTap: () {
//                        print("sugg " + suggestion['currencyName']);
                        },
                        child: ListTile(
                          title: Text(suggestion['currencyName']),
                        ));
                  },
                  onSuggestionSelected: (suggestion) {
                    currencyTextController.text = suggestion['currencyName'];
                    print("sugg " + suggestion['currencyName']);
                    setState(() {});
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                height: 50.0,
                child: TypeAheadField(

                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                        color: Colors.black38),
                    controller: languageTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Language'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await dbCon.filterLanguages(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['lang']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    languageTextController.text = suggestion['lang'];
                    print("sugg " + suggestion['lang']);
                    setState(() {});
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: 10.0, left: 10.0, right: 10.0),
                height: 50.0,
                child: TypeAheadField(
                  textFieldConfiguration: TextFieldConfiguration(
                    autofocus: false,
                    style: DefaultTextStyle.of(context).style.copyWith(
                        fontStyle: FontStyle.normal,
                        fontSize: 18.0,
                        color: Colors.black38),
                    controller: coinTextController,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'Coin Name'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await dbCon.filterCoins(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['name']),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    coinTextController.text = suggestion['name'];
                    print("sugg " + suggestion['name']);
                    setState(() {});
                  },
                )),

            Builder(
                builder: (context) => Container(
                    height: 50.0,
                    margin: EdgeInsets.only(
                        left: 10.0,
                        right: 10.0,
                        top: 50.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          color: const Color(
                              0xFF729dc0),
                          child: new Text(
                            'Save Preferences',
                            style: TextStyle(
                                color: Colors
                                    .white,
                                fontSize: 16.0),
                          ),
                          onPressed: () async {
                            setState(() {});

                          },
                        ))))
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
//    if (text.isEmpty) {
    setState(() {});
//      return;
//    }
//    dbCon.filterList(text);
//    _userDetails.forEach((userDetail) {
//      if (userDetail.firstName.contains(text) || userDetail.lastName.contains(text))
//        _searchResult.add(userDetail);
//    });

    setState(() {});
  }
//  void savePreferences() async {
//
//        databaseReference.collection("Users").add(
//            {
//              'name': nameController.text,
//              'email': emailController.text,
//              'mobileno': mobileController.text,
//              'password': encdata,
//              'username': userNameController.text,
//            });
//        Fluttertoast.showToast(
//            msg: "Registered Successfully",
//            toastLength: Toast.LENGTH_LONG,
//            gravity: ToastGravity.BOTTOM,
//            timeInSecForIosWeb: 3,
//            backgroundColor: Colors.black,
//            textColor: Colors.white,
//            fontSize: 14.0);
//
//
//
//    _formKey1.currentState.reset();
//  }

  Future<List<dynamic>> getCurrencies() {
    return dbCon.getCurrency();
  }

  @override
  void onApiErrorCoinsList(String errorTxt) {
    print("error" + errorTxt.toString());

    // TODO: implement onApiErrorCoinsList
  }

  @override
  void onLoginSuccess(ModelHomePage user) {}

  @override
  void onApiSuccessCoinDetails(ModelCoinDetails coindetails) {} //  @override
//  void onApiSuccessCoinsList(String errorTxt) {
//    // TODO: implement onApiErrorCoinsList
//  }
  @override
  void onLoginError(String errorTxt) {
    // TODO: implement onLoginError
  }

  @override
  void onApiSuccessCoinsList(List coins) {
    _loded = true;
//    print("success " + coins.length.toString());
//
//    for (int i = 0; i < coins.length; i++) {
//
//      dbCon.addCoins(coins[i]);
//
//      answer_rfq_list.add(coins[i]);
//    }

//    print("success " + dbCon.getAllUser().toString());
//for(int i=0;i<dbCon.getAllUser().toString().length;i++){

//  print("success " + dbCon.getAllUser().toString().length.toString());

//}
  }

  @override
  void onApiErrorCoinsDetails(String errorTxt) {}

  @override
  void onApiSuccessMarketChart(ModelMarketChart coindetails) {}

  @override
  void onApiErrorMarketChart(String errorTxt) {}

  @override
  void onApiSuccessCurrenciesList(List coins) {}

  @override
  void onApiErrorCurrenciesList(String errorTxt) {}

//  @override
//  void onLoginSuccess(String errorTxt) {
//    // TODO: implement onLoginError
//  }

}
