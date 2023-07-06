import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/card_data.dart';

abstract class DataStoreSource {
  Future<void> saveFunctionMenuList(List<CardData> functionMenuList);
  Future<List<CardData>> loadFunctionMenuList();

  Future<void> saveEventList(List<CardData> eventList);
  Future<List<CardData>> loadEventList();

  Future<void> saveBandBannerData(BandBannerData bandBannerData);
  Future<BandBannerData?> loadBandBannerData();

  Future<void> saveIceIconList(List<CardData> iceConList);
  Future<List<CardData>?> loadIceIconList();

  Future<void> saveRecommendMovies(List<CardData> list);
  Future<List<CardData>?> loadRecommendMovies();

  Future<void> saveAdEvent(CardData data);
  Future<CardData?> loadAdEvent();

  Future<void> saveAdEventList(List<CardData> list);
  Future<List<CardData>?> loadAdEventList();

}
