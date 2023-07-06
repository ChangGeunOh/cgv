import 'package:cgv/common/const/database.dart';
import 'package:cgv/common/html_document_parser.dart';
import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/banner_data.dart';
import 'package:cgv/domain/model/movie_data.dart';
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
    final bannerList = htmlDocumentParser.getBannerList();
    bannerList.forEach(_databaseSource.saveBannerData);

    // MovieChart
    _databaseSource.delete(kTableCGV);
    htmlDocumentParser.getMovieList().forEach((movieData) async {
      await _databaseSource.saveMovieData(movieData);
    });

    // Function Menu
    final functionMenuList = htmlDocumentParser.getFunctionMenuList();
    _dataStoreSource.saveFunctionMenuList(functionMenuList);

    // Event
    final eventList = htmlDocumentParser.getEventList();
    _dataStoreSource.saveEventList(eventList);

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

    // PopUP
    final popEventData = htmlDocumentParser.getPopAdEvent();
    _dataStoreSource.saveAdEvent(popEventData);

    final popEventList = htmlDocumentParser.getPopAdEventList();
    _dataStoreSource.saveAdEventList(popEventList);
  }

  Future<List<MovieData>> loadMovieChart(MovieType movieType) async {
    final list = await _databaseSource.loadMovieList(movieType);
    return list;
  }

  Future<List<BannerData>> loadBannerList() async {
    return await _databaseSource.loadBannerList();
  }

  Future<List<CardData>> loadFunctionMenuList() async {
    return await _dataStoreSource.loadFunctionMenuList();
  }

  Future<List<CardData>> loadEventList() async {
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

  Future<CardData?> loadPopEventData() async {
    return await _dataStoreSource.loadAdEvent();
  }

  Future<List<CardData>?> loadPopEventList() async {
    return await _dataStoreSource.loadAdEventList();
  }
}
