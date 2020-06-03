import 'dart:convert' show utf8;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/coinDetails/model/modelCoinDetails.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/homePage/homeScreen.dart';
import 'package:flutter_app/coinList/coinList.dart';
import 'package:flutter_app/presenter/presenter.dart';
import 'package:flutter_app/homePage/modelHomePage.dart';

class CoinDetails extends StatefulWidget {
  final databaseReference = Firestore.instance;
  String coinID;
  static String tag = 'login1-page';
  final routes = <String, WidgetBuilder>{
    HomeScreen.tag: (context) => HomeScreen(),
    CoinList.tag: (context) => CoinList(),
//    NavigationDrawerDemo.tag: (context) => NavigationDrawerDemo(),
  };

  CoinDetails({Key key, @required this.coinID}) : super(key: key);

  State createState1() => new _CoinDetailsState();

  @override
  _CoinDetailsState createState() => _CoinDetailsState();
}

class _CoinDetailsState extends State<CoinDetails>
    with SingleTickerProviderStateMixin
    implements ScreenContract {
  TabController _tabController;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  List<Tab> tabList = List();
  String email;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;
  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();

  String privacy_policy_url, termsandconditionsurl;
  List SuppAppDashboardList = [];
  TextEditingController nameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController emailControllerLogin = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  TextEditingController passwordControllerLogin = new TextEditingController();
  TextEditingController userNameControllerLogin = new TextEditingController();
  TextEditingController confirmPasswordController = new TextEditingController();
  TextEditingController userNameController = new TextEditingController();

  double height = 0.0, width = 0.0;
  final databaseReference = Firestore.instance;

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'Details',
    ));
    tabList.add(new Tab(
      text: 'Profile',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    _loadCounter();
    super.initState();
  }

  _loadCounter() async {
    setState(() {
      ScreenPrsenter _presenter;

      _presenter = new ScreenPrsenter(this);

      _presenter.coinsDetails(widget.coinID);
//      print("size"+list1.toString().length.toString());
    });
  }

  String validateEmail(String value) {
    if (value.isEmpty)
      return 'Email can t be empty';
    else if (!EmailValidator.validate(emailController.text))
      return 'Enter Valid Email';
    else
      return null;
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false, //new line
        body: Container(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Container(
                  child: Text(
                widget.coinID,
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 22.0,
                    color: Colors.white,
                    fontStyle: FontStyle.italic),
              )),
            ),
            backgroundColor: Colors.transparent,
            body: new Card(
              child: new Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 0.0),
                child: new Center(
                    child: SingleChildScrollView(
                        // new line
                        child: Column(children: <Widget>[
//                          Container(
//                              margin: EdgeInsets.only(top: 10.0),
//                              padding: EdgeInsets.all(10.0),
//                              child: Text(
//                                "CrypKey",
//                                textAlign: TextAlign.center,
//                                style: TextStyle(
//                                    fontSize: 22.0,
//                                    color: Colors.white,
//                                    fontStyle: FontStyle.italic),
//                              )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      margin: EdgeInsets.all(10.0),
//                  height: 457.0,
//                  width: 320.0,
//                              decoration: new BoxDecoration(
//                                color: const Color(0xff000000).withOpacity(0.5),
//                              ),
                      child: Column(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.transparent,
                                  ),
                                  child: new TabBar(
                                      controller: _tabController,
                                      indicatorColor: Colors.white,
                                      labelStyle: TextStyle(
                                          fontSize: 18.0,
                                          fontStyle: FontStyle.italic),
                                      //For Selected tab

                                      indicatorSize: TabBarIndicatorSize.tab,
                                      indicatorWeight: 4,
                                      tabs: tabList),
                                ),
                                new Container(
                                  height: 500.0,
                                  child: new TabBarView(
                                    controller: _tabController,
                                    children: <Widget>[
                                      Form(
                                          key: _formKey2,
                                          child: Column(children: <Widget>[
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 20.0),
                                                padding: EdgeInsets.all(10.0),
                                                child: Text(
                                                  "Overview",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                      fontSize: 22.0,
                                                      color: Colors.white,
                                                      fontStyle:
                                                          FontStyle.italic),
                                                )),

                                            Container(
                                                child: Column(
                                              children: <Widget>[
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Text(
                                                            "Volume",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          )),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Text(
                                                            "Market Cap",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          ))
                                                    ]),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: <Widget>[
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Text(
                                                            "Rank",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          )),
                                                      Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  top: 0.0),
                                                          padding:
                                                              EdgeInsets.all(
                                                                  20.0),
                                                          child: Text(
                                                            "Circulating Supply",
                                                            textAlign: TextAlign
                                                                .center,
                                                            style: TextStyle(
                                                                fontSize: 18.0,
                                                                color: Colors
                                                                    .white,
                                                                fontStyle:
                                                                    FontStyle
                                                                        .normal),
                                                          ))
                                                    ])
                                              ],
                                            ))

