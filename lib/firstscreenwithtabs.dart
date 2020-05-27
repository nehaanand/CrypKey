import 'dart:convert' show utf8;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:crypto/crypto.dart' as crypto;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_app/homePage/homeScreen.dart';
import 'package:flutter_app/coinList/coinList.dart';

class Login1 extends StatefulWidget {
  final databaseReference = Firestore.instance;

  static String tag = 'login1-page';
  final routes = <String, WidgetBuilder>{

    HomeScreen.tag: (context) => HomeScreen(),
    CoinList.tag: (context) => CoinList(),
//    NavigationDrawerDemo.tag: (context) => NavigationDrawerDemo(),
  };

  Login1({Key key}) : super(key: key);

  State createState1() => new _LoginState1();

  @override
  _LoginState1 createState() => _LoginState1();
}

class _LoginState1 extends State<Login1> with SingleTickerProviderStateMixin {
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
//    List<Map<String, IconData>> _categories = [
//      {
//        'name': 'Sports',
//        'icon': Icons.lock_outline,
//      },
//      {
//        'name': 'Politics',
//        'icon': Icons.lock_open,
//      },
//
//    ];

    tabList.add(new Tab(
      text: 'SIGN IN',
    ));
    tabList.add(new Tab(
      text: 'SIGN UP',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
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

  void validateAndSave() {
    if (_formKey1.currentState.validate()) {
//    If all data are correct then save data to out variables
      _formKey1.currentState.save();
      createRecord();
    } else {
//    If all data are not valid then start auto validation.
      setState(() {
        _autoValidate = true;
      });
    }
  }


  void userLogin(String username, String password) {
    if (_formKey2.currentState.validate()) {

          _formKey2.currentState.save();
          String encdata = generateMd5(password);

          databaseReference
              .collection("Users")
              .where("username", isEqualTo: username)
              .where("password", isEqualTo: encdata)
              .getDocuments()
              .then((value) {
            if (value.documents.length == 0) {
              Fluttertoast.showToast(
                  msg: "Invalid Credentials",
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 3,
                  backgroundColor: Colors.black,
                  textColor: Colors.white,
                  fontSize: 14.0);
            } else {
              value.documents.forEach((result) {
                Fluttertoast.showToast(
                    msg: "Login Successful",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 3,
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    fontSize: 14.0).then((value){
                  Navigator.of(context).pushReplacement(
                      new MaterialPageRoute(builder: (BuildContext context) => new CoinList()));
                });

              });
            }
          });



//      _formKey2.currentState.save();
//      String encdata = generateMd5(password);
//
//      databaseReference
//          .collection("Users")
//          .where("username", isEqualTo: username)
//          .where("password", isEqualTo: encdata)
//          .getDocuments()
//          .then((value) {
//        if (value.documents.length==0) {
//          Fluttertoast.showToast(
//              msg: "Invalid Credentials",
//              toastLength: Toast.LENGTH_LONG,
//              gravity: ToastGravity.BOTTOM,
//              timeInSecForIosWeb: 3,
//              backgroundColor: Colors.black,
//              textColor: Colors.white,
//              fontSize: 14.0);
//        }
//        else {
//          value.documents.forEach((result) {
//              Fluttertoast.showToast(
//                  msg: "Login Successful",
//                  toastLength: Toast.LENGTH_LONG,
//                  gravity: ToastGravity.BOTTOM,
//                  timeInSecForIosWeb: 3,
//                  backgroundColor: Colors.black,
//                  textColor: Colors.white,
//                  fontSize: 14.0);
//
//          });
//        }
//        });
    } else {
      setState(() {
        _autoValidate = true;
      });
    }
  }

  void createRecord() async {
    databaseReference
        .collection('Users')
        .where('username', isEqualTo: userNameController.text)
        .limit(1)
        .getDocuments()
        .then((value) {
      if (value.documents.length == 0) {
        print("encdata " + generateMd5(passwordController.text));
        String encdata = generateMd5(passwordController.text);
      databaseReference.collection("Users").add(
            {
              'name': nameController.text,
              'email': emailController.text,
              'mobileno': mobileController.text,
              'password': encdata,
              'username': userNameController.text,
            });
        Fluttertoast.showToast(
            msg: "Registered Successfully",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 3,
            backgroundColor: Colors.black,
            textColor: Colors.white,
            fontSize: 14.0);


      }
      else
        {
          Fluttertoast.showToast(
              msg: "UserName Already taken",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              timeInSecForIosWeb: 3,
              backgroundColor: Colors.black,
              textColor: Colors.white,
              fontSize: 14.0);
        }
      });
    _formKey1.currentState.reset();
  }

  String generateMd5(String input) {
    return crypto.md5.convert(utf8.encode(input)).toString();
  }

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
        resizeToAvoidBottomInset: false, //new line
        body: Container(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: new Card(
              child: new Container(
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.only(top: 20.0),
                child: new Center(
                    child: SingleChildScrollView(
                        // new line
                        child: Column(children: <Widget>[
                  Container(
                      margin: EdgeInsets.only(top: 50.0),
                      padding: EdgeInsets.all(20.0),
                      child: Text(
                        "CrypKey",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 22.0,
                            color: Colors.white,
                            fontStyle: FontStyle.italic),
                      )),
                  Container(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                      margin: EdgeInsets.all(10.0),
//                  height: 457.0,
//                  width: 320.0,
                      decoration: new BoxDecoration(
                        color: const Color(0xff77a3c8).withOpacity(0.5),
//                                  image: new DecorationImage(
//                                    fit: BoxFit.cover,
//                                    colorFilter: new ColorFilter.mode(
//                                        Colors.black.withOpacity(0.1),
//                                        BlendMode.dstATop),
//                                    image: AssetImage('assets/background.jpeg'),
//                                  ),
                      ),
                      child: Column(
                        children: <Widget>[
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.center,
//                          children: <Widget>[
//                            Text(
//                              "CrypKey",
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  fontSize: 22.0,
//                                  color: Colors.white,
//                                  fontStyle: FontStyle.italic),
//                            ),
//                          ],
//                        ),
//                      new Positioned(
//                        top: 310,
//                        child:
                          new Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.transparent,
                                  ),
//                                color: const Color(0xff77a3c8).withOpacity(0.5),
//                                  color: Theme.of(context).primaryColor),
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
                                            new Container(
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                margin:
                                                    EdgeInsets.only(top: 10.0),
                                                child: TextFormField(
                                                    controller:
                                                        userNameControllerLogin,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      return null;
                                                    },
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
                                                            Icons.person,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'Username',
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
                                                            'Username'))),
                                            Container(
                                                margin:
                                                    EdgeInsets.only(top: 20.0),
                                                padding: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                child: TextFormField(
                                                    controller:
                                                        passwordControllerLogin,
                                                    validator: (value) {
                                                      if (value.isEmpty) {
                                                        return 'Value Required';
                                                      }
                                                      return null;
                                                    },
                                                    obscureText: true,
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
                                                          child: Icon(
                                                            Icons.lock,
                                                            color: Colors.white,
                                                            size: 24.0,
                                                            semanticLabel:
                                                                'Password',
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
                                                            'Password'))),
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
                                                            'Sign In',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white,
                                                                fontSize: 16.0),
                                                          ),
                                                          onPressed: () async {
                                                            setState(() {});
                                                            userLogin(
                                                                userNameControllerLogin
                                                                    .text,
                                                                passwordControllerLogin
                                                                    .text);
                                                          },
                                                        ))))
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
                                                          ))
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

//                                                    if (emailController.text.length ==
//                                                        0) {
//                                                      String error = "Email Can't be empty";
//
//                                                      scaffoldKey.currentState.showSnackBar(
//                                                          new SnackBar(
//                                                              duration:
//                                                              const Duration(milliseconds: 500),
//                                                              content: new Text(error)));
//
//                                                    } else if (!isvalid) {
//                                                      Fluttertoast.showToast(
//                                                          msg: "Invalid Email",
//                                                          toastLength: Toast.LENGTH_LONG,
//                                                          gravity: ToastGravity.BOTTOM,
//                                                          timeInSecForIosWeb: 3,
//                                                          backgroundColor: Colors.black,
//                                                          textColor: Colors.white,
//                                                          fontSize: 14.0);
//                                                    }
//                                                    else
//                                                    createRecord();v
                                                            validateAndSave();
                                                          },
                                                        ))))
                                          ])),
                                    ],
