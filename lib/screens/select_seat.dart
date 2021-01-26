import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/models/movie_show.dart';
import 'package:my_cinemas/screens/checkout_movie.dart';

class SelectSeatScreen extends StatefulWidget {
  final Movie movie;
  final MovieShow show;
  SelectSeatScreen(this.movie, this.show);
  @override
  _SelectSeatScreenState createState() => _SelectSeatScreenState();
}

class _SelectSeatScreenState extends State<SelectSeatScreen> {
  var selectedSeats = List.generate(10, (i) => List(9), growable: false);
  List<String> cols = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'];
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161928),
      ),
      body: SafeArea(
        child: Container(
          height: height,
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                height: height * 0.17,
                child: CustomPaint(
                  painter: CurvePainter(),
                  child: Container(
                    child: Center(
                      child: Text(
                        'Screen',
                        style: TextStyle(color: Colors.grey, letterSpacing: 1),
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, i) {
                      return Container(
                        height: MediaQuery.of(context).size.width / 10,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: 9,
                            itemBuilder: (context, j) {
                              return Container(
                                padding: EdgeInsets.all(2),
                                child: Ink(
                                  height: width / 10,
                                  width: width / 10,
                                  decoration: BoxDecoration(
                                    color: (selectedSeats[i][j] == true)
                                        ? Colors.blue
                                        : null,
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Colors.blueAccent),
                                  ),
                                  child: InkWell(
                                    onTap: () {
                                      if (mounted) {
                                        setState(() {
                                          selectedSeats[i][j] =
                                              selectedSeats[i][j] == null
                                                  ? true
                                                  : !selectedSeats[i][j];
                                        });
                                        !widget.show.seats.contains(
                                                cols[i] + j.toString())
                                            ? widget.show.seats
                                                .add(cols[i] + j.toString())
                                            : widget.show.seats
                                                .remove(cols[i] + j.toString());
                                      }
                                    },
                                  ),
                                ),
                              );
                            }),
                      );
                    },
                  ),
                ),
              ),
              Container(
                height: height * 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: height * 0.02,
                              width: height * 0.02,
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.blue),
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Text(
                              'Available',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: height * 0.02,
                              width: height * 0.02,
                              decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Text(
                              'Selected',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 5),
                              height: height * 0.02,
                              width: height * 0.02,
                              decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(50),
                              ),
                            ),
                            Text(
                              'Booked',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
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
                            size: 17,
                          ),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CheckoutMovieScreen(
                                        widget.movie, widget.show)));
                          },
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

class CurvePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();

    paint.color = Colors.lightBlue;
    paint.style = PaintingStyle.stroke;
    paint.strokeWidth = 3;

    var startPoint = Offset(0, size.height / 2);
    var controlPoint1 = Offset(size.width / 4, size.height / 7);
    var controlPoint2 = Offset(3 * size.width / 4, size.height / 7);
    var endPoint = Offset(size.width, size.height / 2);

    var path = Path();
    path.moveTo(startPoint.dx, startPoint.dy);
    path.cubicTo(controlPoint1.dx, controlPoint1.dy, controlPoint2.dx,
        controlPoint2.dy, endPoint.dx, endPoint.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
