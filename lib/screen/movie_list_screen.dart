import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/bottom_nav_controller.dart';
import 'package:movie_app/controller/movie_list_controller.dart';
import 'package:movie_app/screen/movie_details_screen.dart';
import 'package:movie_app/utility/app_text_style.dart';
import 'package:movie_app/utility/urls.dart';
import 'package:movie_app/widgets/center_indicator.dart';

import '../models/movie.dart';
import '../widgets/movie_card.dart';

class MovieListScreen extends StatelessWidget {
  const MovieListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        Get.find<BottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Movie List", style: appBarTextStyle),
        ),
        body: GetBuilder<MovieListController>(builder: (controller) {
          if (controller.loading) {
            return const CenterIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: GridView.custom(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, childAspectRatio: 1 / 1.4),
              childrenDelegate:
                  SliverChildBuilderDelegate(childCount: controller.movieList?.length ?? 0, (context, index) {
                Movie? movie = controller.movieList?[index];
                return Center(
                  child: MovieCard(
                    title: movie?.title ?? "Movie Name",
                    rating: movie?.voteAverage ?? 0.0,
                    ratingCount: movie?.voteCount ?? 0,
                    posterPath: "${Urls.imagePath}${movie?.posterPath}",
                    onTap: () {
                      Get.to(MovieDetailsScreen(movieId: movie?.id ?? 0));
                    },
                  ),
                );
              }),
            ),
          );
        }),
      ),
    );
  }
}