//                            children: tabList.map((Tab tab) {
//                              _getPage(tab);
//                            }).toList(),
                                  ),
                                )
                              ],
                            ),
                          ),

//                                  Row(
//                                    mainAxisAlignment:
//                                    MainAxisAlignment.spaceEvenly,
//                                    children: <Widget>[
//                                      Container(
//                                          padding: EdgeInsets.fromLTRB(
//                                              0, 20, 0, 0),
//                                          child: Text(
//                                            "SIGN IN",
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                fontSize: 22.0,
//                                                color: Colors.white,
//                                                fontStyle: FontStyle.italic),
//                                          )),
//                                      Container(
//                                          padding: EdgeInsets.fromLTRB(
//                                              0, 20, 0, 0),
//                                          child: Text(
//                                            "SIGN UP",
//                                            textAlign: TextAlign.center,
//                                            style: TextStyle(
//                                                fontSize: 22.0,
//                                                color: Colors.white,
//                                                fontStyle: FontStyle.italic),
//                                          )),
//                                    ],
//                                  ),
//                            Container(
//                                margin: EdgeInsets.only(top: 70.0),
//                                padding: EdgeInsets.all(10.0),
//                                child: TextFormField(
//                                    keyboardType: TextInputType.text,
//                                    decoration: InputDecoration(
//                                        alignLabelWithHint: true,
//                                        labelStyle: TextStyle(
//                                          fontSize: 17.0,
//                                          color:Colors.white,
//                                        ),
//                                        hintStyle: TextStyle(
//                                          fontSize: 17.0,
//                                          color:Colors.white,
//                                        ),
//                                        hintText: '',
//                                        prefixIcon: Image.asset(
//                                            'assets/loc.png'),
//                                        contentPadding:
//                                        EdgeInsets.all(2),
//                                        //  <- you can it to 0.0 for no space
//                                        border: new UnderlineInputBorder(
//                                            borderSide: new BorderSide(
//                                              color:Colors.white,
//                                            )),
//                                        labelText: 'Username'))),
//                            Container(
//                                margin: EdgeInsets.only(top: 20.0),
//                                padding: EdgeInsets.only(left:10.0,right: 10.0),
//                                child: TextFormField(
//                                    keyboardType: TextInputType.text,
//                                    decoration: InputDecoration(
//                                        alignLabelWithHint: true,
//                                        labelStyle: TextStyle(
//                                          fontSize: 17.0,
//                                          color:Colors.white,
//                                        ),
//                                        hintStyle: TextStyle(
//                                          fontSize: 17.0,
//                                          color:Colors.white,
//                                        ),
//                                        hintText: '',
//                                        prefixIcon: Image.asset(
//                                            'assets/loc.png'),
//                                        contentPadding:
//                                        EdgeInsets.all(2),
//                                        //  <- you can it to 0.0 for no space
//                                        border: new UnderlineInputBorder(
//                                            borderSide: new BorderSide(
//                                              color:Colors.white,
//                                            )),
//                                        labelText: 'Password'))),

