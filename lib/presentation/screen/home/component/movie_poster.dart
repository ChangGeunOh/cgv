import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../common/const/color.dart';
import '../../../../domain/model/movie_data.dart';

class MoviePoster extends StatelessWidget {
  final VoidCallback onTap;
  final VoidCallback onReservation;
  final MovieData movieData;

  const MoviePoster({
    required this.onTap,
    required this.onReservation,
    required this.movieData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 164,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: movieData.imgPoster,
                  ),
                ),
                if (movieData.screenTypes.first.isNotEmpty)
                  Positioned(
                    right: 6,
                    bottom: 6,
                    child: Column(
                      children: movieData.screenTypes
                          .map(
                            (e) => CachedNetworkImage(
                              imageUrl: e,
                              width: 36,
                              height: 12,
                            ),
                          )
                          .toList(),
                    ),
                  ),
                Positioned(
                  bottom: -2,
                  left: 8,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      CachedNetworkImage(
                        imageUrl: movieData.getRankImage(),
                        height: 39,
                      ),
                      const SizedBox(width: 12),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          '${movieData.percent}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontFamily: 'NotoSanKR',
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (movieData.onlyCGV.isNotEmpty)
                  Positioned(
                    left: 0,
                    top: 0,
                    child: CachedNetworkImage(
                      width: 32,
                      height: 32,
                      imageUrl:
                          'https://img.cgv.co.kr/Movie/Thumbnail/PosterIcon/16231991733190.png',
                    ),
                  ),
                Positioned(
                  top: 4,
                  right: 4,
                  child: SvgPicture.asset(
                    movieData.getGradeImage(),
                    width: 20,
                    height: 20,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: Text(
                movieData.title,
                style: const TextStyle(
                  color: textColor,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: movieData.getEggStateImage(),
                  width: 12,
                  height: 15,
                ),
                const SizedBox(width: 4),
                Text(
                  movieData.eggPercent,
                  style: const TextStyle(
                    color: Color(0xff9a9a9a),
                    fontFamily: 'NotoSansKR',
                    fontWeight: FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Container(
                    width: 1,
                    height: 8,
                    color: dividerColor,
                  ),
                ),
                if (movieData.dDay.isNotEmpty)
                  Text(
                    'D-${movieData.dDay}',
                    style: const TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                if (movieData.dDay.isEmpty)
                  Text(
                    '누적관객 ${movieData.accumulateCount}',
                    style: const TextStyle(
                      color: Color(0xff9a9a9a),
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            OutlinedButton(
              onPressed: onReservation,
              style: OutlinedButton.styleFrom(
                  minimumSize: const Size(110, 32),
                  foregroundColor: textColor,
                  backgroundColor: Colors.white,
                  shape: const StadiumBorder(),
                  elevation: 1,
                  side: const BorderSide(color: strokeColor)),
              child: const Text(
                ' 지금예매',
                style: TextStyle(
                  color: textColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
