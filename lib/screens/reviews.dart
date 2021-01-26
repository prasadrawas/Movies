import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:my_cinemas/values.dart';

class ReviewsScreen extends StatefulWidget {
  int id;
  ReviewsScreen(this.id);
  @override
  _ReviewsScreenState createState() => _ReviewsScreenState();
}

class _ReviewsScreenState extends State<ReviewsScreen> {
  List<Reviews> reviews = [];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(10),
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(15),
                child: Text(
                  'Reviews',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: height * 0.040,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Expanded(
                child: FutureBuilder(
                  future: _fetchReviews(),
                  builder: (BuildContext context, AsyncSnapshot snapshot) {
                    if (snapshot.data == null) return Text('Loading');
                    return _reviewCard(snapshot, height, width);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _reviewCard(AsyncSnapshot snapshot, double height, double width) {
    return ListView.builder(
      itemCount: snapshot.data.length,
      itemBuilder: (context, i) {
        return Container(
          padding: EdgeInsets.all(15),
          margin: EdgeInsets.only(bottom: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white70),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FaIcon(
                    FontAwesomeIcons.user,
                    color: Colors.white,
                    size: height * 0.050,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    reviews[i].author,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * 0.020,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Divider(
                  height: 1,
                  color: Colors.white,
                ),
              ),
              Text(
                snapshot.data[i].review,
                style: TextStyle(
                  fontSize: height * 0.018,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<List<Reviews>> _fetchReviews() async {
    reviews = [];
    var response = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.id}/reviews?api_key=${URLs.apiKey}&language=en-US&page=1');
    var jsonData = json.decode(response.body);

    for (var json in jsonData['results']) {
      Reviews record = Reviews(
          author: json['author'],
          rating: json['rating'],
          review: json['content']);
      reviews.add(record);
    }
    return reviews;
  }
}

class Reviews {
  String author;
  String image;
  double rating;
  String review;
  Reviews({this.author, this.image, this.rating, this.review});
}
