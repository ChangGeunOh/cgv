import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:html/dom.dart' as html;

import '../domain/model/banner_data.dart';
import '../domain/model/card_data.dart';
import '../domain/model/movie_data.dart';

class HtmlDocumentParser {
  final html.Document document;

  HtmlDocumentParser({
    required this.document,
  });

  List<BannerData> getBannerList() {
    final bannerList = List<BannerData>.empty(growable: true);
    final element = document.getElementsByClassName('swiper-container').first;

    element.getElementsByTagName('img').forEach((element) {
      if (element.attributes['src'] != null) {
        bannerList.add(BannerData(imgBanner: element.attributes['src']));
      }
    });
    element.getElementsByTagName('a').forEachIndexed((index, element) {
      final value = element.getSite();
      if (value.isNotEmpty) {
        if (value.startsWith('http') && index < bannerList.length) {
          final bannerData = bannerList[index];
          bannerData.linkBanner = value;
          bannerList[index] = bannerData;
        }
      }
    });

    return bannerList;
  }

  BandBannerData getBandBannerData() {
    int colorValue = Colors.white.value;
    final element = document
        .getElementsByClassName('eventBannerWrap eventBannerWrap1 noDivision')
        .first;
    final style = element.attributes['style']?.split(';').first;
    if (style != null) {
      final colorCode = style.split(":").last;
      colorValue = Color(int.parse(colorCode.substring(1), radix: 16)).value;
    }
    final aElement = element.getElementsByTagName('a').first;
    final link = aElement.getSite(attribute: 'onclick');
    final imgUrl = element.getImgUrl();
    return BandBannerData(
      color: colorValue,
      imgUrl: imgUrl,
      link: link,
    );
  }

  List<CardData> getFunctionMenuList() {
    final functionMenuList = List<CardData>.empty(growable: true);
    final element = document.getElementsByClassName('functionMenu').firstOrNull;
    element?.getElementsByTagName('li').forEach((element) {
      final title = element.attributes['data-text'];

      final link = element.getLink(attribute: 'onclick');
      final imgUrl = element.getImgUrl();

      if (title != null) {
        final cardData =
            CardData(imgUrl: imgUrl, title: title, link: link);
        functionMenuList.add(cardData);
      }
    });

    return functionMenuList;
  }

  List<MovieData> getMovieList() {
    final movieList = List<MovieData>.empty(growable: true);
    for (var movieType in MovieType.values) {
      final movieListElement = document.getElementById(movieType.className);
      movieListElement?.getElementsByClassName('movieInfo').forEachIndexed(
        (index, element) async {
          final movieData =
              _getMovieDataFromElement(element, index + 1, movieType);
          movieList.add(movieData);
        },
      );
    }
    return movieList;
  }

  MovieData _getMovieDataFromElement(
    html.Element element,
    int index,
    MovieType movieType,
  ) {
    final title = element.getElementsByClassName('cgbMovieTitle').first.text;

    final posterElement = element.getElementsByClassName('imgPoster').first;
    final imgPoster = posterElement.attributes['src'] ??
        posterElement.attributes['data-src']!.split('|').last;

    final badgeWrap = element.getElementsByClassName('badgeWrap').first;

    String onlyCGV = '';
    List<String> screenTypes = [];
    badgeWrap.getElementsByTagName('img').forEachIndexed((index, element) {
      final imgUrl = element.attributes['src'];
      if (imgUrl != null && imgUrl.contains('screenType')) {
        screenTypes.add(imgUrl);
      } else if (imgUrl != null && imgUrl.contains('PosterIcon')) {
        onlyCGV = imgUrl;
      }
    });
    final ageGrade =
        badgeWrap.getElementsByClassName('cgvIcon').firstOrNull?.text ?? '';

    final percent =
        element.getElementsByClassName('per').firstOrNull?.text ?? '';
    final eggState = element
            .getElementsByClassName('cgbMovieChartEgg')
            .first
            .getElementsByTagName('span')
            .first
            .className ??
        '';

    final eggPercent = element
            .getElementsByClassName('cgbMovieChartEgg')
            .first
            .getElementsByTagName('span')
            .first
            .text ??
        '';

    final accumulateCount = element
            .getElementsByClassName('cgvAccumulate')
            .firstOrNull
            ?.getElementsByTagName('span')
            .first
            .text ??
        '';

    final dDay =
        element.getElementsByClassName('movieDday').firstOrNull?.text ?? '';

    return MovieData(
      id: -1,
      ranking: index,
      movieType: movieType,
      title: title,
      imgPoster: imgPoster,
      percent: percent,
      accumulateCount: accumulateCount,
      eggState: eggState,
      eggPercent: eggPercent,
      screenTypes: screenTypes,
      ageGrade: ageGrade,
      dDay: dDay,
      onlyCGV: onlyCGV,
    );
  }

