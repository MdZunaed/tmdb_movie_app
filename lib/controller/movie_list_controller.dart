import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/models/movie.dart';
import 'package:movie_app/models/movie_list_model.dart';
import 'package:movie_app/models/response_data.dart';
import 'package:movie_app/utility/network_caller.dart';
import 'package:movie_app/utility/urls.dart';

class MovieListController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  MovieListModel _movieListModel = MovieListModel();
  List<Movie>? get movieList => _movieListModel.movieList;
  Future<void> getMovieList() async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.movieList);
    if (response.isSuccess) {
      _movieListModel = MovieListModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }
}
