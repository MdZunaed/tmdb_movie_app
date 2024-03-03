import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/home_screen_controller.dart';
import 'package:movie_app/screen/movie_details_screen.dart';
import 'package:movie_app/utility/app_colors.dart';
import 'package:movie_app/utility/app_text_style.dart';
import 'package:movie_app/utility/urls.dart';
import 'package:movie_app/widgets/center_indicator.dart';
import 'package:movie_app/widgets/movie_card.dart';

import '../models/movie.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("MOOVI", style: appBarTextStyle),
      ),
      body: GetBuilder<HomeScreenController>(builder: (controller) {
        if (controller.loading) {
          return const CenterIndicator();
        }
        return SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(children: [
                Text("Trending Movies", style: appBarTextStyle.copyWith(color: whiteColor, fontSize: 22)),
                const SizedBox(height: 20),
                moviesSlider(controller)
              ]),
              const SizedBox(height: 20),
              Text("Top Rated Movies", style: appBarTextStyle.copyWith(color: whiteColor)),
              const SizedBox(height: 10),
              movieList(controller.topRatedMovies ?? []),
              const SizedBox(height: 10),
              Text("Popular Movies", style: appBarTextStyle.copyWith(color: whiteColor)),
              const SizedBox(height: 10),
              movieList(controller.popularMovies ?? []),
              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }

  SizedBox movieList(List<Movie> movies) {
    return SizedBox(
      height: 240,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        primary: false,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: movies.length,
        separatorBuilder: (c, i) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          Movie? movie = movies[index];
          return MovieCard(
            posterPath: movie.posterPath ?? '',
            title: movie.title ?? 'movie name',
            titleMaxLine: 1,
            rating: movie.voteAverage ?? 0.0,
            ratingCount: movie.voteCount ?? 0,
            onTap: () {
              Get.to(MovieDetailsScreen(movieId: movie.id!));
            },
          );
        },
      ),
    );
  }

  CarouselSlider moviesSlider(HomeScreenController controller) {
    return CarouselSlider.builder(
      options: CarouselOptions(
          height: 250,
          aspectRatio: 16 / 9,
          viewportFraction: 0.5,
          initialPage: 0,
          enableInfiniteScroll: true,
          reverse: false,
          autoPlay: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enlargeCenterPage: true,
          enlargeFactor: 0.3,
          scrollDirection: Axis.horizontal),
      itemCount: controller.trendingMovies?.length,
      itemBuilder: (context, index, pIndex) {
        Movie? movie = controller.trendingMovies?[index];
        return GestureDetector(
          child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network("${Urls.imagePath}${movie?.posterPath}")),
          onTap: () {
            Get.to(MovieDetailsScreen(movieId: movie?.id ?? 0));
          },
        );
      },
    );
  }
}
