import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/tv_details_controller.dart';
import 'package:movie_app/models/tv_details_model.dart';
import 'package:movie_app/utility/app_text_style.dart';
import 'package:movie_app/utility/urls.dart';
import 'package:movie_app/widgets/center_indicator.dart';

import '../utility/app_colors.dart';

class TvDetailsScreen extends StatefulWidget {
  final int tvId;
  const TvDetailsScreen({super.key, required this.tvId});

  @override
  State<TvDetailsScreen> createState() => _TvDetailsScreenState();
}

class _TvDetailsScreenState extends State<TvDetailsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      Get.find<TvDetailsController>().getTvDetails(widget.tvId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: Text(widget.tvId.toString(), style: appBarTextStyle)),
      body: GetBuilder<TvDetailsController>(builder: (controller) {
        final tv = controller.tvDetailsModel;
        if (controller.loading) {
          return const CenterIndicator();
        }
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network("${Urls.imagePath}${tv.backdropPath}"),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    Text(tv.name ?? "Series Name", style: titleTextStyle.copyWith(fontSize: 26)),
                    rating(tv),
                    const SizedBox(height: 8),
                    detailsContainer(tv),
                    const SizedBox(height: 10),
                    const Text("Seasons", style: appBarTextStyle),
                    const SizedBox(height: 10),
                    tv.seasons?.first.posterPath == null
                        ? const SizedBox(
                            height: 40, child: Center(child: Text("Not found!", style: appTextStyle)))
                        : seasonsCard(tv),
                    const SizedBox(height: 10),
                    const Text("Genre", style: appBarTextStyle),
                    const SizedBox(height: 10),
                    genre(tv),
                    const SizedBox(height: 10),
                    const Text("Overview", style: appBarTextStyle),
                    Text(tv.overview ?? "overview", style: appTextStyle),
                    const SizedBox(height: 10),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    );
  }

  SizedBox seasonsCard(TvDetailsModel tv) {
    return SizedBox(
      height: 190,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        primary: false,
        itemCount: tv.seasons?.length ?? 0,
        separatorBuilder: (c, i) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  "${Urls.imagePath}${tv.seasons?[index].posterPath}",
                  width: 127,
                ),
              ),
              Container(
                alignment: Alignment.bottomLeft,
                clipBehavior: Clip.antiAlias,
                height: 190,
                width: 127,
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: blackColor,
                    borderRadius: BorderRadius.circular(10),
                    gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [blackColor.withOpacity(0.1), blackColor.withOpacity(0.9)])),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tv.seasons?[index].name ?? "Season: ${index + 1}", style: appTextStyle),
                    Text("Total Ep: ${tv.seasons?[index].episodeCount}", style: appTextStyle),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  SingleChildScrollView genre(TvDetailsModel tv) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: tv.genres!
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

  Container detailsContainer(TvDetailsModel tv) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Status: ${tv.status}", style: appTextStyle),
          Text("Language: ${tv.spokenLanguages?[0].englishName}", style: appTextStyle),
          Text("Total season: ${tv.numberOfSeasons}", style: appTextStyle),
          Text("Total episode: ${tv.numberOfEpisodes}", style: appTextStyle),
          //Text("Release date: ${tv.releaseDate}", style: appTextStyle),
        ],
      ),
    );
  }

  Wrap rating(TvDetailsModel tv) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text("Rating: ", style: titleTextStyle.copyWith(fontSize: 16, color: whiteColor)),
        const Icon(Icons.star, color: Colors.amber, size: 18),
        Text(" ${tv.voteAverage?.toStringAsPrecision(2)}",
            style: appTextStyle.copyWith(fontWeight: FontWeight.w500)),
        Text(" (${tv.voteCount})", style: appTextStyle),
      ],
    );
  }
}
