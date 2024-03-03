import 'package:flutter/material.dart';
import 'package:movie_app/utility/urls.dart';

import '../utility/app_text_style.dart';

class MovieCard extends StatelessWidget {
  final String posterPath;
  final String title;
  final double rating;
  final int ratingCount;
  final int? titleMaxLine;
  final VoidCallback onTap;
  const MovieCard({
    super.key,
    required this.posterPath,
    required this.title,
    required this.rating,
    required this.ratingCount,
    required this.onTap,
    this.titleMaxLine,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 150,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child:
                    Image.network("${Urls.imagePath}$posterPath", height: 185, width: 140, fit: BoxFit.fill)),
            const SizedBox(height: 4),
            Text(title, maxLines: titleMaxLine ?? 2, overflow: TextOverflow.ellipsis, style: titleTextStyle),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.center,
              children: [
                const Icon(Icons.star, color: Colors.amber, size: 18),
                Text(" ${rating.toStringAsPrecision(2)}",
                    style: appTextStyle.copyWith(fontWeight: FontWeight.w500)),
                Text(" ($ratingCount)", style: appTextStyle),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