//                        Builder(
//                            builder: (context) => Container(
//                                height: 50.0,
//                                margin: EdgeInsets.only(
//                                    left: 10.0, right: 10.0, top: 40.0),
//                                child: SizedBox(
//                                    width: double.infinity,
//                                    child: MaterialButton(
//                                      color: const Color(0xFF729dc0),
//                                      child: new Text(
//                                        'Sign In',
//                                        style: TextStyle(
//                                            color: Colors.white,
//                                            fontSize: 16.0),
//                                      ),
//                                      onPressed: () async {
//                                        setState(() {});
//                                      },
//                                    ))))
                        ],
                      )

//                              child: Text(
//                              "CrypKey",
//                              textAlign: TextAlign.center,
//
//                              style: TextStyle(fontSize: 22.0, color: Colors.white,fontStyle:FontStyle.italic),
//                            ),

                      )
                ]))),
                decoration: new BoxDecoration(
                  color: const Color(0xff7c94b6),
                  image: new DecorationImage(
                    fit: BoxFit.cover,
//                            colorFilter: new ColorFilter.mode(
//                                Colors.black.withOpacity(0.02),
//                                BlendMode.dstATop),
                    image: AssetImage('assets/sample.gif'),

//                            image: new NetworkImage(
//                              'http://www.allwhitebackground.com/images/2/2582-190x190.jpg',
//                            ),
                  ),
                ),
              ),
            ),
          ),
        ));

