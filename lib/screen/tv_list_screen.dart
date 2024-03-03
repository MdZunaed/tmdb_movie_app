import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie_app/controller/bottom_nav_controller.dart';
import 'package:movie_app/controller/tv_list_controller.dart';
import 'package:movie_app/models/tv_list_model.dart';
import 'package:movie_app/screen/tv_details_screen.dart';
import 'package:movie_app/utility/app_text_style.dart';
import 'package:movie_app/widgets/center_indicator.dart';
import 'package:movie_app/widgets/tv_card.dart';

class TvListScreen extends StatelessWidget {
  const TvListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (pop) {
        Get.find<BottomNavController>().backToHome();
      },
      child: Scaffold(
        appBar: AppBar(title: const Text("TV Show", style: appBarTextStyle)),
        body: GetBuilder<TvListController>(builder: (controller) {
          if (controller.loading) {
            return const CenterIndicator();
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              shrinkWrap: true,
              itemCount: controller.tvList?.length ?? 0,
              separatorBuilder: (c, i) => const SizedBox(height: 8),
              itemBuilder: (context, index) {
                TV? tv = controller.tvList?[index];
                return TvCard(
                  tv: tv,
                  onTap: () {
                    Get.to(() => TvDetailsScreen(tvId: tv?.id ?? 0));
                  },
                );
              },
            ),
          );
        }),
      ),
    );
  }
}
