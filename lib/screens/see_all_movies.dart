import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:my_cinemas/models/movie.dart';
import 'package:my_cinemas/screens/movie_details.dart';
import 'package:http/http.dart' as http;
import 'package:my_cinemas/values.dart';
import 'package:rating_bar/rating_bar.dart';

class SeeAllMovies extends StatefulWidget {
  List<Movie> moviesList = [];
  String sectionName;
  bool booking;
  bool searching;

  SeeAllMovies(this.moviesList, this.sectionName, this.booking, this.searching);

  @override
  _SeeAllMoviesState createState() => _SeeAllMoviesState();
}

class _SeeAllMoviesState extends State<SeeAllMovies> {
  StringBuffer _query = new StringBuffer('');
  bool _querySubmitted = false;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: getAppBar(),
      body: SafeArea(
        child: !widget.searching
            ? getMovieGrid()
            : FutureBuilder(
                future: _fetchSearchResults(_query),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (_querySubmitted == true && !snapshot.hasData) {
                    return Center(
                      child: Container(
                        height: height * 0.001,
                        width: width * 0.25,
                        child: LinearProgressIndicator(),
                      ),
                    );
                  }
                  return getMovieGrid();
                },
              ),
      ),
    );
  }

  Widget getMovieGrid() {
    return GridView.builder(
        physics: BouncingScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.6,
        ),
        itemCount: widget.moviesList.length,
        itemBuilder: (context, i) {
          return movieCard(i);
        });
  }

  Future<List<Movie>> _fetchSearchResults(StringBuffer query) async {
    widget.moviesList = [];
    print(query);
    var response = await http.get(
        'https://api.themoviedb.org/3/search/multi?api_key=${URLs.apiKey}&language=en-US&page=1&query=${_query}');

    var jsonData = json.decode(response.body);

    for (var json in jsonData['results']) {
      if (json['poster_path'] == null || json['title'] == null) continue;
      Movie record = Movie(
        id: json['id'],
        popularity: json['popularity'],
        title: json['title'],
        poster: json['poster_path'],
        overview: json['overview'],
        rating: double.parse(json['vote_average'].toString()),
        date: json['release_date'],
        language: json['original_language'],
      );
      widget.moviesList.add(record);
    }
    return widget.moviesList;
  }

  Widget movieCard(int i) {
    return Container(
      margin: EdgeInsets.all(8),
      child: InkWell(
        borderRadius: BorderRadius.circular(10),
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => MovieDetails(
                        movie: widget.moviesList[i],
                        ticketBookPage: false,
                      )));
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.33,
              width: MediaQuery.of(context).size.width * 0.5,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  (widget.moviesList[i].poster != null)
                      ? URLs.imgUrl + widget.moviesList[i].poster
                      : 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT8-e9Jpr1AyNwkdf_iE_zQjknFwrn3kBbQQ&usqp=CAU',
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(
              height: 5,
            ),
            AutoSizeText(
              widget.moviesList[i].title,
              style: TextStyle(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.height * (0.018),
              ),
              maxLines: 1,
            ),
            SizedBox(
              height: 5,
            ),
            FittedBox(
              child: Container(
                child: RatingBar.readOnly(
                  initialRating: widget.moviesList[i].rating / 2,
                  isHalfAllowed: true,
                  halfFilledIcon: Icons.star_half,
                  filledIcon: Icons.star,
                  size: MediaQuery.of(context).size.height * (0.016),
                  filledColor: Colors.yellow,
                  emptyIcon: Icons.star_border,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getAppBar() {
    return AppBar(
      backgroundColor: Color(0xFF161928),
      title: widget.searching
          ? TextFormField(
              textInputAction: TextInputAction.search,
              onFieldSubmitted: (String s) {
                _query = StringBuffer(s.trim().replaceAll(' ', '+'));
                FocusScope.of(context).unfocus();
                setState(() {
                  _querySubmitted = true;
                });
              },
              autofocus: true,
              style: TextStyle(
                color: Colors.white,
                letterSpacing: 1,
              ),
              decoration: InputDecoration(
                hintText: 'Search',
                hintStyle: TextStyle(
                  color: Colors.white,
                  letterSpacing: 1,
                ),
                border: InputBorder.none,
              ),
            )
          : Text(
              widget.sectionName,
              style: TextStyle(letterSpacing: 1),
            ),
      actions: [
        IconButton(
          icon: FaIcon(
            widget.searching ? FontAwesomeIcons.times : FontAwesomeIcons.search,
            color: Colors.white,
            size: 18,
          ),
          onPressed: () {
            if (mounted) {
              setState(() {
                widget.searching = !widget.searching;
              });
            }
          },
        ),
      ],
    );
  }
}
