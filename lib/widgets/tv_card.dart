import 'package:flutter/material.dart';

import '../models/tv_list_model.dart';
import '../utility/app_colors.dart';
import '../utility/app_text_style.dart';
import '../utility/urls.dart';

class TvCard extends StatelessWidget {
  final TV? tv;
  final VoidCallback onTap;
  const TvCard({super.key, required this.tv, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(color: greyColor, borderRadius: BorderRadius.circular(12)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 1,
                child: Image.network("${Urls.imagePath}${tv?.posterPath}", height: 170, fit: BoxFit.fill)),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("${tv?.name}",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: titleTextStyle.copyWith(fontSize: 18)),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber, size: 18),
                        Text(" ${tv?.voteAverage?.toStringAsPrecision(2)}",
                            style: appTextStyle.copyWith(fontWeight: FontWeight.w500)),
                        Text(" (${tv?.voteCount})", style: appTextStyle),
                      ],
                    ),
                    Row(
                      children: [
                        const Icon(Icons.access_time, color: primaryColor, size: 18),
                        Text(" ${tv?.firstAirDate}", style: appTextStyle),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Text("${tv?.overview}",
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        style: appTextStyle.copyWith(fontSize: 12, color: Colors.white60)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
