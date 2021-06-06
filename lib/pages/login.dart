import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';
import 'package:bricko_web/main.dart';
import 'package:bricko_web/state_widget.dart';
import 'package:flutter_auth_buttons/flutter_auth_buttons.dart';
import 'package:flutter_translate/flutter_translate.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  TextEditingController _emailTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();

//  SharedPreferences preferences;

  @override
  void initState() {
    super.initState();
    _getCredential();
  }

  _getCredential() async {
    setState(() {
      if (dataStorage.preferences.containsKey(rememberMePref)) {
        rememberMe = dataStorage.preferences.getBool(rememberMePref);
      } else {
        dataStorage.preferences.setBool(rememberMePref, true);
      }
    });
  }

  void _rememberMeChanged(bool value) async {
    setState(() {
      rememberMe = value;
      dataStorage.preferences.setBool(rememberMePref, value);
    });
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height / 3;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Image.asset(
            'images/back.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Container(
            color: Colors.black.withOpacity(0.8),
            width: double.infinity,
            height: double.infinity,
          ),
//          Padding(//раскомментить
//            padding: const EdgeInsets.all(32.0),
//            child: Container(
//                alignment: Alignment.topCenter,
//                child: Image.asset(
//                  'images/lg.png',
//                  width: double.infinity,
//                  height: 140.0,
//                )),
//          ),
          Padding(
//            padding: const EdgeInsets.only(top: 180.0), //вернуть это значение
            padding: const EdgeInsets.only(top: 100),
            child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
//                        Padding(
//                          padding: EdgeInsets.only(bottom: 10.0, top: 8.0),
//                          child: Text(translate("please_sign_in"),textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.0),),
//
//                        ),

                    /// email field
//                    Padding(
//                      padding: const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                      child: Material(
//                        borderRadius: BorderRadius.circular(3.0),
//                        color: Colors.white.withOpacity(0.4),
//                        elevation: 0.0,
//                        child: Padding(
//                          padding: const EdgeInsets.only(left: 12.0),
//                          child: TextFormField(
//                            controller: _emailTextController,
//                            decoration: InputDecoration(
//                              hintText: translate("email"),
//                              icon: Icon(Icons.alternate_email),
//                            ),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                Pattern pattern =
//                                    r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                                RegExp regex = new RegExp(pattern);
//                                if (!regex.hasMatch(value))
//                                  return 'Please make sure your email address is valid';
//                                else
//                                  return null;
//                              }
//                            },
//                          ),
//                        ),
//                      ),
//                    ),

                    /// password field
//                    Padding(
//                      padding:
//                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                      child: Material(
//                        borderRadius: BorderRadius.circular(3.0),
//                        color: Colors.white.withOpacity(0.4),
//                        elevation: 0.0,
//                        child: Padding(
//                          padding: const EdgeInsets.only(left: 12.0),
//                          child: TextFormField(
//                            controller: _passwordTextController,
//                            decoration: InputDecoration(
//                              hintText: translate("password"),
//                              icon: Icon(Icons.lock_outline),
//                            ),
//                            validator: (value) {
//                              if (value.isEmpty) {
//                                return "The password field cannot be empty";
//                              } else if (value.length < 6) {
//                                return "the password has to be at least 6 characters long";
//                              }
//                              return null;
//                            },
//                          ),
//                        ),
//                      ),
//                    ),

                    Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Container(
                          alignment: Alignment.center,
                          child: Image.asset(
                            'images/logo.png',
                            width: double.infinity,
                            height: 200.0,
                          )),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.25,
                    ),

                    ///remember me
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.4),
                      child: new CheckboxListTile(
                        value: rememberMe,
                        onChanged: _rememberMeChanged,
                        title: Text(
                          translate("remember_me"),
                          style: TextStyle(color: Colors.white),
                        ),
                        controlAffinity: ListTileControlAffinity.leading,
                        activeColor: Colors.red.shade900,
                      ),
                    ),

//                    Padding(
//                      padding:
//                          const EdgeInsets.fromLTRB(14.0, 8.0, 14.0, 8.0),
//                      child: Material(
//                          borderRadius: BorderRadius.circular(3.0),
//                          color: Colors.red.shade700,
//                          elevation: 0.0,
//                          child: MaterialButton(
//                            onPressed: () {},
//                            minWidth: MediaQuery.of(context).size.width,
//                            child: Text(
//                              translate("login"),
//                              textAlign: TextAlign.center,
//                              style: TextStyle(
//                                  color: Colors.white,
//                                  fontWeight: FontWeight.bold,
//                                  fontSize: 20.0),
//                            ),
//                          )),
//                    ),

//                        /// divider
//                        Row(children: <Widget>[
//                          Expanded(
//                            child: new Container(
//                                margin: const EdgeInsets.only(left: 14.0, right: 20.0),
//                                child: Divider(
//                                  color: Colors.white,
//                                  height: 40,
//                                )),
//                          ),
//                          Text(
//                            "or",
//                            style: TextStyle(
//                              color: Colors.white,
//                            ),
//                          ),
//                          Expanded(
//                            child: new Container(
//                                margin: const EdgeInsets.only(left: 20.0, right: 14.0),
//                                child: Divider(
//                                  color: Colors.white,
//                                  height: 40,
//                                )),
//                          ),
//                        ]),

                    /// google sign in
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: MediaQuery.of(context).size.width * 0.4),
                      child: GoogleSignInButton(
                        text: translate("google_sign_in"),
                        onPressed: () =>
                            StateWidget.of(context).signInWithGoogle(),
                        darkMode: true,
                      ),
                    ),

//                    Padding(
//                      padding: const EdgeInsets.all(8.0),
//                      child: Text(
//                        translate("forgot_password"),
//                        textAlign: TextAlign.center,
//                        style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.w400,
//                        ),
//                      ),
//                    ),
//
//
//
//                    /// sing up
//                    Padding(
//                        padding: const EdgeInsets.all(8.0),
//                        child: InkWell(
//                            onTap: (){
//                              Navigator.push(context, MaterialPageRoute(builder: (context) => SignUp()));
//                            },
//                            child: Text(translate("sign_up"), textAlign: TextAlign.center, style: TextStyle(color: Colors.red),))
//                    ),
                  ],
                )),
          ),
//          Visibility(
//            visible: authService.loading ?? true,
//            child: Center(
//              child: Container(
//                alignment: Alignment.center,
//                color: Colors.white.withOpacity(0.9),
//                child: CircularProgressIndicator(
//                  valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
//                ),
//              ),
//            ),
//          )
        ],
      ),
    );
  }
}
