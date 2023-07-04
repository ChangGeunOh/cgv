import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../../../common/const/color.dart';
import '../../../../domain/model/card_data.dart';

class IceConLayout extends StatefulWidget {
  final ValueChanged onTap;
  final ValueChanged onReservation;
  final List<CardData> iceIconList;
  final VoidCallback onTotal;

  const IceConLayout({
    required this.iceIconList,
    required this.onTap,
    required this.onReservation,
    required this.onTotal,
    super.key,
  });

  @override
  State<IceConLayout> createState() => _IceConLayoutState();
}

class _IceConLayoutState extends State<IceConLayout> {
  final PageController _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 520,
      child: Stack(
        children: [
          CachedNetworkImage(
            imageUrl:
            'https://img.cgv.co.kr/WebApp/contents/main/movie/unit/016219035931660.png',
          ),
          Positioned(
            top: 32,
            right: 20,
            child: TotalRoundedButton(onTap: widget.onTotal),
          ),
          Positioned(
            top: 94,
            left: 0,
            right: 0,
            child: SizedBox(
              height: 400,
              child: PageView.builder(
                controller: _pageController,
                itemBuilder: (context, index) {
                  final cardData = widget.iceIconList[index];
                  return IceConCardView(
                    onTap: () => widget.onTap(cardData),
                    onReservation: () => widget.onReservation(cardData),
                    iceConData: widget.iceIconList[index],
                  );
                },
                itemCount: widget.iceIconList.length,
              ),
            ),
          ),
          Positioned(
            left: 20,
            bottom: 16,
            right: 0,
            child: Container(
              width: double.infinity,
              height: 1,
              color: Colors.black12,
            ),
          ),
          Positioned(
            left: 20,
            bottom: 16,
            child: SmoothPageIndicator(
              controller: _pageController,
              count: widget.iceIconList.length,
              axisDirection: Axis.horizontal,
              effect: const SlideEffect(
                  spacing: 0.0,
                  radius: 0.0,
                  dotWidth: 30.0,
                  dotHeight: 1.0,
                  strokeWidth: 0.0,
                  dotColor: Colors.black12,
                  activeDotColor: Colors.indigo),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }
}

class IceConCardView extends StatelessWidget {
  final CardData iceConData;
  final VoidCallback onTap;
  final VoidCallback onReservation;

  const IceConCardView({
    required this.iceConData,
    required this.onTap,
    required this.onReservation,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: iceConData.imgUrl,
            width: 157,
            height: 224,
          ),
          const SizedBox(height: 29),
          Text(
            iceConData.title,
            style: const TextStyle(
              fontSize: 16,
              color: textColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 10),
          if (iceConData.description != null)
            SizedBox(
              width: 258,
              child: Text(
                iceConData.description!,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFFAF6540),
                ),
              ),
            ),
          const SizedBox(height: 10),
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
    );
  }
}

class TotalRoundedButton extends StatelessWidget {
  final VoidCallback onTap;

  const TotalRoundedButton({
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: 20,
        width: 65,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(
            color: Colors.black54,
            width: 0.3,
          ),
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(width: 4),
            Text(
              '전체보기',
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.w300,
                fontSize: 10,
              ),
            ),
            Icon(
              Icons.chevron_right,
              color: Colors.black54,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
