import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:my_cinemas/screens/sign_in_user.dart';
import 'package:my_cinemas/screens/sign_up_user.dart';

class GetStartedScreen extends StatelessWidget {
  Object navigator;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/images/logo.png',
                            height: height * (0.160),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'CineClub',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.023,
                              fontFamily: 'Roboto',
                              letterSpacing: 8,
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          AutoSizeText(
                            'Experience 4D Cinema in Aurangabad',
                            style: TextStyle(
                              color: Colors.white70,
                              fontFamily: 'Roboto',
                              letterSpacing: 6,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            maxFontSize: 28,
                            minFontSize: 14,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width:
                                MediaQuery.of(context).size.width * (2 / 2.5),
                            height: height * 0.052,
                            child: Ink(
                              decoration: BoxDecoration(
                                color: Colors.blueAccent,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                borderRadius: BorderRadius.circular(20),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SignUpUserScreen()));
                                },
                                child: Center(
                                  child: Text(
                                    'Get Started',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Roboto',
                                      letterSpacing: 2,
                                      fontSize: height * 0.018,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AutoSizeText(
                                'Already have an Account ?',
                                style: TextStyle(
                                  color: Colors.white,
                                  letterSpacing: 2,
                                  fontSize: height * 0.019,
                                ),
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              InkWell(
                                  borderRadius: BorderRadius.circular(10),
                                  onTap: () {
                                    Navigator.push(
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
                                        fontSize: height * 0.019,
                                        letterSpacing: 2,
                                      ),
                                    ),
                                  )),
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
