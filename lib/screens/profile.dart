import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/screens/about.dart';
import 'package:my_cinemas/screens/loading.dart';
import 'package:my_cinemas/screens/my_tickets.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _email = '', _name = '';
  bool loading = true;
  @override
  void initState() {
    _getPrefData();
    super.initState();
  }

  _getPrefData() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    _email = pref.getString('email');
    _name = pref.getString('name');
    if (mounted) {
      setState(() {
        loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: loading
          ? LoadingScreen()
          : SafeArea(
              child: Container(
                padding: EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 10),
                      child: Text(
                        _name,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.030,
                            letterSpacing: 1),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 5),
                      child: Text(
                        _email,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.018,
                            letterSpacing: 1),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.022,
                    ),
                    Divider(
                      height: 1,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: height * 0.02,
                    ),
                    Text(
                      'Menu',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.025,
                          letterSpacing: 1),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: EdgeInsets.only(top: 10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      MyTicketsScreen(_email)));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.ticketAlt,
                                color: Colors.white,
                                size: height * 0.020,
                              ),
                              SizedBox(
                                width: height * 0.013,
                              ),
                              Text(
                                'My Tickets',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.024,
                                    letterSpacing: 1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AboutScreen()));
                        },
                        child: Padding(
                          padding: EdgeInsets.only(top: 10, bottom: 10),
                          child: Row(
                            children: [
                              FaIcon(
                                FontAwesomeIcons.info,
                                color: Colors.white,
                                size: height * 0.020,
                              ),
                              SizedBox(
                                width: height * 0.018,
                              ),
                              Text(
                                'About',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: height * 0.024,
                                    letterSpacing: 1),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
