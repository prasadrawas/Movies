import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/data.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/models/person.dart';
import 'package:my_cinemas/screens/reviews.dart';
import 'package:my_cinemas/screens/show_time.dart';
import 'package:my_cinemas/values.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class MovieDetails extends StatefulWidget {
  final Movie movie;
  bool ticketBookPage;
  MovieDetails({this.movie, this.ticketBookPage});

  @override
  _MovieDetailsState createState() => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
  @override
  void initState() {
    if (list.contains(widget.movie)) widget.ticketBookPage = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.only(bottom: 60),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: height * (1 / 1.55),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: Image.network(
                    (widget.movie.poster == null)
                        ? 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8-e9Jpr1AyNwkdf_iE_zQjknFwrn3kBbQQ&usqp=CAU'
                        : 'https://image.tmdb.org/t/p/w500' +
                            widget.movie.poster,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
              Container(
                height: height * 0.003,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 10.0,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: height * 0.024,
              ),
              Container(
                padding:
                    EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.movie.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: MediaQuery.of(context).size.height * (0.030),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(bottom: 10),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RatingBar.readOnly(
                            initialRating: widget.movie.rating / 2,
                            isHalfAllowed: true,
                            halfFilledIcon: Icons.star_half,
                            filledIcon: Icons.star,
                            size: MediaQuery.of(context).size.height * (0.020),
                            filledColor: Colors.yellow,
                            emptyIcon: Icons.star_border,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            widget.movie.rating.toString() + "/10",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize:
                                  MediaQuery.of(context).size.height * (0.017),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      widget.movie.date,
                      style: TextStyle(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                        fontSize: height * 0.019,
                      ),
                    ),

                    Container(
                      height: 20,
                      width: 60,
                      margin: EdgeInsets.only(
                        bottom: 20,
                        top: 5,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Center(
                          child: Text(
                        widget.movie.language.toUpperCase(),
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                        ),
                      )),
                    ),

                    //movie overview
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: AutoSizeText(
                        widget.movie.overview,
                        style: TextStyle(
                          color: Colors.white,
                          letterSpacing: 1,
                          fontSize:
                              MediaQuery.of(context).size.height * (0.020),
                        ),
                      ),
                    ),

                    //show casting details

                    //casting details
                    _castingDetails(height, width),

                    //crew details
                    _crewDetails(height, width),

                    //movie trialers
                    _movieTrailersCard(height, width),

                    //show similar movies
                    _similarMovies(height, width),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: !widget.ticketBookPage ? null : _bookMovieButton(),
    );
  }

  Future<List<Person>> _fetchCastingDetails() async {
    List<Person> personList = [];
    int count = 0;
    var data = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/credits?api_key=${URLs.apiKey}&language=en-US');

    var jsonData = json.decode(data.body);
    for (var json in jsonData['cast']) {
      try {
        Person record = Person(
          id: json['id'],
          known: json['known_for_department'],
          name: json['name'],
          character: json['character'],
          profileImg: json['profile_path'],
        );
        personList.add(record);
        if (count++ > 30) break;
      } catch (e) {
        print(e);
        break;
      }
    }
    return personList;
  }

  Future<List<Person>> _fetchCrewDetails() async {
    List<Person> personList = [];
    int count = 0;
    var data = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/credits?api_key=${URLs.apiKey}&language=en-US');

    var jsonData = json.decode(data.body);
    for (var json in jsonData['crew']) {
      try {
        Person record = Person(
          id: json['id'],
          known: json['known_for_department'],
          name: json['name'],
          dept: json['department'],
          profileImg: json['profile_path'],
        );
        personList.add(record);
        if (count++ > 30) break;
      } catch (e) {
        print(e);
        break;
      }
    }
    return personList;
  }

  Future<List<Movie>> _fetchSimilarMovies() async {
    var data = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/similar?api_key=${URLs.apiKey}&language=en-US&page=1');

    var jsonData = json.decode(data.body);

    List<Movie> similarMovies = [];
    for (var json in jsonData['results']) {
      try {
        Movie record = Movie(
          id: json['id'],
          popularity: json['popularity'],
          title: json['original_title'] == null
              ? json['name']
              : json['original_title'],
          back_poster: json['backdrop_path'],
          poster: json['poster_path'],
          overview: json['overview'],
          rating: double.parse(json['vote_average'].toString()),
          date: json['release_date'],
          language: json['original_language'],
        );
        similarMovies.add(record);
      } catch (e) {
        print(e);
        break;
      }
    }
    return similarMovies;
  }

  Widget _bookMovieButton() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ShowTimeScreen(widget.movie)));
      },
      child: Container(
        width: MediaQuery.of(context).size.width - 30,
        height: MediaQuery.of(context).size.height * (1 / 18),
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: Text(
            'Book Ticket',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
          ),
        ),
      ),
    );
  }

  Widget _similarMovies(double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: height * (3 / 7),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Similar Movies',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchSimilarMovies(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                      height: height * 0.001,
                      width: width * 0.25,
                      child: LinearProgressIndicator(),
                    ),
                  );
                } else {
                  return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data.length,
                      itemBuilder: (context, i) {
                        return Container(
                          margin: EdgeInsets.only(right: 13),
                          height: height * (3 / 9),
                          width: width * (1 / 2.5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MovieDetails(
                                            movie: snapshot.data[i],
                                            ticketBookPage: false,
                                          )));
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: MediaQuery.of(context).size.height *
                                      (3 / 10),
                                  width: MediaQuery.of(context).size.width *
                                      (1 / 2.5),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      URLs.imgUrl + snapshot.data[i].poster,
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                AutoSizeText(
                                  snapshot.data[i].title,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize:
                                        MediaQuery.of(context).size.height *
                                            (0.019),
                                  ),
                                  maxLines: 1,
                                ),
                                SizedBox(
                                  height: 2,
                                ),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      (1 / 5.7),
                                  child: RatingBar.readOnly(
                                    initialRating: snapshot.data[i].rating / 2,
                                    isHalfAllowed: true,
                                    halfFilledIcon: Icons.star_half,
                                    filledIcon: Icons.star,
                                    size: MediaQuery.of(context).size.height *
                                        (0.018),
                                    filledColor: Colors.yellow,
                                    emptyIcon: Icons.star_border,
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      });
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _castingDetails(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            'Cast',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * (0.030),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          height: height * (3 / 9),
          child: FutureBuilder(
            future: _fetchCastingDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Container(
                    height: height * 0.001,
                    width: width * 0.25,
                    child: LinearProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 13),
                        height: height * (3 / 9),
                        width: width * (1 / 3.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * (3 / 15),
                              width:
                                  MediaQuery.of(context).size.width * (1 / 3.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  (snapshot.data[i].profileImg != null)
                                      ? URLs.imgUrl +
                                          snapshot.data[i].profileImg
                                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8-e9Jpr1AyNwkdf_iE_zQjknFwrn3kBbQQ&usqp=CAU',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data[i].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data[i].character,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: height * 0.015,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _crewDetails(double height, double width) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: AutoSizeText(
            'Crew',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: MediaQuery.of(context).size.height * (0.030),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 10, bottom: 20),
          height: height * (3 / 9),
          child: FutureBuilder(
            future: _fetchCrewDetails(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(
                  child: Container(
                    height: height * 0.001,
                    width: width * 0.25,
                    child: LinearProgressIndicator(),
                  ),
                );
              } else {
                return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      return Container(
                        margin: EdgeInsets.only(right: 13),
                        height: height * (3 / 9),
                        width: width * (1 / 3.5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height:
                                  MediaQuery.of(context).size.height * (3 / 15),
                              width:
                                  MediaQuery.of(context).size.width * (1 / 3.5),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  (snapshot.data[i].profileImg != null)
                                      ? URLs.imgUrl +
                                          snapshot.data[i].profileImg
                                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8-e9Jpr1AyNwkdf_iE_zQjknFwrn3kBbQQ&usqp=CAU',
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data[i].name,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: height * 0.018,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              snapshot.data[i].dept,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: height * 0.018,
                              ),
                            ),
                          ],
                        ),
                      );
                    });
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _movieTrailersCard(double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: height * 0.30,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Trailers',
            style: TextStyle(
              color: Colors.white,
              fontSize: height * 0.026,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: _fetchMovieTrailers(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.data == null) {
                  return Center(
                    child: Container(
                      height: height * 0.001,
                      width: width * 0.25,
                      child: LinearProgressIndicator(),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data.length,
                    itemBuilder: (context, i) {
                      //print(snapshot.data[i]);
                      return Container(
                        margin: EdgeInsets.only(right: 15),
                        width: width * 0.6,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            _launchYoutubeUrl(snapshot.data[i]);
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  'https://img.youtube.com/vi/${snapshot.data[i]}/hqdefault.jpg',
                                  fit: BoxFit.fill,
                                ),
                              ),
                              FaIcon(
                                FontAwesomeIcons.playCircle,
                                color: Colors.yellow,
                                size: height * (0.050),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  _fetchMovieTrailers() async {
    var response = await http.get(
        'https://api.themoviedb.org/3/movie/${widget.movie.id}/videos?api_key=${URLs.apiKey}&language=en-US');
    var jsonData = json.decode(response.body);
    List<String> keys = [];
    for (var json in jsonData['results']) {
      keys.add(json['key']);
    }
    return keys;
  }

  _launchYoutubeUrl(String id) async {
    var url = "https://www.youtube.com/watch?v=${id}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
