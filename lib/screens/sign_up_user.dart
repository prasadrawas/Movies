import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/dashboard.dart';
import 'package:my_cinemas/data.dart';
import 'package:my_cinemas/screens/loading.dart';
import 'package:my_cinemas/screens/sign_in_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpUserScreen extends StatefulWidget {
  @override
  _SignUpUserScreenState createState() => _SignUpUserScreenState();
}

class _SignUpUserScreenState extends State<SignUpUserScreen> {
  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: _scaffoldKey,
      body: loading
          ? LoadingScreen()
          : SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.all(15),
                  height: MediaQuery.of(context).size.height,
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                child: Column(
                                  children: [
                                    Image.asset(
                                      'assets/images/logo.png',
                                      height: height * (0.150),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'CineClub',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Roboto',
                                        fontSize: height * (0.023),
                                        letterSpacing: 8,
                                      ),
                                      maxLines: 1,
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    AutoSizeText(
                                      'Sign in to access your account.',
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontFamily: 'Roboto',
                                        letterSpacing: 3,
                                      ),
                                      maxLines: 1,
                                      maxFontSize: 20,
                                      minFontSize: 10,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: height * (0.080),
                              ),
                              Container(
                                height: height * (0.068),
                                child: TextFormField(
                                  controller: _nameController,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    letterSpacing: 2,
                                  ),
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: 2,
                                    ),
                                    labelText: 'Name',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * (0.04),
                              ),
                              Container(
                                height: height * (0.068),
                                child: TextFormField(
                                  controller: _emailController,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    letterSpacing: 2,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: 2,
                                    ),
                                    labelText: 'Email',
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: height * (0.04),
                              ),
                              Container(
                                height: height * (0.068),
                                child: TextFormField(
                                  controller: _passwordController,
                                  style: TextStyle(
                                    color: Colors.white70,
                                    letterSpacing: 2,
                                  ),
                                  keyboardType: TextInputType.emailAddress,
                                  decoration: InputDecoration(
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: BorderSide(
                                        color: Colors.blue,
                                        width: 2.0,
                                      ),
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    labelStyle: TextStyle(
                                      color: Colors.white70,
                                      letterSpacing: 2,
                                    ),
                                    labelText: 'Password',
                                  ),
                                  obscureText: true,
                                ),
                              ),
                              SizedBox(
                                height: height * (0.04),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  AutoSizeText(
                                    'Already registered ? ',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * (0.019),
                                      letterSpacing: 2,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  InkWell(
                                      borderRadius: BorderRadius.circular(10),
                                      onTap: () {
                                        Navigator.pushReplacement(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SignInUserScreen()));
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.all(7),
                                        child: AutoSizeText(
                                          'Sign In',
                                          style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: height * (0.019),
                                            letterSpacing: 2,
                                          ),
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Ink(
                          decoration: ShapeDecoration(
                            color: Colors.blue,
                            shape: CircleBorder(),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.angleRight,
                                color: Colors.white,
                                size: height * (0.02),
                              ),
                              onPressed: () async {
                                if (await checkInternetConnection(context)) {
                                  if (_validateInformation()) {
                                    _signUpUser(context);
                                  } else {
                                    _scaffoldKey.currentState.showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'Please enter valid details !')));
                                  }
                                } else {
                                  _scaffoldKey.currentState.showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              'No internet connection !')));
                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  bool _validateInformation() {
    if (_nameController.text.trim().length <= 2 ||
        !_emailController.text.trim().contains('@gmail.com') ||
        _passwordController.text.trim().isEmpty) {
      return false;
    }
    return true;
  }

  _signUpUser(BuildContext context) async {
    try {
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: _emailController.text.trim(),
              password: _passwordController.text.trim())
          .then((value) async {
        DocumentReference users = FirebaseFirestore.instance
            .collection('users')
            .doc(_emailController.text.trim());
        await users.set({
          'name': _nameController.text.trim(),
          'email': _emailController.text.trim(),
          'password': _passwordController.text.trim()
        }).then((value) async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          pref.setString('name', _nameController.text.trim());
          pref.setString('email', _emailController.text.trim());
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
              (route) => false);
        });
      }).catchError((e) {
        if (mounted) {
          setState(() {
            loading = false;
          });
        }
        _scaffoldKey.currentState
            .showSnackBar(SnackBar(content: Text(e.toString())));
      });
    } catch (FirebaseAuthException) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      _scaffoldKey.currentState.showSnackBar(
          SnackBar(content: Text(FirebaseAuthException.code.toString())));
    }
  }
}
