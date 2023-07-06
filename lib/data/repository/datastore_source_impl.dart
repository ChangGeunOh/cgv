import 'package:cgv/data/datastore/local_datastore.dart';
import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/card_data.dart';
import 'package:cgv/domain/model/function_menu_data.dart';

import '../../domain/repository/datastore_source.dart';

const keyIceIconList = 'ice_icon_list';
const keyRecommendMovieList = 'recommend_movie_list';
const keyAdEventData = 'ad_event_data';
const keyAdEventList = 'ad_event_list';

class DataStoreSourceImpl extends DataStoreSource {
  final LocalDataStore _dataStore;

  DataStoreSourceImpl({
    required LocalDataStore dataStore,
  }) : _dataStore = dataStore;

  @override
  Future<void> saveFunctionMenuList(
      List<CardData> functionMenuList,) async {
    await _dataStore.saveFunctionMenuList(functionMenuList);
  }

  @override
  Future<List<CardData>> loadFunctionMenuList() async {
    return await _dataStore.loadFunctionMenuList();
  }

  @override
  Future<List<CardData>> loadEventList() async {
    return await _dataStore.loadEventList();
  }

  @override
  Future<void> saveEventList(List<CardData> eventList) async {
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

  @override
  Future<CardData?> loadAdEvent() async {
    final data = await _dataStore.loadData(keyAdEventData);
    return data != null ? CardData.fromJson(data) : null;
  }
  @override
  Future<void> saveAdEvent(CardData data) async {
    await _dataStore.saveData(keyAdEventData, data);
  }

  @override
  Future<List<CardData>?> loadAdEventList() async {
    final list = await _dataStore.loadListData(keyAdEventList);
    if (list != null) {
      return list.map((e) => CardData.fromJson(e)).toList();
    } else {
      return null;
    }
  }

  @override
  Future<void> saveAdEventList(List<CardData> list) async {
    await _dataStore.saveListData(keyAdEventList, list);
  }
}
