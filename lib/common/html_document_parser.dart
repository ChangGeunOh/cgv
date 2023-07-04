import 'package:flutter/material.dart';
import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:html/dom.dart' as html;

import '../domain/model/card_data.dart';

class HtmlDocumentParser {
  final html.Document document;

  HtmlDocumentParser({
    required this.document,
  });

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
    final data = aElement.attributes['onclick'];
    Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
    final link = matches.elementAt(0).group(1) ?? '';
    final imgElement = element.getElementsByTagName('img').first;
    final imgUrl = imgElement.attributes['src'] ?? '';
    return BandBannerData(
      color: colorValue,
      imgUrl: imgUrl,
      link: link,
    );
  }

  List<CardData> getIconConCardList() {
    final cardList = List<CardData>.empty(growable: true);
    final div = document
        .getElementsByClassName('swiper-container icecon-swiper-container')
        .first;
    div.getElementsByClassName('swiper-slide').forEach(
      (element) {
        print(element.innerHtml);
        final title = element.getElementsByTagName('strong').first.text ?? '';
        final imgUrl =
            element.getElementsByTagName('img').first.attributes['src'] ?? '';
        final description = element
            .getElementsByTagName('span')
            .first
            .innerHtml
            .replaceAll('<br>', '\n');
        final aElement = element.getElementsByTagName('a').first;
        final data = aElement.attributes['href'];
        Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
        final link = matches.elementAt(0).group(1) ?? '';

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
      print('--------------------');
      print(element.outerHtml);
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
}

extension ImageElementExtension on html.Element {
  String getImgUrl() {
    final imgElement = getElementsByTagName('img').first;
    return imgElement.attributes['src'] ?? '';
  }

  String getLink() {
    final aElement = getElementsByTagName('a').last;
    final data = aElement.attributes['href'];
    Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
    return matches.elementAt(0).group(1) ?? '';
  }
}
