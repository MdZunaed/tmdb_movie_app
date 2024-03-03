import 'movie.dart';

class MovieListModel {
  int? page;
  List<Movie>? movieList;
  int? totalPages;
  int? totalResults;

  MovieListModel({this.page, this.movieList, this.totalPages, this.totalResults});

  MovieListModel.fromJson(Map<String, dynamic> json) {
    page = json['page'];
    if (json['results'] != null) {
      movieList = <Movie>[];
      json['results'].forEach((v) {
        movieList!.add(Movie.fromJson(v));
      });
    }
    totalPages = json['total_pages'];
    totalResults = json['total_results'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['page'] = page;
    if (movieList != null) {
      data['results'] = movieList!.map((v) => v.toJson()).toList();
    }
    data['total_pages'] = totalPages;
    data['total_results'] = totalResults;
    return data;
  }
}
