import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/movie_details_controller.dart';
import 'package:movie_app/models/movie_details_model.dart';
import 'package:movie_app/utility/app_colors.dart';
import 'package:movie_app/utility/app_text_style.dart';
import 'package:movie_app/utility/urls.dart';
import 'package:movie_app/widgets/center_indicator.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  State<MovieDetailsScreen> createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<MovieDetailsController>().getMovieDetails(widget.movieId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(controller.movieDetailsModel.title ?? ''),
      // ),
      body: GetBuilder<MovieDetailsController>(builder: (controller) {
        MovieDetailsModel movie = controller.movieDetailsModel;
        if (controller.loading) {
          return const CenterIndicator();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("${Urls.imagePath}${movie.backdropPath}"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 8),
                    Text(movie.title ?? "Movie Name", style: titleTextStyle.copyWith(fontSize: 26)),
                    const SizedBox(height: 8),
                    rating(movie),
                    const SizedBox(height: 8),
                    detailsContainer(movie),
                    const SizedBox(height: 10),
                    const Text("Genre", style: appBarTextStyle),
                    const SizedBox(height: 10),
                    genre(movie),
                    const SizedBox(height: 10),
                    const Text("Overview", style: appBarTextStyle),
                    Text(movie.overview ?? "overview", style: appTextStyle),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  SingleChildScrollView genre(MovieDetailsModel movie) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: movie.genres!
            .map((genre) => Row(children: [
                  Chip(
                      side: const BorderSide(color: primaryColor),
                      label: Text(genre.name ?? "", style: appTextStyle)),
                  const SizedBox(width: 5)
                ]))
            .toList(),
      ),
    );
  }

  Container detailsContainer(MovieDetailsModel movie) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Status: ${movie.status}", style: appTextStyle),
          Text("Language: ${movie.originalLanguage}", style: appTextStyle),
          //Text("Language: ${movie.spokenLanguages?[0].englishName}", style: appTextStyle),
          Text("Runtime: ${movie.runtime}m", style: appTextStyle),
          Text("Revenue: ${movie.revenue}", style: appTextStyle),
          Text("Release date: ${movie.releaseDate}", style: appTextStyle),
        ],
      ),
    );
  }

  Wrap rating(MovieDetailsModel movie) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("Rating: ", style: titleTextStyle.copyWith(fontSize: 16, color: whiteColor)),
        const Icon(Icons.star, color: Colors.amber, size: 18),
        Text(" ${movie.voteAverage?.toStringAsPrecision(2)}",
            style: appTextStyle.copyWith(fontWeight: FontWeight.w500)),
        Text(" (${movie.voteCount})", style: appTextStyle),
      ],
    );
  }
}
