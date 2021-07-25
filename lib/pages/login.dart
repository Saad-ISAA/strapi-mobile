import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:strapi_flutter_cms/models/drawer_data_model.dart';
import 'package:strapi_flutter_cms/pages/home_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LoginScreen extends StatefulWidget {
  final String adminURL;

  const LoginScreen({Key key, this.adminURL}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;

  // initializing with pre written credentials just to avoid loigns on every hot restart

  TextEditingController urlController =
      TextEditingController(text: 'http://51.120.94.203:1337');
  TextEditingController emailController =
      TextEditingController(text: 'saadmujeeb123@gmail.com');
  TextEditingController passwordController =
      TextEditingController(text: 'Saad123!@#');
  String strapiVersion;

  void initState() {
    super.initState();
    urlController.text = widget.adminURL;
    _getEmailAndPassword();
  }

  void _getEmailAndPassword() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('email')) {
      setState(() {
        emailController.text = prefs.getString('email');
        passwordController.text = prefs.getString('password');
      });
    }
  }

  Future<bool> _checkStrapiVersion(String token) async {
    var url = Uri.parse('${urlController.text}/admin/information');
    try {
      var response = await http.get(url,
          headers: {HttpHeaders.authorizationHeader: "Bearer " + token});
      strapiVersion = jsonDecode(response.body)["data"]["strapiVersion"];
      return int.parse(strapiVersion.split(".")[1]) <= 3 ? false : true;
    } catch (e) {
      throw e;
    }
  }

  Future<void> _loginUser() async {
    var url = Uri.parse('${urlController.text}/admin/login');
    print(url);
    var response = await http.post(url, body: {
      'email': emailController.text,
      'password': passwordController.text
    });

    if (response.statusCode == 200) {
      Map jsonResponse = jsonDecode(response.body);

      String token = jsonResponse['data']['token'];
      bool checkVersion =
          await _checkStrapiVersion(jsonResponse['data']['token']);

      if (checkVersion) {
        await saveStringsToPrefs(token, jsonResponse['data']['user']);

        List<dynamic> drawerData = await _getDrawerData(token);
        if (drawerData != null) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(
                drawerData: drawerData,
                user: jsonResponse['data']['user'],
              ),
            ),
          );
        } else {
          print('drawer data is null');
        }
      } else {
        return showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                content:
                    Text("Sorry your version v$strapiVersion is not supported"),
                actions: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.forward),
                  )
                ],
              );
            });
      }
    } else {
      print('Login failed');
    }
  }

  Future<List> _getDrawerData(String token) async {
    var url = Uri.parse('${urlController.text}/content-manager/content-types');
    var response =
        await http.get(url, headers: {"Authorization": 'Bearer $token'});

    if (response.statusCode == 200) {
      List jsonResponse = jsonDecode(response.body)['data'] as List;
      List drawerData = jsonResponse
          .where((element) => element["isDisplayed"] == true)
          .toList();
      return drawerData;
    } else {
      return null;
    }
  }

  Widget _buildForgotPasswordBtn() {
    return Container(
      alignment: Alignment.centerRight,
      child: FlatButton(
        onPressed: () => print('Forgot Password Button Pressed'),
        padding: EdgeInsets.only(right: 0.0),
        child: Text(
          'Forgot Password?',
          style: labelStyle,
        ),
      ),
    );
  }

  Widget _buildRememberMeCheckbox() {
    return Container(
      height: 20.0,
      child: Row(
        children: <Widget>[
          Theme(
            data: ThemeData(unselectedWidgetColor: Colors.white),
            child: Checkbox(
              value: _rememberMe,
              checkColor: Colors.green,
              activeColor: Colors.white,
              onChanged: (value) {
                setState(() {
                  _rememberMe = value;
                });
              },
            ),
          ),
          Text(
            'Remember me',
            style: labelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: RaisedButton(
        elevation: 5.0,
        onPressed: () {
          _loginUser();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        color: Colors.white,
        child: Text(
          'LOGIN',
          style: TextStyle(
            color: strapiColor,
            letterSpacing: 1.5,
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: Stack(
            children: <Widget>[
              Container(
                height: double.infinity,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Color(0xFF1C1B7E), Color(0xFF8A67F3)],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 40.0,
                      vertical: 70,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Image.asset('assets/images/logo.png', height: 100),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Admin URL', style: labelStyle),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: boxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                controller: urlController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.link,
                                    color: Colors.white,
                                  ),
                                  hintText: 'http://192.168.0.0',
                                  hintStyle: hintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Email',
                              style: labelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: boxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                controller: emailController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.email,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Email',
                                  hintStyle: hintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Password',
                              style: labelStyle,
                            ),
                            SizedBox(height: 10.0),
                            Container(
                              alignment: Alignment.centerLeft,
                              decoration: boxDecorationStyle,
                              height: 60.0,
                              child: TextField(
                                obscureText: true,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'OpenSans',
                                ),
                                controller: passwordController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(top: 14.0),
                                  prefixIcon: Icon(
                                    Icons.lock,
                                    color: Colors.white,
                                  ),
                                  hintText: 'Enter your Password',
                                  hintStyle: hintTextStyle,
                                ),
                              ),
                            ),
                          ],
                        ),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  saveStringsToPrefs(String token, Map user) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('token', token);
    prefs.setString('adminURL', urlController.text);
    prefs.setString('user', json.encode(user));

    if (_rememberMe) {
      prefs.setString('email', emailController.text);
      prefs.setString('password', passwordController.text);
    }
  }
}

final hintTextStyle = TextStyle(
  color: Colors.white54,
  fontFamily: 'OpenSans',
);

final labelStyle = TextStyle(
  color: Colors.white,
  fontWeight: FontWeight.bold,
  fontFamily: 'OpenSans',
);

final boxDecorationStyle = BoxDecoration(
  color: strapiColor,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