//                                                    Builder(
//                                                        builder: (context) => Container(
//                                                            height: 50.0,
//                                                            margin: EdgeInsets.only(
//                                                                left: 10.0,
//                                                                right: 10.0,
//                                                                top: 10.0),
//                                                            child: SizedBox(
//                                                                width: double.infinity,
//                                                                child: MaterialButton(
//                                                                  color: Colors.green,
//                                                                  child: new Text(
//                                                                    'Sign In',
//                                                                    style: TextStyle(
//                                                                        color: Colors
//                                                                            .white,
//                                                                        fontSize: 16.0),
//                                                                  ),
//                                                                  onPressed: () async {
//                                                                    setState(() {});
//
//                                                                  },
//                                                                ))))
                                          ])),
                                      Form(
                                          key: _formKey1,
                                          child: Column(children: <Widget>[
                                            new Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                margin:
                                                    EdgeInsets.only(top: 0.0),
                                                child: TextFormField(
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        userNameController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 3.0,
                                                                  top: 8.0),
                                                          child: Icon(
                                                            Icons.keyboard,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'UserName',
                                                          ), // myIcon is a 48px-wide widget.
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText:
                                                            'UserName'))),
                                            new Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                child: TextFormField(
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      return null;
                                                    },
                                                    controller: nameController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 3.0,
                                                                  top: 8.0),
                                                          child: Icon(
                                                            Icons.keyboard,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'Name',
                                                          ), // myIcon is a 48px-wide widget.
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText: 'Name'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                    controller: emailController,
//                                            inputFormatters: [
//                                              WhitelistingTextInputFormatter(RegExp(
//                                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+"))
//                                            ],
                                                    keyboardType:
                                                        TextInputType.text,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      if (!EmailValidator
                                                          .validate(value)) {
                                                        return 'Invalid Email';
                                                      }
                                                      return null;
                                                    },
                                                    //                                            onSaved: (value) => email = value.trim(),

                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 3.0,
                                                                  top: 8.0),
                                                          child: Icon(
                                                            Icons.mail,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'Email',
                                                          ), // myIcon is a 48px-wide widget.
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText: 'Email'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                    inputFormatters: [
                                                      new LengthLimitingTextInputFormatter(
                                                          10),
                                                      WhitelistingTextInputFormatter
                                                          .digitsOnly,
                                                    ],
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      return null;
                                                    },
                                                    controller:
                                                        mobileController,
                                                    keyboardType:
                                                        TextInputType.text,
                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 3.0,
                                                                  top: 8.0),
                                                          child: Icon(
                                                            Icons.phone,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'Mobile No.',
                                                          ), // myIcon is a 48px-wide widget.
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText:
                                                            'Mobile No.'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                    controller:
                                                        passwordController,
                                                    obscureText: true,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }

                                                      return null;
                                                    },
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                            padding:
                                                                const EdgeInsetsDirectional
                                                                        .only(
                                                                    start: 3.0,
                                                                    top: 8.0),
                                                            child: (passwordController
                                                                        .text ==
                                                                    confirmPasswordController
                                                                        .text
                                                                ? Icon(
                                                                    Icons
                                                                        .lock_outline,
                                                                    color: Colors
                                                                        .white,
                                                                    size: 24.0,
                                                                    semanticLabel:
                                                                        'Confirm Password',
                                                                  )
                                                                : Icon(
                                                                    Icons
                                                                        .lock_open,
                                                                    color: Colors
                                                                        .red,
                                                                    size: 24.0,
                                                                    semanticLabel:
                                                                        'Confirm Password',
                                                                  ))),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText:
                                                            'Password'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                    controller:
                                                        confirmPasswordController,
                                                    obscureText: true,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      if (passwordController
                                                              .text !=
                                                          confirmPasswordController
                                                              .text) {
                                                        return 'Passwords does not match';
                                                      }
                                                      return null;
                                                    },
                                                    keyboardType: TextInputType
                                                        .visiblePassword,
                                                    decoration: InputDecoration(
                                                        alignLabelWithHint:
                                                            true,
                                                        labelStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintStyle: TextStyle(
                                                          fontSize: 17.0,
                                                          color: Colors.white,
                                                        ),
                                                        hintText: '',
                                                        prefixIcon: Padding(
                                                          padding:
                                                              const EdgeInsetsDirectional
                                                                      .only(
                                                                  start: 3.0,
                                                                  top: 8.0),
                                                          child: (passwordController
                                                                      .text ==
                                                                  confirmPasswordController
                                                                      .text
                                                              ? Icon(
                                                                  Icons
                                                                      .lock_outline,
                                                                  color: Colors
                                                                      .white,
                                                                  size: 24.0,
                                                                  semanticLabel:
                                                                      'Confirm Password',
                                                                )
                                                              : Icon(
                                                                  Icons
                                                                      .lock_open,
                                                                  color: Colors
                                                                      .red,
                                                                  size: 24.0,
                                                                  semanticLabel:
                                                                      'Confirm Password',
                                                                )), // myIcon is a 48px-wide widget.
                                                        ),
                                                        contentPadding:
                                                            EdgeInsets.all(2),
                                                        //  <- you can it to 0.0 for no space
                                                        border:
                                                            new UnderlineInputBorder(
                                                                borderSide:
                                                                    new BorderSide(
                                                          color: Colors.white,
                                                        )),
                                                        labelText:
                                                            'Confirm Password'))),
                                            Builder(
                                                builder: (context) => Container(
                                                    height: 50.0,
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        right: 10.0,
                                                        top: 10.0),
                                                    child: SizedBox(
                                                        width: double.infinity,
                                                        child: MaterialButton(
                                                          color: const Color(
                                                              0xFF729dc0),
                                                          child: new Text(
                                                            'Sign Up',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0),
                                                          ),
                                                          onPressed: () async {
                                                            bool isvalid =
                                                                EmailValidator
                                                                    .validate(
                                                                        emailController
                                                                            .text);
                                                          },
                                                        ))))
                                          ])),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ),
                        ],
                      ))
                ]))),
                decoration: new BoxDecoration(
                  color: const Color(0xff000000),
                ),
              ),
            ),
          ),
        ));
  }

  @override
  void onLoginSuccess(ModelHomePage user) {}

  @override
  void onApiErrorCoinsDetails(String errorTxt) {}

  @override
  void onApiErrorCoinsList(String errorTxt) {}

  @override
  void onApiSuccessCoinDetails(ModelCoinDetails coindetails) {
    print("SuccessCall");
  }

  @override
  void onApiSuccessCoinsList(List coins) {}

  @override
  void onLoginError(String errorTxt) {}
}
