class Urls {
  static const String baseUrl = "https://api.themoviedb.org/3";
  static const String imagePath = "https://image.tmdb.org/t/p/w500";
  static const String movieList = "$baseUrl/discover/movie";
  static String movieDetails(int id) => "$baseUrl/movie/$id";
  static const String tvList = "$baseUrl/discover/tv";
  static String tvDetails(int id) => "$baseUrl/tv/$id";
  static const String trendingMovies = "$baseUrl/trending/movie/day";
  static const String topRatedMovies = "$baseUrl/movie/top_rated";
  static const String popularMovies = "$baseUrl/movie/popular";
}
