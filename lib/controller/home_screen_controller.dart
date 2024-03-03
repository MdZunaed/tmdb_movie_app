import 'dart:developer';

import 'package:get/get.dart';

import '../models/movie.dart';
import '../models/movie_list_model.dart';
import '../models/response_data.dart';
import '../utility/network_caller.dart';
import '../utility/urls.dart';

class HomeScreenController extends GetxController {
  bool _loading = false;

  bool get loading => _loading;
  MovieListModel _trendingMovies = MovieListModel();

  List<Movie>? get trendingMovies => _trendingMovies.movieList;
  MovieListModel _topRatedMovies = MovieListModel();

  List<Movie>? get topRatedMovies => _topRatedMovies.movieList;
  MovieListModel _popularMovies = MovieListModel();

  List<Movie>? get popularMovies => _popularMovies.movieList;

  Future<void> getTrendingMovies() async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.trendingMovies);
    if (response.isSuccess) {
      _trendingMovies = MovieListModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }

  Future<void> getTopRatedMovies() async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.topRatedMovies);
    if (response.isSuccess) {
      _topRatedMovies = MovieListModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }

  Future<void> getPopularMovies() async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.popularMovies);
    if (response.isSuccess) {
      _popularMovies = MovieListModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }
}
