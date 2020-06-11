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
import 'package:flutter_tags/flutter_tags.dart';

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
  final GlobalKey<TagsState> _tagStateKey = GlobalKey<TagsState>();
  List _items = [];
  double _fontSize = 14;

  @override
  void initState() {
    super.initState();
    // if you store data on a local database (sqflite), then you could do something like this

//    dbCon.getCoinsData().then((items){
//      _items = items;
//      setState(() {
//
//      });

//    });
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
        body: Column(
          children: <Widget>[
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
                    controller: currencyTextController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Currency Name'),
                  ),
                  suggestionsCallback: (pattern) async {
                    return await dbCon.filterCurrencies(pattern);
                  },
                  itemBuilder: (context, suggestion) {
                    return ListTile(
                      title: Text(suggestion['currencyName']),
                    );
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
                    setState(() {
                      _items.add(suggestion['symbol']);
                      print("items " + _items.toString());
                    });
                  },
                )),
            Container(
                margin: EdgeInsets.only(top: 10.0),
                child: Tags(
                  key: _tagStateKey,
//              textField: TagsTextField(
//                textStyle: TextStyle(fontSize: _fontSize),
//                constraintSuggestion: true,
//                suggestions: [],
//                onSubmitted: (String str) {
//                  // Add item to the data source.
//                  setState(() {
//                    // required
//                    _items.add(str);
//                  });
//                },
//              ),

                  itemCount: ((_items.length == 0 || _items == null)
                      ? 0
                      : _items.length), // required
                  itemBuilder: (int index) {
                    final item = _items[index];

                    return Expanded(
                        child:Row(

                            mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children:<Widget>[ ItemTags(
                              alignment:MainAxisAlignment.start,
                              // Each ItemTags must contain a Key. Keys allow Flutter to
                              // uniquely identify widgets.
                              key: Key(index.toString()),
                              index: index,
                              // required
                              title: item,
//              active: item.active,
//              customData: item.customData,
                              textStyle: TextStyle(fontSize: _fontSize),
//                  combine: ItemTagsCombine.withTextBefore,
//              image: ItemTagsImage(
//                  image: AssetImage("img.jpg") // OR NetworkImage("https://...image.png")
//              ), // OR null,
//                  icon: ItemTagsIcon(
//                    icon: Icons.add,
//                  ),
                              // OR null,
                              removeButton: ItemTagsRemoveButton(
                                onRemoved: () {
                                  // Remove the item from the data source.
                                  setState(() {
                                    // required
                                    _items.removeAt(index);
                                  });
                                  //required
                                  return true;
                                },
                              ),
                              // OR null,
                              onPressed: (item) => print(item),
                              onLongPressed: (item) => print(item),
                            )]));
                  },
                )),
            Builder(
                builder: (context) => Container(
                    height: 50.0,
                    margin: EdgeInsets.only(left: 10.0, right: 10.0, top: 50.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: MaterialButton(
                          color: const Color(0xFF729dc0),
                          child: new Text(
                            'Save Preferences',
                            style:
                                TextStyle(color: Colors.white, fontSize: 16.0),
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

  _getAllItem() {
    List<Item> lst = _tagStateKey.currentState?.getAllItem;
    if (lst != null)
      lst.where((a) => a.active == true).forEach((a) => print(a.title));
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
