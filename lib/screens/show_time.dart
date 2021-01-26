import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/models/movie_show.dart';
import 'package:my_cinemas/screens/select_seat.dart';

class ShowTimeScreen extends StatefulWidget {
  final Movie movie;
  ShowTimeScreen(this.movie);
  @override
  _ShowTimeScreenState createState() => _ShowTimeScreenState();
}

class _ShowTimeScreenState extends State<ShowTimeScreen> {
  DateTime now;
  List<String> weekDays = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  List<String> time = [
    '8 : 0 AM',
    '11 : 20 AM',
    '1 : 30 PM',
    '4 : 40 PM',
    '7 : 50 PM',
    '10 : 00 PM',
    '11 : 30 PM'
  ];
  int selectedTime = 0;
  int selectedDate = 0;

  @override
  void initState() {
    now = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int i = 0;
    double height = MediaQuery.of(context).size.height -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161928),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                child: Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: height * 0.18,
                      child: ListView.builder(
                        physics: BouncingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Ink(
                              height: height * 0.16,
                              width: width / 5,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: InkWell(
                                onTap: () {
                                  setState(() {
                                    selectedDate = index;
                                  });
                                },
                                borderRadius: BorderRadius.circular(20),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: selectedDate == index
                                        ? Colors.blue
                                        : null,
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  padding: EdgeInsets.all(15),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        (now.day + index).toString(),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 30,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Text(
                                        (weekDays[(now.weekday + index) > 6
                                            ? i++
                                            : (now.weekday + index)]),
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      height: height * 0.1,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 7,
                        physics: BouncingScrollPhysics(),
                        itemBuilder: (ctx, index) {
                          return Container(
                            margin: EdgeInsets.only(right: 10),
                            child: Ink(
                              height: height * 0.1,
                              width: width / 4,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blueAccent),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: InkWell(
                                onTap: () {
                                  if (mounted) {
                                    setState(() {
                                      selectedTime = index;
                                    });
                                  }
                                },
                                borderRadius: BorderRadius.circular(10),
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    color: selectedTime == index
                                        ? Colors.blue
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Center(
                                    child: Text(
                                      time[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                child: Ink(
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
                        size: 17,
                      ),
                      onPressed: () {
                        MovieShow show = MovieShow(
                            dateTime: DateTime.now(),
                            weekDay: weekDays[selectedDate],
                            showTime: time[selectedTime],
                            seats: <String>[]);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SelectSeatScreen(widget.movie, show)));
                      },
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
}
