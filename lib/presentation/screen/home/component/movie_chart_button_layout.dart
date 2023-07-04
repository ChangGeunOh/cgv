import 'package:flutter/material.dart';

import '../../../../common/const/color.dart';
import 'movie_chart_button.dart';

class MovieChartButtonLayout extends StatelessWidget {
  final bool isMovieChart;
  final VoidCallback onTapMovieChart;
  final VoidCallback onTapComingSoon;
  final VoidCallback onTapFullView;

  const MovieChartButtonLayout({
    required this.isMovieChart,
    required this.onTapMovieChart,
    required this.onTapComingSoon,
    required this.onTapFullView,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 20),
        MovieChartButton(
          title: '무비차트',
          onTap: onTapMovieChart,
          isSelected: isMovieChart,
        ),
        const SizedBox(width: 4),
        Container(
          color: const Color(0xFFEAEAEA),
          width: 1,
          height: 10,
        ),
        const SizedBox(width: 4),
        MovieChartButton(
          title: '상영예정',
          onTap: onTapComingSoon,
          isSelected: !isMovieChart,
        ),
        const Spacer(),
        TextButton(
          onPressed: onTapFullView,
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '전체보기',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 12,
                  color: kFullViewTextColor,
                ),
              ),
              Icon(
                Icons.chevron_right,
                size: 13,
                color: kFullViewIconColor,
              ),
            ],
          ),
        ),
      ],
    );
  }
}