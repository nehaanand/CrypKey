import 'package:flutter/material.dart';

class Login1 extends StatefulWidget {
  static String tag = 'login1-page';
  final routes = <String, WidgetBuilder>{
//    NavigationDrawerDemo.tag: (context) => NavigationDrawerDemo(),
  };

  Login1({Key key}) : super(key: key);

  State createState1() => new _LoginState1();

  @override
  _LoginState1 createState() => _LoginState1();
}

class _LoginState1 extends State<Login1> with SingleTickerProviderStateMixin {
  TabController _tabController;
  List<Tab> tabList = List();

  String privacy_policy_url, termsandconditionsurl;
  List SuppAppDashboardList = [];
  TextEditingController row_1_title = new TextEditingController();
  TextEditingController row_2_title = new TextEditingController();
  TextEditingController row_3_title = new TextEditingController();

  TextEditingController box_11_title = new TextEditingController();
  TextEditingController box_12_title = new TextEditingController();
  TextEditingController box_13_title = new TextEditingController();

  TextEditingController box_11_value = new TextEditingController();
  TextEditingController box_12_value = new TextEditingController();
  TextEditingController box_13_value = new TextEditingController();

  double height = 0.0, width = 0.0;

  @override
  void initState() {
    tabList.add(new Tab(
      text: 'SIGN IN',
    ));
    tabList.add(new Tab(
      text: 'SIGN UP',
    ));
    _tabController = new TabController(vsync: this, length: tabList.length);
    super.initState();
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

    return new Container(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: new Card(
          child: new Container(
            height: MediaQuery.of(context).size.height,
            margin: EdgeInsets.only(top: 20.0),
            child: new Center(
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
                                  child:new TabBar(
                                    controller: _tabController,
                                    indicatorColor: Colors.white,
                                      labelStyle: TextStyle(fontSize: 18.0,fontStyle: FontStyle.italic),  //For Selected tab

                                      indicatorSize: TabBarIndicatorSize.tab,
                                    indicatorWeight: 4,
                                    tabs: tabList),
                              ),
                              new Container(
                                height:450.0,
                                child: new TabBarView(
                                  controller: _tabController,

                                  children: <Widget>[
                                    Column(children: <Widget>[
                                      new Container(
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: TextFormField(

                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.person,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Username',
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
                                                  labelText: 'Username'))),
                                      Container(
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: TextFormField(
                                            obscureText: true,
                                              keyboardType: TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.lock,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Password',
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
                                                  labelText: 'Password'))),
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
                                                    color:
                                                        const Color(0xFF729dc0),
                                                    child: new Text(
                                                      'Sign In',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {});
                                                    },
                                                  ))))
                                    ]),
                                    Column(children: <Widget>[
                                      new Container(

                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          margin: EdgeInsets.only(top: 10.0),
                                          child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.keyboard,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Name',
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
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.mail,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Email',
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
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: TextFormField(
                                              keyboardType: TextInputType.text,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.phone,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Mobile No.',
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
                                                  labelText: 'Mobile No.'))),
                                      Container(
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: TextFormField(  obscureText: true,
                                              keyboardType: TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.lock,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Password',
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
                                                  labelText: 'Password'))),
                                      Container(
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.only(
                                              left: 10.0, right: 10.0),
                                          child: TextFormField(
                                            obscureText: true,
                                              keyboardType: TextInputType.visiblePassword,
                                              decoration: InputDecoration(
                                                  alignLabelWithHint: true,
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
                                                    padding: const EdgeInsetsDirectional.only(start: 3.0,top:8.0),
                                                    child: Icon(
                                                      Icons.lock,
                                                      color: Colors.white,
                                                      size: 24.0,
                                                      semanticLabel: 'Confirm Password',
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
                                                  labelText: 'Confirm Password'))),
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
                                                    color:
                                                        const Color(0xFF729dc0),
                                                    child: new Text(
                                                      'Sign In',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 16.0),
                                                    ),
                                                    onPressed: () async {
                                                      setState(() {});
                                                    },
                                                  ))))
                                    ]),
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
            ])),
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
    );

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
