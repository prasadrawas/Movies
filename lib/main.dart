import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_cinemas/dashboard.dart';
import 'package:my_cinemas/data.dart';
import 'package:my_cinemas/screens/get_started.dart';
import 'package:my_cinemas/screens/no_internet_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(SplashScreenPage());
}

class SplashScreenPage extends StatefulWidget {
  @override
  _SplashScreenPageState createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  var navigator;
  bool _checkPref = false;
  @override
  void initState() {
    checkInternetConnection();
    super.initState();
  }

  Future checkInternetConnection() async {
    await checkPreferences();
    try {
      var res = await InternetAddress.lookup('google.com');
      if (res.isNotEmpty && res[0].rawAddress.isNotEmpty) {
        navigator = null;
      }
    } catch (e) {
      navigator = NoInternet();
    }
  }

  Future checkPreferences() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {
        _checkPref = pref.getString('email') == null ? false : true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Harmanos',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Color(0xFF161928),
      ),
      home: SplashScreen(
        seconds: 3,
        navigateAfterSeconds: navigator == null
            ? (_checkPref ? HomePage() : GetStartedScreen())
            : NoInternet(),
        backgroundColor: Color(0xFF161928),
        photoSize: 100,
        useLoader: false,
        image: Image.asset(
          'assets/images/logo.png',
          height: 100,
        ),
        loadingText: Text(
          'From Prasad',
          style: TextStyle(
              color: Colors.white, fontFamily: 'OpenSans', letterSpacing: 3),
        ),
      ),
    );
  }
}