  List<CardData> getEventList() {
    final element =
        document.getElementsByClassName('eventArea_list').firstOrNull;
    final eventList = List<CardData>.empty(growable: true);
    element?.getElementsByTagName('li').forEach((element) {
      final aElement = element.getElementsByTagName('a').first;
      final link = aElement.getSite(attribute: 'onclick');

      final imgUrl = element.getImgUrl();

      final cardData = CardData(
        imgUrl: imgUrl,
        title: '',
        link: link,
      );
      eventList.add(cardData);
    });
    return eventList;
  }

  List<CardData> getIconConCardList() {
    final cardList = List<CardData>.empty(growable: true);
    final div = document
        .getElementsByClassName('swiper-container icecon-swiper-container')
        .first;
    div.getElementsByClassName('swiper-slide').forEach(
      (element) {
        final title = element.getElementsByTagName('strong').first.text ?? '';
        final imgUrl = element.getImgUrl();
        final description = element
            .getElementsByTagName('span')
            .first
            .innerHtml
            .replaceAll('<br>', '\n');
        final aElement = element.getElementsByTagName('a').first;
        final link = aElement.getSite();

        cardList.add(
          CardData(
            title: title,
            imgUrl: imgUrl,
            description: description,
            link: link,
          ),
        );
      },
    );

    return cardList;
  }

  List<CardData> getRecommendMovie() {
    final movies = List<CardData>.empty(growable: true);
    final recommendMovieList =
        document.getElementsByClassName('recommendMovie_list').first;
    recommendMovieList.getElementsByTagName('li').forEach((element) {
      final imgUrl = element.getImgUrl();
      final link = element.getLink();
      final title = element.getElementsByTagName('strong').first.text ?? '';
      final description = element.getElementsByTagName('span').first.text ?? '';
      movies.add(
        CardData(
          title: title,
          imgUrl: imgUrl,
          description: description,
          link: link,
        ),
      );
    });

    return movies;
  }

  CardData getPopAdEvent() {
    int colorInt = 0xffffffff;
    String imgUrl = '';
    final adEventElement =
        document.querySelector('#popAdEvent > div > div > div > a > div');
    if (adEventElement != null) {
      String colorCode = adEventElement.attributes['style']!.replaceAll(
        RegExp(r'[^0-9a-fA-F]'),
        '',
      );
      colorInt = int.parse(colorCode, radix: 16);
      imgUrl = adEventElement.getImgUrl();
    }
    final linkElement =
        document.querySelector('#popAdEvent > div > div > div > a');
    final link = linkElement?.getSite(attribute: 'onclick') ?? '';
    return CardData(title: '', imgUrl: imgUrl, color: colorInt, link: link);
  }

  List<CardData> getPopAdEventList() {
    final eventList = List<CardData>.empty(growable: true);
    final adListElement =
        document.querySelector('#popAdEvent > div > div > div > div');
    adListElement?.getElementsByClassName('swiper-slide').forEach(
      (element) {
        final link = element.getLink(attribute: 'onclick');
        final imgUrl = element.getImgUrl();
        eventList.add(CardData(title: '', imgUrl: imgUrl, link: link));
      },
    );
    return eventList;
  }
}

extension ImageElementExtension on html.Element {
  String getImgUrl() {
    final imgElement = getElementsByTagName('img').first;
    return imgElement.attributes['src']?.replaceAll('\n', '') ?? '';
  }

  String getLink({String? attribute}) {
    final aElement = getElementsByTagName('a').last;
    return aElement.getSite(attribute: attribute);
  }

  String getSite({String? attribute}) {
    final attr = attribute ?? 'href';
    final data = attributes[attr];
    Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
    return matches.elementAt(0).group(1) ?? '';
  }
}
