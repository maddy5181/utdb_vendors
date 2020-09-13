import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_login_page_ui/Utils/Network_util.dart';
import 'package:flutter_login_page_ui/Utils/Toast.dart';
import 'package:flutter_login_page_ui/Utils/login_screen_presenter.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:http/http.dart' as http;
import 'Data/Api.dart';
import 'Widgets/FormCard.dart';
import 'Widgets/SocialIcons.dart';
import 'CustomIcons.dart';

void main() => runApp(MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isSelected = false;
  final FocusNode myFocusNodeName = FocusNode();
  final FocusNode myFocusNodepwd = FocusNode();
  TextEditingController loginNameController = new TextEditingController();
  TextEditingController loginPwdController = new TextEditingController();
  final _formKeyname = GlobalKey<FormState>();
  final _formKeypwd = GlobalKey<FormState>();
  final Map<String, dynamic> _formData = {};
  String username, userpwd;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  // LoginRequestData _loginData = LoginRequestData();
  bool _obscureText = true;
  bool _autoValidate = false;
  bool _isLoading = false;

  LoginScreenPresenter _presenter;
  NetworkUtil _netUtil = new NetworkUtil();

  void _radio() {
    setState(() {
      _isSelected = !_isSelected;
    });
  }

  Widget radioButton(bool isSelected) => Container(
        width: 16.0,
        height: 16.0,
        padding: EdgeInsets.all(2.0),
        decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 2.0, color: Colors.black)),
        child: isSelected
            ? Container(
                width: double.infinity,
                height: double.infinity,
                decoration:
                    BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              )
            : Container(),
      );

  Widget horizontalLine() => Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        child: Container(
          width: ScreenUtil.getInstance().setWidth(120),
          height: 1.0,
          color: Colors.black26.withOpacity(.2),
        ),
      );

  @override
  Widget build(BuildContext context) {
    // ingore_for_file: prefer_expression_function_bodies
    // ScreenUtil.instance = ScreenUtil.getInstance()..init(context);
    // ScreenUtil.instance =
    //     ScreenUtil(width: 750, height: 1334, allowFontScaling: true);
    return new Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisSize: MainAxisSize.max,
           // crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: Image.asset("assets/image_01.png"),
              ),
              Expanded(
                child: Container(),
              ),
              Image.asset("assets/image_02.png")
            ],
          ),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(left: 28.0, right: 28.0, top: 10.0),
              child: Column(
                children: <Widget>[
                  new SizedBox(height: 20.0),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/logo1.png",
                        width: ScreenUtil.getInstance().setWidth(110),
                        height: ScreenUtil.getInstance().setHeight(110),
                      ),
                      Text("UTDB",
                          style: TextStyle(
                              fontFamily: "Poppins-Bold",
                              fontSize: ScreenUtil.getInstance().setSp(46),
                              letterSpacing: .6,
                              fontWeight: FontWeight.bold))
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(180),
                  ),
                  formui(),
                  SizedBox(height: ScreenUtil.getInstance().setHeight(40)),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 12.0,
                          ),
                          GestureDetector(
                            onTap: _radio,
                            child: radioButton(_isSelected),
                          ),
                          SizedBox(
                            width: 8.0,
                          ),
                          Text("Remember me",
                              style: TextStyle(
                                  fontSize: 12, fontFamily: "Poppins-Medium"))
                        ],
                      ),
                      InkWell(
                        child: Container(
                          width: ScreenUtil.getInstance().setWidth(330),
                          height: ScreenUtil.getInstance().setHeight(100),
                          decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF17ead9),
                                Color(0xFF6078ea)
                              ]),
                              borderRadius: BorderRadius.circular(6.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Color(0xFF6078ea).withOpacity(.3),
                                    offset: Offset(0.0, 8.0),
                                    blurRadius: 8.0)
                              ]),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              onTap: () {
                                print("click");
                                signin();
                              },
                              child: Center(
                                child: Text("SIGNIN",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins-Bold",
                                        fontSize: 18,
                                        letterSpacing: 1.0)),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  /* Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      horizontalLine(),
                      Text("Social Login",
                          style: TextStyle(
                              fontSize: 16.0, fontFamily: "Poppins-Medium")),
                      horizontalLine()
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(40),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SocialIcon(
                        colors: [
                          Color(0xFF102397),
                          Color(0xFF187adf),
                          Color(0xFF00eaf8),
                        ],
                        iconData: CustomIcons.facebook,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFFff4f38),
                          Color(0xFFff355d),
                        ],
                        iconData: CustomIcons.googlePlus,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF17ead9),
                          Color(0xFF6078ea),
                        ],
                        iconData: CustomIcons.twitter,
                        onPressed: () {},
                      ),
                      SocialIcon(
                        colors: [
                          Color(0xFF00c6fb),
                          Color(0xFF005bea),
                        ],
                        iconData: CustomIcons.linkedin,
                        onPressed: () {},
                      )
                    ],
                  ),
                  SizedBox(
                    height: ScreenUtil.getInstance().setHeight(30),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        "New User? ",
                        style: TextStyle(fontFamily: "Poppins-Medium"),
                      ),
                      InkWell(
                        onTap: () {},
                        child: Text("SignUp",
                            style: TextStyle(
                                color: Color(0xFF5d74e3),
                                fontFamily: "Poppins-Bold")),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<void> signin() async {
    try {
      if (!_formKeyname.currentState.validate() ||
          !_formKeypwd.currentState.validate()) {
        setState(() {
          _autoValidate = true;
          _isLoading = false;
          // Navigator.pop(context);
        });
        return;
      } else {
        _formKeyname.currentState.save();
        _formKeypwd.currentState.save();

        Map data = {
          'username': _formData['username'],
          'password': _formData['userpwd'],
        };

        print("data========================================${data}");

        final http.Response response = await http.post(
          RestDatasource.LOGIN_URL,
          body: json.encode(data),
          headers: {
            'Content-Type': 'application/json',
          },
        );

        final Map<String, dynamic> responseData = json.decode(response.body);
        print(responseData);
        if (responseData.containsKey('status')) {
          int res = responseData["status"];
          if (res == 1) {
            //success
            showtoast("Login Sucessfully");
            // Navigator.push(context,
            //     new MaterialPageRoute(builder: (context) => Dashboard()));
            // hasError = false;
          } else {
            String message = responseData["msg"];
            showtoast(message);
          }
        }
      }
    }catch(e){
      print("error:$e");
    }
  }

  Widget formui() {
    return Container(
      width: double.infinity,
      height: ScreenUtil.getInstance().setHeight(500),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, 15.0),
                blurRadius: 15.0),
            BoxShadow(
                color: Colors.black12,
                offset: Offset(0.0, -10.0),
                blurRadius: 10.0),
          ]),
      child: Padding(
        padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  top: 20.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Form(
                key: _formKeyname,
                child: TextFormField(
                  focusNode: myFocusNodeName,
                  controller: loginNameController,
                  keyboardType: TextInputType.text,
                  textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    icon: Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    labelText: 'Name *',
                    hintStyle:
                        TextStyle(fontFamily: "Montserrat", fontSize: 16.0),
                  ),
                  onSaved: (String value) {
                    this.username = value;
                    _formData['username'] = value;
                    print('name=$username');
                  },
                  validator: _validateName,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(10),
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.0, bottom: 20.0, left: 25.0, right: 25.0),
              child: Form(
                key: _formKeypwd,
                child: TextFormField(
                  focusNode: myFocusNodepwd,
                  controller: loginPwdController,
                  keyboardType: TextInputType.visiblePassword,
                  // textCapitalization: TextCapitalization.words,
                  style: TextStyle(
                      fontFamily: "Montserrat",
                      fontSize: 14.0,
                      color: Colors.black),
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red),
                    ),
                    icon: Icon(
                      Icons.lock,
                      color: Colors.black,
                    ),
                    labelText: 'Password *',
                    hintStyle:
                        TextStyle(fontFamily: "Montserrat", fontSize: 16.0),
                  ),

                  onSaved: (String value) {
                    this.userpwd = value;
                    _formData['userpwd'] = value;
                    print('pwd=$userpwd');
                  },
                  validator: validatePassword,
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil.getInstance().setHeight(35),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Text(
                  "Forgot Password?",
                  style: TextStyle(
                      color: Colors.blue,
                      fontFamily: "Poppins-Medium",
                      fontSize: ScreenUtil.getInstance().setSp(28)),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  static Future<void> showLoadingDialog(
      BuildContext context, GlobalKey key) async {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new WillPopScope(
              onWillPop: () async => false,
              child: SimpleDialog(
                  key: key,
                  backgroundColor: Colors.black54,
                  children: <Widget>[
                    Center(
                      child: Column(children: [
                        CircularProgressIndicator(),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Please Wait....",
                          style: TextStyle(color: Colors.blueAccent),
                        )
                      ]),
                    )
                  ]));
        });
  }

  String phoneNumberValidator(String value) {
    Pattern pattern = r'^(?:[+0]9)?[0-9]{10}$';
    RegExp regex = new RegExp(pattern);
    if (value.isEmpty) {
      return 'phone number is Required';
    } else {
      if (!regex.hasMatch(value))
        return 'Enter Valid Phone Number';
      else
        return null;
    }
  }

  String _validateName(String value) {
    if (value.isEmpty) return 'Name is required.';
    final RegExp nameExp = RegExp(r'^[A-Za-z ]+$');
    // if (!nameExp.hasMatch(value))
    //   return 'Please enter only alphabetical characters.';
    return null;
  }

  String validatePassword(String value) {
    //Pattern pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    Pattern pattern = r'[0-9]';
    RegExp regex = new RegExp(pattern);
    print(value);
    if (value.isEmpty) {
      return 'Password is Required';
    } else {
      if (!regex.hasMatch(value))
        return 'EInvalid password';
      else
        return null;
    }
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.isEmpty) {
      return "Email is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Invalid Email";
    } else {
      return null;
    }
  }
}
