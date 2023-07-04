import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/card_data.dart';
import 'package:cgv/domain/model/function_menu_data.dart';

abstract class DataStoreSource {
  Future<void> saveFunctionMenuList(List<FunctionMenuData> functionMenuList);
  Future<List<FunctionMenuData>> loadFunctionMenuList();

  Future<void> saveEventList(List<FunctionMenuData> eventList);
  Future<List<FunctionMenuData>> loadEventList();

  Future<void> saveBandBannerData(BandBannerData bandBannerData);
  Future<BandBannerData?> loadBandBannerData();

  Future<void> saveIceIconList(List<CardData> iceConList);
  Future<List<CardData>?> loadIceIconList();

  Future<void> saveRecommendMovies(List<CardData> list);
  Future<List<CardData>?> loadRecommendMovies();
}
