import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_cinemas/values.dart';
import 'package:rating_bar/rating_bar.dart';

class MyTicketsScreen extends StatelessWidget {
  final String email;
  MyTicketsScreen(this.email);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF161928),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(email)
              .collection('tickets')
              .snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: Container(
                  height: height * 0.001,
                  width: width * 0.25,
                  child: LinearProgressIndicator(),
                ),
              );
            }
            return _getTicketList(height, snapshot);
          }),
    );
  }

  _getTicketList(double height, AsyncSnapshot<QuerySnapshot> snapshot) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        itemCount: snapshot.data.docs.length,
        itemBuilder: (context, index) {
          return Container(
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    URLs.imgUrl + snapshot.data.docs[index]['image'],
                    height: height * 0.2,
                  ),
                ),
                SizedBox(
                  width: height * 0.022,
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        snapshot.data.docs[index]['moviename'],
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: height * 0.025,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.008,
                      ),
                      Text(
                        snapshot.data.docs[index]['language'].toUpperCase(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: height * 0.020,
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.only(top: 5, bottom: 10),
                            child: RatingBar.readOnly(
                              initialRating:
                                  snapshot.data.docs[index]['rating'] / 2,
                              isHalfAllowed: true,
                              halfFilledIcon: Icons.star_half,
                              filledIcon: Icons.star,
                              size: height * 0.019,
                              filledColor: Colors.yellow,
                              emptyIcon: Icons.star_border,
                            ),
                          ),
                          SizedBox(
                            width: height * 0.014,
                          ),
                          Text(
                            snapshot.data.docs[index]['rating'].toString() +
                                "/10",
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                      Text(
                        snapshot.data.docs[index]['nooftickets'].toString() +
                            " Tickets " +
                            snapshot.data.docs[index]['tickets'],
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: height * 0.010,
                      ),
                      Text(
                        'Order ID - ${snapshot.data.docs[index]['orderid'].substring(0, 10)}',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }
}
