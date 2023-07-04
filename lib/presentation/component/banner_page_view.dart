import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/model/banner_data.dart';

class BannerPagerView extends StatefulWidget {
  final List<BannerData> banners;
  final ValueChanged<BannerData> onTap;

  const BannerPagerView({
    required this.banners,
    required this.onTap,
    super.key,
  });

  @override
  State<BannerPagerView> createState() => _BannerPagerViewState();
}

class _BannerPagerViewState extends State<BannerPagerView> {
  final PageController _pageController = PageController(initialPage: 0);
  late final Timer timer;

  int currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(
      const Duration(seconds: 2),
      (timer) {
        if (_pageController.hasClients) {
          _pageController.animateToPage(
            currentPage + 1,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeIn,
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: 160,
          child: PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index) {
              setState(() {
                currentPage = index;
              });
            },
            itemBuilder: (context, index) {
              if (widget.banners.isEmpty) {
                return Container();
              }
              final bannerData = widget.banners[index % widget.banners.length];
              return GestureDetector(
                  onTap: () {
                    widget.onTap(bannerData);
                  },
                  child: CachedNetworkImage(imageUrl: bannerData.imgBanner));
            },
          ),
        ),
        if (widget.banners.isNotEmpty)
          Positioned(
            right: 0,
            bottom: 0,
            child: Container(
              width: 37,
              height: 18,
              color: Colors.black.withAlpha((255 * 0.3).round()),
              alignment: Alignment.center,
              child: Text(
                '${currentPage % widget.banners.length + 1}/${widget.banners.length}',
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  fontSize: 11,
                ),
              ),
            ),
          )
      ],
    );
  }
}
