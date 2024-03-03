import 'dart:developer';

import 'package:get/get.dart';
import 'package:movie_app/models/movie_details_model.dart';

import '../models/response_data.dart';
import '../utility/network_caller.dart';
import '../utility/urls.dart';

class MovieDetailsController extends GetxController {
  bool _loading = false;
  bool get loading => _loading;
  MovieDetailsModel _movieDetailsModel = MovieDetailsModel();
  MovieDetailsModel get movieDetailsModel => _movieDetailsModel;
  Future<void> getMovieDetails(int movieId) async {
    _loading = true;
    update();
    final ResponseData response = await NetworkCaller().getRequest(Urls.movieDetails(movieId));
    if (response.isSuccess) {
      _movieDetailsModel = MovieDetailsModel.fromJson(response.responseData);
      _loading = false;
      update();
    } else {
      log(response.errorMessage);
      _loading = false;
      update();
    }
  }
}
