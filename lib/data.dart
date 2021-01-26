import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:my_cinemas/models/movie.dart';

List<Movie> list = [];
List<Movie> upcomingMovies = [];
List<Movie> popularMovies = [];
List<Movie> trendingMovies = [];

Future<bool> checkInternetConnection(BuildContext context) async {
  try {
    final result = await InternetAddress.lookup('google.com');
    if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
      return true;
    }
  } catch (e) {
    return false;
  }
}
