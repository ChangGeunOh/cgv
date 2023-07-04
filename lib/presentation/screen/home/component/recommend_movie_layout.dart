import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';
import '../../../../domain/model/card_data.dart';


class RecommendMovieLayout extends StatelessWidget {
  final List<CardData> recommendMovies;

  const RecommendMovieLayout({
    required this.recommendMovies,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 16.0,
        horizontal: 0.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              '추천 영화',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          const SizedBox(height: 12),
          SizedBox(
            height: 185,
            child: ListView.separated(
              itemCount: recommendMovies.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return RecommendMovieCard(
                  onTap: () {},
                  index: index,
                  cardData: recommendMovies[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(width: 16),
            ),
          ),
        ],
      ),
    );
  }
}

class RecommendMovieCard extends StatelessWidget {
  final int index;
  final VoidCallback onTap;
  final CardData cardData;

  const RecommendMovieCard({
    required this.index,
    required this.onTap,
    required this.cardData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(8),
            ),
            child: CachedNetworkImage(
              width: 201,
              height: 112,
              imageUrl: cardData.imgUrl,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            width: 201,
            height: 60,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(16),
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  Text(
                    cardData.title,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: textColor,
                    ),
                  ),
                  if (cardData.description != null)
                    Text(
                      cardData.description!,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: const TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 10,
                        color: Color(
                          0xff999999,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}