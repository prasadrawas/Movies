import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/screens/now_playing.dart';
import 'package:my_cinemas/screens/profile.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selected = 1;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          height: height - MediaQuery.of(context).padding.top,
          child: Column(
            children: [
              Expanded(
                child: (selected == 1) ? NowPlayingScreen() : ProfileScreen(),
              ),
              Ink(
                padding: EdgeInsets.only(top: 5),
                height: height * 0.070,
                decoration: BoxDecoration(
                  color: Color(0xFF161930),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              selected = 1;
                            });
                          }
                        },
                        child: Container(
                          height: height * 0.060,
                          child: Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.photoVideo,
                                size: height * 0.030,
                                color: selected == 1
                                    ? Colors.blue
                                    : Colors.white70,
                              ),
                              SizedBox(
                                height: height * 0.010,
                              ),
                              Text(
                                'Now Playing',
                                style: TextStyle(
                                    color: selected == 1
                                        ? Colors.blue
                                        : Colors.white70,
                                    letterSpacing: 2,
                                    fontSize: height * 0.015),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          if (mounted) {
                            setState(() {
                              selected = 2;
                            });
                          }
                        },
                        child: Container(
                          height: height * 0.060,
                          child: Column(
                            children: [
                              Icon(
                                FontAwesomeIcons.ticketAlt,
                                color: selected == 2
                                    ? Colors.blue
                                    : Colors.white70,
                              ),
                              SizedBox(
                                height: height * 0.010,
                              ),
                              Text(
                                'Profile',
                                style: TextStyle(
                                  color: selected == 2
                                      ? Colors.blue
                                      : Colors.white70,
                                  letterSpacing: 2,
                                  fontSize: height * 0.015,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
