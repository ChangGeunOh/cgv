import 'package:flutter/material.dart';

import '../../../../domain/model/movie_data.dart';
import 'movie_poster.dart';

class MovieChartLayout extends StatefulWidget {
  final ValueChanged<MovieData> onTap;
  final ValueChanged<MovieData> onReservation;
  final List<MovieData> movieList;

  const MovieChartLayout({
    required this.onTap,
    required this.onReservation,
    required this.movieList,
    super.key,
  });

  @override
  State<MovieChartLayout> createState() => _MovieChartLayoutState();
}

class _MovieChartLayoutState extends State<MovieChartLayout> {
  late final ScrollController _controller;
  bool isShowMovieFirst = false;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
    _controller.addListener(() {
      setState(() {
        isShowMovieFirst = _controller.offset > 1;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 350,
          child: ListView.separated(
            controller: _controller,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final movieData = widget.movieList[index];
              return Padding(
                padding: EdgeInsets.only(left: index == 0 ? 20 : 0),
                child: MoviePoster(
                  onTap: () => widget.onTap(movieData),
                  onReservation: () => widget.onReservation(movieData),
                  movieData: movieData,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox(width: 16);
            },
            itemCount: widget.movieList.length,
          ),
        ),
        if (isShowMovieFirst)
          Positioned(
            top: 100,
            left: 0,
            child: InkWell(
              onTap: () {
                _controller.animateTo(0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.easeIn);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    )),
                width: 42,
                height: 29,
                child: const Padding(
                  padding: EdgeInsets.only(right: 8.0),
                  child: Icon(
                    Icons.chevron_left,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
