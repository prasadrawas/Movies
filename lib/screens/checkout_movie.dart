import 'package:auto_size_text/auto_size_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/dashboard.dart';
import 'package:my_cinemas/data.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/models/movie_show.dart';
import 'package:my_cinemas/screens/loading.dart';
import 'package:my_cinemas/values.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CheckoutMovieScreen extends StatefulWidget {
  final Movie movie;
  final MovieShow show;

  CheckoutMovieScreen(this.movie, this.show);

  @override
  _CheckoutMovieScreenState createState() => _CheckoutMovieScreenState();
}

class _CheckoutMovieScreenState extends State<CheckoutMovieScreen> {
  String tickets = '';

  String orderId = DateTime.now()
      .toString()
      .replaceAll('-', '')
      .replaceAll(' ', '')
      .replaceAll(':', '')
      .replaceAll('.', '');
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    for (String x in widget.show.seats) {
      tickets += x + " ";
    }
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Color(0xFF161928),
      ),
      body: loading
          ? LoadingScreen()
          : Container(
              height: height,
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: Column(
                      children: [
                        Text(
                          'Checkout Movie',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: height * 0.028,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          height: height * 0.028,
                        ),
                        Row(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                URLs.imgUrl + widget.movie.poster,
                                height: height * 0.2,
                              ),
                            ),
                            SizedBox(
                              width: height * 0.028,
                            ),
                            FittedBox(
                              child: Container(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.movie.title,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.021,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      '${widget.movie.language.toUpperCase()}',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: height * 0.021,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              top: 5, bottom: 10),
                                          child: RatingBar.readOnly(
                                            initialRating:
                                                widget.movie.rating / 2,
                                            isHalfAllowed: true,
                                            halfFilledIcon: Icons.star_half,
                                            filledIcon: Icons.star,
                                            size: height * 0.021,
                                            filledColor: Colors.yellow,
                                            emptyIcon: Icons.star_border,
                                          ),
                                        ),
                                        SizedBox(
                                          width: height * 0.013,
                                        ),
                                        Text(
                                          widget.movie.rating.toString() +
                                              "/10",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: height * 0.018,
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15, bottom: 15),
                          child: Divider(
                            height: 1,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Order ID',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            orderId,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Cinema',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            'CineClub',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Date & Time',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            widget.show.dateTime.day.toString() +
                                " " +
                                widget.show.weekDay +
                                ", " +
                                widget.show.showTime,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tickets',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Flexible(
                            child: Text(
                              tickets.trim().replaceAll(' ', ', '),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.021,
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Fee',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            (100 * widget.show.seats.length).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Tax',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            (8 * widget.show.seats.length).toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Divider(
                        height: 1,
                        color: Colors.white,
                      ),
                      SizedBox(
                        height: height * 0.014,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: height * 0.021,
                            ),
                          ),
                          Text(
                            (100 * widget.show.seats.length +
                                    8 * widget.show.seats.length)
                                .toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                  Ink(
                    width: MediaQuery.of(context).size.width * (2 / 2.5),
                    height: height * 0.050,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.blue,
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () {
                        _bookTicket();
                      },
                      child: Center(
                        child: Text(
                          'Pay Online',
                          style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Roboto',
                            letterSpacing: 2,
                            fontSize: height * 0.018,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }

  _bookTicket() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    try {
      if (mounted) {
        setState(() {
          loading = true;
        });
      }
      await FirebaseFirestore.instance
          .collection('users')
          .doc(pref.get('email'))
          .collection('tickets')
          .add({
        'moviename': widget.movie.title,
        'language': widget.movie.language,
        'rating': widget.movie.rating,
        'nooftickets': widget.show.seats.length,
        'tickets': tickets,
        'orderid': orderId,
        'image': widget.movie.poster,
      });
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      _showSuccessAlertDialogue();
    } catch (e) {
      if (mounted) {
        setState(() {
          loading = false;
        });
      }
      _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Failed')));
    }
  }

  _showSuccessAlertDialogue() {
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0))),
                content: Container(
                  height: 200,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FaIcon(
                        FontAwesomeIcons.smile,
                        color: Colors.blue,
                        size: 30,
                      ),
                      Text(
                        "Congratulations your tickets are booked.\n Enjoy your show.",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          letterSpacing: 1,
                          color: Colors.black,
                          fontFamily: 'OpenSans',
                          fontSize: 16,
                        ),
                      ),
                      Align(
                        alignment: Alignment.bottomCenter,
                        child: Ink(
                          height: 40,
                          width: MediaQuery.of(context).size.width - 100,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.blue),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20),
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            },
                            child: Center(
                              child: Text(
                                'Continue',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontFamily: 'OpenSans',
                                    fontWeight: FontWeight.bold),
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
        },
        context: context,
        barrierDismissible: false,
        barrierLabel: '',
        pageBuilder: (context, animation1, animation2) {});
  }
}
