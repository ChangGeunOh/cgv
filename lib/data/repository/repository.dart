import 'package:cgv/common/const/database.dart';
import 'package:cgv/common/html_document_parser.dart';
import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/banner_data.dart';
import 'package:cgv/domain/model/function_menu_data.dart';
import 'package:cgv/domain/model/movie_data.dart';
import 'package:collection/collection.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart';

import '../../domain/model/card_data.dart';
import '../../domain/repository/database_source.dart';
import '../../domain/repository/datastore_source.dart';
import '../../domain/repository/network_source.dart';

class Repository {
  final DatabaseSource _databaseSource;
  final DataStoreSource _dataStoreSource;
  final NetworkSource _networkSource;

  Repository({
    required DatabaseSource databaseSource,
    required DataStoreSource dataStoreSource,
    required NetworkSource networkSource,
  })  : _databaseSource = databaseSource,
        _dataStoreSource = dataStoreSource,
        _networkSource = networkSource;

  Future<void> initMovieChart() async {
    _databaseSource.delete(kTableBanner);

    final document = parse(await _networkSource.loadMovieChart());
    final htmlDocumentParser = HtmlDocumentParser(document: document);

    // BannerData List
    final bannerContainer =
        document.getElementsByClassName('swiper-container').first;
    final bannerList = _getBannerList(bannerContainer);
    bannerList.forEach(_databaseSource.saveBannerData);

    // MovieChart
    _databaseSource.delete(kTableCGV);
    for (var movieType in MovieType.values) {
      final movieListElement = document.getElementById(movieType.className);
      movieListElement?.getElementsByClassName('movieInfo').forEachIndexed(
        (index, element) async {
          final movieData =
              getMovieDataFromElement(element, index + 1, movieType);
          await _databaseSource.saveMovieData(movieData);
        },
      );
    }

    // Function Menu
    final element = document.getElementsByClassName('functionMenu').firstOrNull;
    if (element != null) {
      final functionMenuList = _getFunctionMenuList(element);
      _dataStoreSource.saveFunctionMenuList(functionMenuList);
    }

    // Event
    final eventElement =
        document.getElementsByClassName('eventArea_list').firstOrNull;
    if (eventElement != null) {
      final eventList = _getEventList(eventElement);
      _dataStoreSource.saveEventList(eventList);
    }

    // BandBanner
    final bandBannerData = htmlDocumentParser.getBandBannerData();
    if (bandBannerData.imgUrl.isNotEmpty) {
      _dataStoreSource.saveBandBannerData(bandBannerData);
    }

    // IceCon
    final iceConList = htmlDocumentParser.getIconConCardList();
    _dataStoreSource.saveIceIconList(iceConList);

    // Recommend Movie
    final list = htmlDocumentParser.getRecommendMovie();
    _dataStoreSource.saveRecommendMovies(list);
  }

  List<FunctionMenuData> _getEventList(Element element) {
    final eventList = List<FunctionMenuData>.empty(growable: true);
    element.getElementsByTagName('li').forEach((element) {
      final aElement = element.getElementsByTagName('a').first;
      final data = aElement.attributes['onclick'];
      Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
      final link = matches.elementAt(0).group(1);

      final imgElement = element.getElementsByTagName('img').first;
      final imgUrl = imgElement.attributes['src'];

      if (imgUrl != null && link != null) {
        final functionMenuData = FunctionMenuData(
          imgUrl: imgUrl,
          title: '',
          link: link,
        );
        eventList.add(functionMenuData);
      }
    });
    return eventList;
  }

  List<FunctionMenuData> _getFunctionMenuList(Element element) {
    final functionMenuList = List<FunctionMenuData>.empty(growable: true);
    element.getElementsByTagName('li').forEach((element) {
      final title = element.attributes['data-text'];

      final aElement = element.getElementsByTagName('a').first;
      final data = aElement.attributes['onclick'];
      Iterable<Match> matches = RegExp(r"'([^']*)'").allMatches(data!);
      final link = matches.elementAt(0).group(1);

      final imgElement = element.getElementsByTagName('img').first;
      final imgUrl = imgElement.attributes['src'];

      if (imgUrl != null && link != null && title != null) {
        final functionMenuData =
            FunctionMenuData(imgUrl: imgUrl, title: title, link: link);
        functionMenuList.add(functionMenuData);
      }
    });

    return functionMenuList;
  }

  List<BannerData> _getBannerList(Element element) {
    final bannerList = List<BannerData>.empty(growable: true);

    element.getElementsByTagName('img').forEach((element) {
      if (element.attributes['src'] != null) {
        bannerList.add(BannerData(imgBanner: element.attributes['src']));
      }
    });
    element.getElementsByTagName('a').forEachIndexed((index, element) {
      final value = element.attributes['href'];
      if (value != null) {
        RegExp regex = RegExp(r"'([^']*)'");
        Iterable<Match> matches = regex.allMatches(value);
        final linkBanner = matches.elementAt(0).group(1);
        if (linkBanner!.startsWith('http') && index < bannerList.length) {
          final bannerData = bannerList[index];
          bannerData.linkBanner = linkBanner;
          bannerList[index] = bannerData;
        }
      }
    });

    return bannerList;
  }

  Future<List<MovieData>> loadMovieChart(MovieType movieType) async {
    final list = await _databaseSource.loadMovieList(movieType);
    return list;
  }

  Future<List<BannerData>> loadBannerList() async {
    return await _databaseSource.loadBannerList();
  }

  MovieData getMovieDataFromElement(
    Element element,
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

  Future<List<FunctionMenuData>> loadFunctionMenuList() async {
    return await _dataStoreSource.loadFunctionMenuList();
  }

  Future<List<FunctionMenuData>> loadEventList() async {
    return await _dataStoreSource.loadEventList();
  }

  Future<BandBannerData?> loadBandBannerData() async {
    return await _dataStoreSource.loadBandBannerData();
  }

  Future<List<CardData>?> loadIceIconList() async {
    return _dataStoreSource.loadIceIconList();
  }

  Future<List<CardData>?> loadRecommendMovies() {
    return _dataStoreSource.loadRecommendMovies();
  }
}
