import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'About',
          style: TextStyle(fontFamily: 'OpenSans', letterSpacing: 2),
        ),
        backgroundColor: Color(0xFF161928),
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'About',
                style: TextStyle(
                  fontSize: height * 0.026,
                  color: Colors.white,
                  fontFamily: 'OpenSans',
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Divider(
                height: 1,
                color: Colors.white,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Version',
                    style: TextStyle(
                      fontSize: height * 0.020,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'V1.0',
                    style: TextStyle(
                      fontSize: height * 0.017,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      letterSpacing: 2,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Divider(
                height: 1,
                color: Colors.white,
              ),
              SizedBox(
                height: height * 0.015,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'App Developer',
                    style: TextStyle(
                      fontSize: height * 0.020,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Prasad Rawas',
                    style: TextStyle(
                      fontSize: height * 0.017,
                      color: Colors.white,
                      fontFamily: 'OpenSans',
                      letterSpacing: 2,
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
