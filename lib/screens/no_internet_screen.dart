import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/main.dart';
import 'package:my_cinemas/screens/get_started.dart';

class NoInternet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xFF202A36),
      body: SafeArea(
        child: FractionallySizedBox(
          heightFactor: 1,
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FaIcon(FontAwesomeIcons.exclamationTriangle,
                        size: height * 0.08, color: Colors.blueAccent),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'No Connection',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.035,
                        letterSpacing: 3,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Oop's it seems you can't connect to our network, Please check your internet connection.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: height * 0.02,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Ink(
                  height: height * 0.05,
                  width: MediaQuery.of(context).size.width * (2 / 2.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.blueAccent,
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(20),
                    onTap: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => GetStartedScreen(),
                          ),
                          (route) => false);
                    },
                    child: Center(
                      child: Text(
                        'Reload Page',
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 2,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
