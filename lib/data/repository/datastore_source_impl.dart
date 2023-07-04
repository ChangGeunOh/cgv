import 'package:cgv/data/datastore/local_datastore.dart';
import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/card_data.dart';
import 'package:cgv/domain/model/function_menu_data.dart';

import '../../domain/repository/datastore_source.dart';

const keyIceIconList = 'ice_icon_list';
const keyRecommendMovieList = 'recommend_movie_list';

class DataStoreSourceImpl extends DataStoreSource {
  final LocalDataStore _dataStore;

  DataStoreSourceImpl({
    required LocalDataStore dataStore,
  }) : _dataStore = dataStore;

  @override
  Future<void> saveFunctionMenuList(
    List<FunctionMenuData> functionMenuList,
  ) async {
    await _dataStore.saveFunctionMenuList(functionMenuList);
  }

  @override
  Future<List<FunctionMenuData>> loadFunctionMenuList() async {
    return await _dataStore.loadFunctionMenuList();
  }

  @override
  Future<List<FunctionMenuData>> loadEventList() async {
    return await _dataStore.loadEventList();
  }

  @override
  Future<void> saveEventList(List<FunctionMenuData> eventList) async {
    await _dataStore.saveEventList(eventList);
  }

  @override
  Future<BandBannerData?> loadBandBannerData() async {
    return _dataStore.loadBandBannerData();
  }

  @override
  Future<void> saveBandBannerData(BandBannerData bandBannerData) async {
    _dataStore.saveBandBannerData(bandBannerData);
  }

  @override
  Future<List<CardData>?> loadIceIconList() async {
    final list = await _dataStore.loadListData(keyIceIconList);
    return list?.map((e) => CardData.fromJson(e)).toList();
  }

  @override
  Future<void> saveIceIconList(List<CardData> iceConList) async {
    print('saveIceIconList>${iceConList.length}');
    _dataStore.saveListData(keyIceIconList, iceConList);
  }

  @override
  Future<List<CardData>?> loadRecommendMovies() async {
    final list = await _dataStore.loadListData(keyRecommendMovieList);
    return list?.map((e) => CardData.fromJson(e)).toList();
  }

  @override
  Future<void> saveRecommendMovies(List<CardData> list) async {
    await _dataStore.saveListData(keyRecommendMovieList, list);
  }
}