//    return new MaterialApp(
//      title: 'msc',
//      home: new DefaultTabController(
//        length: 2,
//        child: new Scaffold(
//
//          body: new TabBarView(
//            children: <Widget>[
//              new Column(
//                children: <Widget>[
//
//                  new Card(
//                    child: new Container(
//                      height: MediaQuery.of(context).size.height,
//                      margin: EdgeInsets.only(top: 20.0),
//                      child: new Center(
//                          child: Container(
//                              padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                              height: 500.0,
//                              width: 320.0,
//                              decoration: new BoxDecoration(
//                                color: const Color(0xff77a3c8).withOpacity(0.5),
////                                  image: new DecorationImage(
////                                    fit: BoxFit.cover,
////                                    colorFilter: new ColorFilter.mode(
////                                        Colors.black.withOpacity(0.1),
////                                        BlendMode.dstATop),
////                                    image: AssetImage('assets/background.jpeg'),
////                                  ),
//                              ),
//                              child: Column(
//                                children: <Widget>[
//                                  Row(
//                                    mainAxisAlignment:
//                                    MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Text(
//                                        "CrypKey",
//                                        textAlign: TextAlign.center,
//                                        style: TextStyle(
//                                            fontSize: 22.0,
//                                            color: Colors.white,
//                                            fontStyle: FontStyle.italic),
//                                      ),
//                                    ],
//                                  ),
//                                  new TabBar(
//                                    tabs: [
//                                      new Text("SIGN IN"),
//                                      new Text("SIGN UP")
//                                    ],
//                                  ),
////                                  Row(
////                                    mainAxisAlignment:
////                                    MainAxisAlignment.spaceEvenly,
////                                    children: <Widget>[
////                                      Container(
////                                          padding: EdgeInsets.fromLTRB(
////                                              0, 20, 0, 0),
////                                          child: Text(
////                                            "SIGN IN",
////                                            textAlign: TextAlign.center,
////                                            style: TextStyle(
////                                                fontSize: 22.0,
////                                                color: Colors.white,
////                                                fontStyle: FontStyle.italic),
////                                          )),
////                                      Container(
////                                          padding: EdgeInsets.fromLTRB(
////                                              0, 20, 0, 0),
////                                          child: Text(
////                                            "SIGN UP",
////                                            textAlign: TextAlign.center,
////                                            style: TextStyle(
////                                                fontSize: 22.0,
////                                                color: Colors.white,
////                                                fontStyle: FontStyle.italic),
////                                          )),
////                                    ],
////                                  ),
//                                  Container(
//                                      margin: EdgeInsets.only(top: 70.0),
//                                      padding: EdgeInsets.all(10.0),
//                                      child: TextFormField(
//                                          keyboardType: TextInputType.text,
//                                          decoration: InputDecoration(
//                                              alignLabelWithHint: true,
//                                              labelStyle: TextStyle(
//                                                fontSize: 17.0,
//                                                color:Colors.white,
//                                              ),
//                                              hintStyle: TextStyle(
//                                                fontSize: 17.0,
//                                                color:Colors.white,
//                                              ),
//                                              hintText: '',
//                                              prefixIcon: Image.asset(
//                                                  'assets/loc.png'),
//                                              contentPadding:
//                                              EdgeInsets.all(2),
//                                              //  <- you can it to 0.0 for no space
//                                              border: new UnderlineInputBorder(
//                                                  borderSide: new BorderSide(
//                                                    color:Colors.white,
//                                                  )),
//                                              labelText: 'Username'))),
//                                  Container(
//                                      margin: EdgeInsets.only(top: 20.0),
//                                      padding: EdgeInsets.only(left:10.0,right: 10.0),
//                                      child: TextFormField(
//                                          keyboardType: TextInputType.text,
//                                          decoration: InputDecoration(
//                                              alignLabelWithHint: true,
//                                              labelStyle: TextStyle(
//                                                fontSize: 17.0,
//                                                color:Colors.white,
//                                              ),
//                                              hintStyle: TextStyle(
//                                                fontSize: 17.0,
//                                                color:Colors.white,
//                                              ),
//                                              hintText: '',
//                                              prefixIcon: Image.asset(
//                                                  'assets/loc.png'),
//                                              contentPadding:
//                                              EdgeInsets.all(2),
//                                              //  <- you can it to 0.0 for no space
//                                              border: new UnderlineInputBorder(
//                                                  borderSide: new BorderSide(
//                                                    color:Colors.white,
//                                                  )),
//                                              labelText: 'Password'))),
//
//                                  Builder(
//                                      builder: (context) => Container(
//                                          height: 50.0,
//                                          margin: EdgeInsets.only(
//                                              left: 10.0, right: 10.0, top: 40.0),
//                                          child: SizedBox(
//                                              width: double.infinity,
//                                              child: MaterialButton(
//                                                color: const Color(0xFF729dc0),
//                                                child: new Text(
//                                                  'Sign In',
//                                                  style: TextStyle(
//                                                      color: Colors.white, fontSize: 16.0),
//                                                ),
//                                                onPressed: () async {
//
//                                                  setState(() {
//
//                                                  });
//                                                },
//                                              ))))
//                                ],
//                              )
//
////                              child: Text(
////                              "CrypKey",
////                              textAlign: TextAlign.center,
////
////                              style: TextStyle(fontSize: 22.0, color: Colors.white,fontStyle:FontStyle.italic),
////                            ),
//
//                          )),
//                      decoration: new BoxDecoration(
//                        color: const Color(0xff7c94b6),
//                        image: new DecorationImage(
//                          fit: BoxFit.cover,
////                            colorFilter: new ColorFilter.mode(
////                                Colors.black.withOpacity(0.02),
////                                BlendMode.dstATop),
//                          image: AssetImage('assets/sample.gif'),
//
////                            image: new NetworkImage(
////                              'http://www.allwhitebackground.com/images/2/2582-190x190.jpg',
////                            ),
//                        ),
//                      ),
//                    ),
//                  ),
//                ],
//              ),
//              new Column(
//                children: <Widget>[ new Card(
//                  child: new Container(
//                    height: MediaQuery.of(context).size.height,
//                    margin: EdgeInsets.only(top: 20.0),
//                    child: new Center(
//                        child: Container(
//                            padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
//                            height: 500.0,
//                            width: 320.0,
//                            decoration: new BoxDecoration(
//                              color: const Color(0xff77a3c8).withOpacity(0.5),
////                                  image: new DecorationImage(
////                                    fit: BoxFit.cover,
////                                    colorFilter: new ColorFilter.mode(
////                                        Colors.black.withOpacity(0.1),
////                                        BlendMode.dstATop),
////                                    image: AssetImage('assets/background.jpeg'),
////                                  ),
//                            ),
//                            child: Column(
//                              children: <Widget>[
//                                Row(
//                                  mainAxisAlignment:
//                                  MainAxisAlignment.center,
//                                  children: <Widget>[
//                                    Text(
//                                      "CrypKey",
//                                      textAlign: TextAlign.center,
//                                      style: TextStyle(
//                                          fontSize: 22.0,
//                                          color: Colors.white,
//                                          fontStyle: FontStyle.italic),
//                                    ),
//                                  ],
//                                ),
//                                new TabBar(
//                                  tabs: [
//                                    new Text("SIGN IN"),
//                                    new Text("SIGN UP")
//                                  ],
//                                ),
////                                  Row(
////                                    mainAxisAlignment:
////                                    MainAxisAlignment.spaceEvenly,
////                                    children: <Widget>[
////                                      Container(
////                                          padding: EdgeInsets.fromLTRB(
////                                              0, 20, 0, 0),
////                                          child: Text(
////                                            "SIGN IN",
////                                            textAlign: TextAlign.center,
////                                            style: TextStyle(
////                                                fontSize: 22.0,
////                                                color: Colors.white,
////                                                fontStyle: FontStyle.italic),
////                                          )),
////                                      Container(
////                                          padding: EdgeInsets.fromLTRB(
////                                              0, 20, 0, 0),
////                                          child: Text(
////                                            "SIGN UP",
////                                            textAlign: TextAlign.center,
////                                            style: TextStyle(
////                                                fontSize: 22.0,
////                                                color: Colors.white,
////                                                fontStyle: FontStyle.italic),
////                                          )),
////                                    ],
////                                  ),
//                                Container(
//                                    margin: EdgeInsets.only(top: 70.0),
//                                    padding: EdgeInsets.all(10.0),
//                                    child: TextFormField(
//                                        keyboardType: TextInputType.text,
//                                        decoration: InputDecoration(
//                                            alignLabelWithHint: true,
//                                            labelStyle: TextStyle(
//                                              fontSize: 17.0,
//                                              color:Colors.white,
//                                            ),
//                                            hintStyle: TextStyle(
//                                              fontSize: 17.0,
//                                              color:Colors.white,
//                                            ),
//                                            hintText: '',
//                                            prefixIcon: Image.asset(
//                                                'assets/loc.png'),
//                                            contentPadding:
//                                            EdgeInsets.all(2),
//                                            //  <- you can it to 0.0 for no space
//                                            border: new UnderlineInputBorder(
//                                                borderSide: new BorderSide(
//                                                  color:Colors.white,
//                                                )),
//                                            labelText: 'Username'))),
//                                Container(
//                                    margin: EdgeInsets.only(top: 20.0),
//                                    padding: EdgeInsets.only(left:10.0,right: 10.0),
//                                    child: TextFormField(
//                                        keyboardType: TextInputType.text,
//                                        decoration: InputDecoration(
//                                            alignLabelWithHint: true,
//                                            labelStyle: TextStyle(
//                                              fontSize: 17.0,
//                                              color:Colors.white,
//                                            ),
//                                            hintStyle: TextStyle(
//                                              fontSize: 17.0,
//                                              color:Colors.white,
//                                            ),
//                                            hintText: '',
//                                            prefixIcon: Image.asset(
//                                                'assets/loc.png'),
//                                            contentPadding:
//                                            EdgeInsets.all(2),
//                                            //  <- you can it to 0.0 for no space
//                                            border: new UnderlineInputBorder(
//                                                borderSide: new BorderSide(
//                                                  color:Colors.white,
//                                                )),
//                                            labelText: 'Password'))),
//
//                                Builder(
//                                    builder: (context) => Container(
//                                        height: 50.0,
//                                        margin: EdgeInsets.only(
//                                            left: 10.0, right: 10.0, top: 40.0),
//                                        child: SizedBox(
//                                            width: double.infinity,
//                                            child: MaterialButton(
//                                              color: const Color(0xFF729dc0),
//                                              child: new Text(
//                                                'Sign In',
//                                                style: TextStyle(
//                                                    color: Colors.white, fontSize: 16.0),
//                                              ),
//                                              onPressed: () async {
//
//                                                setState(() {
//
//                                                });
//                                              },
//                                            ))))
//                              ],
//                            )
//
////                              child: Text(
////                              "CrypKey",
////                              textAlign: TextAlign.center,
////
////                              style: TextStyle(fontSize: 22.0, color: Colors.white,fontStyle:FontStyle.italic),
////                            ),
//
//                        )),
//                    decoration: new BoxDecoration(
//                      color: const Color(0xff7c94b6),
//                      image: new DecorationImage(
//                        fit: BoxFit.cover,
////                            colorFilter: new ColorFilter.mode(
////                                Colors.black.withOpacity(0.02),
////                                BlendMode.dstATop),
//                        image: AssetImage('assets/sample.gif'),
//
////                            image: new NetworkImage(
////                              'http://www.allwhitebackground.com/images/2/2582-190x190.jpg',
////                            ),
//                      ),
//                    ),
//                  ),
//                ),],
//              )
//            ],
//          ),
//        ),
//      ),
//    );
  }
}
