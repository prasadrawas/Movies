import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/data.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/screens/movie_details.dart';
import 'package:my_cinemas/screens/see_all_movies.dart';
import 'package:my_cinemas/values.dart';
import 'package:rating_bar/rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';

class NowPlayingScreen extends StatefulWidget {
  @override
  _NowPlayingScreenState createState() => _NowPlayingScreenState();
}

class _NowPlayingScreenState extends State<NowPlayingScreen> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Search bar UI Code start
              Container(
                margin: EdgeInsets.only(top: 15, bottom: 20),
                height: (height) * (1 / 16),
                width: width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.only(left: 10, right: 10),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SeeAllMovies(
                                  <Movie>[],
                                  'Search',
                                  false,
                                  true,
                                )));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Search',
                        style: TextStyle(
                          color: Colors.black54,
                          letterSpacing: 2,
                          fontSize: height * 0.020,
                        ),
                      ),
                      FaIcon(
                        FontAwesomeIcons.search,
                        color: Colors.black54,
                        size: height * 0.020,
                      )
                    ],
                  ),
                ),
              ),
              //Search bar UI Code end

              //nowPlaying now section start
              movieCardContainer(_fetchNowPlayingMovies, list, height, width,
                  true, 'Now Playing'),
              //nowPlaying now section end

              //trailers section start
              movieTrailersCard(height, width),
              //trailers section end

              //Trending movies section start
              movieCardContainer(_fetchTrendingMovies, trendingMovies, height,
                  width, false, 'Trending'),
              //Trending movies section end

              //Upcoming movies section start
              movieCardContainer(_fetchUpcomingMovies, upcomingMovies, height,
                  width, false, 'Upcoming Movies'),
              //Upcoming movies section end

              //Popular movies section start
              movieCardContainer(_fetchPopularMovies, popularMovies, height,
                  width, false, 'Popular Movies'),
              //Popular movies section end
            ],
          ),
        ),
      ),
    );
  }

  Widget movieCard(
      AsyncSnapshot snapshot, double height, double width, bool booking) {
    return ListView.builder(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (context, i) {
          return Container(
            margin: EdgeInsets.only(right: 13),
            height: height * 0.33,
            width: width * 0.40,
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
                              ticketBookPage: booking,
                            )));
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: height * 0.3,
                    width: width * 0.4,
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
                  Text(
                    snapshot.data[i].title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: height * (0.019),
                    ),
                  ),
                  SizedBox(
                    height: 2,
                  ),
                  FittedBox(
                    alignment: Alignment.topLeft,
                    child: RatingBar.readOnly(
                      initialRating: snapshot.data[i].rating / 2,
                      isHalfAllowed: true,
                      halfFilledIcon: Icons.star_half,
                      filledIcon: Icons.star,
                      size: height * (0.018),
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

  Widget movieCardContainer(Function getMovies, List<Movie> list, double height,
      double width, bool booking, String sectionName) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: height * 0.4285,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                sectionName,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: height * 0.026,
                  fontWeight: FontWeight.w600,
                ),
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              SeeAllMovies(list, sectionName, booking, false)));
                },
                borderRadius: BorderRadius.circular(10),
                child: Padding(
                  padding: EdgeInsets.all(5),
                  child: Center(
                    child: Text(
                      'See all',
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: height * 0.018,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: FutureBuilder(
              future: getMovies(),
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
                  return movieCard(snapshot, height, width, booking);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget movieTrailersCard(double height, double width) {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      height: height * 0.27,
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
              future: _fetchNowPlayingMovies(),
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
                        return FittedBox(
                          child: Container(
                            margin: EdgeInsets.only(right: 13),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10),
                              onTap: () {
                                _launchYoutubeUrl(i);
                              },
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(8.0),
                                    child: Image.network(
                                      'https://image.tmdb.org/t/p/w400' +
                                          snapshot.data[i].back_poster,
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

  Future<List<Movie>> _fetchNowPlayingMovies() async {
    if (list.isEmpty) {
      var data = await http.get(
          'https://api.themoviedb.org/3/movie/now_playing?api_key=${URLs.apiKey}&language=en-US&page=1');
      var jsonData = json.decode(data.body);
      for (var json in jsonData['results']) {
        try {
          Movie record = Movie(
            id: json['id'],
            popularity: json['popularity'],
            title: json['title'],
            back_poster: json['backdrop_path'],
            poster: json['poster_path'],
            overview: json['overview'],
            rating: double.parse(json['vote_average'].toString()),
            date: json['release_date'],
            language: json['original_language'],
          );
          list.add(record);
        } catch (e) {
          print(e);
          break;
        }
      }
    }
    return list;
  }

  Future<List<Movie>> _fetchTrendingMovies() async {
    if (list.isEmpty) {
      var data = await http.get(
          'https://api.themoviedb.org/3/trending/all/day?api_key=${URLs.apiKey}&page=1');
      var jsonData = json.decode(data.body);
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
          trendingMovies.add(record);
        } catch (e) {
          print(e);
          break;
        }
      }
    }
    return trendingMovies;
  }

  Future<List<Movie>> _fetchPopularMovies() async {
    if (popularMovies.isEmpty) {
      var data = await http.get(
          'https://api.themoviedb.org/3/movie/popular?api_key=${URLs.apiKey}&language=en-US&page=2');
      var jsonData = json.decode(data.body);
      for (var json in jsonData['results']) {
        try {
          Movie record = Movie(
            id: json['id'],
            popularity: json['popularity'],
            title: json['title'],
            back_poster: json['backdrop_path'],
            poster: json['poster_path'],
            overview: json['overview'],
            rating: double.parse(json['vote_average'].toString()),
            date: json['release_date'],
            language: json['original_language'],
          );
          popularMovies.add(record);
        } catch (e) {
          print(e);
          break;
        }
      }
    }
    return popularMovies;
  }

  Future<List<Movie>> _fetchUpcomingMovies() async {
    if (list.isEmpty) {
      var data = await http.get(
          'https://api.themoviedb.org/3/movie/upcoming?api_key=${URLs.apiKey}&language=en-US&page=2');
      var jsonData = json.decode(data.body);
      for (var json in jsonData['results']) {
        try {
          Movie record = Movie(
            id: json['id'],
            popularity: json['popularity'],
            title: json['title'],
            back_poster: json['backdrop_path'],
            poster: json['poster_path'],
            overview: json['overview'],
            rating: double.parse(json['vote_average'].toString()),
            date: json['release_date'],
            language: json['original_language'],
          );
          upcomingMovies.add(record);
        } catch (e) {
          print(e);
          break;
        }
      }
    }
    return upcomingMovies;
  }

  _launchYoutubeUrl(int id) async {
    var response = await http.get(
        'https://api.themoviedb.org/3/movie/${list[id].id}/videos?api_key=${URLs.apiKey}&language=en-US');
    var jsonData = json.decode(response.body);
    var url =
        "https://www.youtube.com/watch?v=${jsonData['results'][0]['key']}";
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
