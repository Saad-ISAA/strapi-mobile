import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:strapi_flutter_cms/Customwidgets/checkbox.dart';
import 'package:strapi_flutter_cms/Customwidgets/spinner.dart';
import 'package:strapi_flutter_cms/Customwidgets/textfields.dart';
import 'package:strapi_flutter_cms/models/drawer_data_model.dart';
import 'package:strapi_flutter_cms/pages/home_page.dart';
import 'package:strapi_flutter_cms/shared/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:strapi_flutter_cms/GlobalConfig.dart';
import 'dart:convert';
import 'package:velocity_x/velocity_x.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _rememberMe = false;
  bool _loading = false;

  // initializing with pre written credentials just to avoid loigns on every hot restart

  TextEditingController urlController = TextEditingController(text: '');
  TextEditingController emailController = TextEditingController(text: '');
  TextEditingController passwordController = TextEditingController(text: '');
  String strapiVersion;

  void initState() {
    super.initState();
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
    setState(() {
      _loading = true;
    });
    try {
      var response = await http.post(url, body: {
        'email': emailController.text,
        'password': passwordController.text
      }, headers: {
        'Accept': 'application/json'
      });

      if (response.statusCode == 200) {
        setState(() {
          _loading = false;
        });
        Map jsonResponse = jsonDecode(response.body);

        String token = jsonResponse['data']['token'];
        bool checkVersion =
            await _checkStrapiVersion(jsonResponse['data']['token']);

        if (checkVersion) {
          await saveStringsToPrefs(token, jsonResponse['data']['user']);
          await GlobalConfig.prefs.setString("baseURL", urlController.text);

          await GlobalConfig.initializePrefs();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(),
            ),
          );
        } else {
          return showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  content: Text(
                      "Sorry your version v$strapiVersion is not supported"),
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
        setState(() {
          _loading = false;
        });
        print('Login failed');
      }
    } catch (err) {
      print(err);
      setState(() {
        _loading = false;
      });

      return showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content:
                  Text("Failed to login , Make Sure your server is running."),
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
      child: TextButton(
        onPressed: () => print('Forgot Password Button Pressed'),
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
          StrapiCheckBox(
            value: _rememberMe,
            onChanged: (value) {
              setState(() {
                _rememberMe = value;
              });
            },
          ),
          Text(
            'Remember me',
            style: labelStyle,
          ),
        ],
      ),
    );
  }

  Widget _buildLoginBtn(bool isLoading) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 25.0),
      width: double.infinity,
      child: MaterialButton(
        elevation: 0,
        highlightElevation: 0,
        onPressed: () {
          _loginUser();
        },
        padding: EdgeInsets.all(15.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        color: primary600,
        child: isLoading
            ? CustomSpinner(color: Colors.white)
            : Text(
                'LOGIN',
                style: TextStyle(
                  color: Colors.white,
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
                color: Colors.white,
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
                        Image.asset('assets/images/strapi_new.png',
                            height: 100),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          'Welcome!',
                          style: TextStyle(
                              fontFamily: 'OpenSans',
                              fontSize: 30,
                              fontWeight: FontWeight.bold),
                        ),
                        12.heightBox,
                        Text('Log in to your Strapi account',
                            style: TextStyle(fontSize: 15, color: neutral500)),
                        SizedBox(height: 30.0),
                        PrimaryTextField(
                          controller: urlController,
                          title: 'Admin URL',
                          hintText: 'http://127.0.0.1:1337',
                          inputType: TextInputType.url,
                          // icon: 'assets/icons/uid.svg',
                        ),
                        SizedBox(height: 30.0),
                        PrimaryTextField(
                          controller: emailController,
                          title: 'Email',
                          hintText: 'Enter your Email',
                          inputType: TextInputType.emailAddress,
                          //  icon: 'assets/icons/email.svg',
                        ),
                        SizedBox(
                          height: 30.0,
                        ),
                        PrimaryTextField(
                          controller: passwordController,
                          title: 'Password',
                          hintText: 'Enter your password',
                          inputType: TextInputType.visiblePassword,
                          isObscure: true,
                          // icon: 'assets/icons/password.svg',
                        ),
                        _buildForgotPasswordBtn(),
                        _buildRememberMeCheckbox(),
                        _buildLoginBtn(_loading),
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
    await GlobalConfig.prefs.setString('token', 'Bearer $token');
    await GlobalConfig.prefs.setString('adminURL', urlController.text);
    await GlobalConfig.prefs.setString('user', json.encode(user));

    if (_rememberMe) {
      await GlobalConfig.prefs.setString("isRememberMe", "true");
      await GlobalConfig.prefs.setString('email', emailController.text);
      await GlobalConfig.prefs.setString('password', passwordController.text);
    }
  }
}

final boxDecorationStyle = BoxDecoration(
  color: primary500,
  borderRadius: BorderRadius.circular(10.0),
  boxShadow: [
    BoxShadow(
      color: Colors.black12,
      blurRadius: 6.0,
      offset: Offset(0, 2),
    ),
  ],
);
