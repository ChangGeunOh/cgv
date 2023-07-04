import 'dart:convert';

import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/card_data.dart';
import 'package:cgv/domain/model/function_menu_data.dart';
import 'package:shared_preferences/shared_preferences.dart';

const keyFunctionMenuList = "function_menu_list";
const keyEventList = "event_list";
const keyBandBannerData = 'band_banner_data';

class LocalDataStore {
  SharedPreferences? _sharedPreferences;

  Future<SharedPreferences> getSharedPreferences() async {
    _sharedPreferences ??= await SharedPreferences.getInstance();
    return _sharedPreferences!;
  }

  Future<void> saveFunctionMenuList(
      List<FunctionMenuData> functionMenuList) async {
    final dataStore = await getSharedPreferences();
    final data = functionMenuList.map((e) => jsonEncode(e.toJson())).toList();
    await dataStore.setStringList(keyFunctionMenuList, data);
  }

  Future<List<FunctionMenuData>> loadFunctionMenuList() async {
    final dataStore = await getSharedPreferences();
    final list =
        dataStore.getStringList(keyFunctionMenuList) ?? List<String>.empty();
    return list.map((e) => FunctionMenuData.fromJson(jsonDecode(e))).toList();
  }

  Future<void> saveEventList(List<FunctionMenuData> eventList) async {
    final dataStore = await getSharedPreferences();
    await dataStore.setStringList(
      keyEventList,
      eventList.map((e) => jsonEncode(e)).toList(),
    );
  }

  Future<List<FunctionMenuData>> loadEventList() async {
    final dataStore = await getSharedPreferences();
    return dataStore
            .getStringList(keyEventList)
            ?.map((e) => FunctionMenuData.fromJson(jsonDecode(e)))
            .toList() ??
        List.empty();
  }

  Future<BandBannerData?> loadBandBannerData() async {
    final dataStore = await getSharedPreferences();
    final data = dataStore.getString(keyBandBannerData);
    return data != null ? BandBannerData.fromJson(jsonDecode(data)) : null;
  }

  Future<void> saveBandBannerData(BandBannerData bandBannerData) async {
    saveData(keyBandBannerData, bandBannerData);
  }

  Future<dynamic> loadData<T>(String key) async {
    final dataStore = await getSharedPreferences();
    final data = dataStore.getString(key);
    if (data != null) {
      return jsonDecode(data);
    } else {
      return null;
    }
  }

  Future<void> saveData<T>(String key, T data) async {
    final dataStore = await getSharedPreferences();
    dataStore.setString(key, jsonEncode(data));
  }

  Future<List?> loadListData<T>(String key) async {
    final dataStore = await getSharedPreferences();
    final list = dataStore.getStringList(key);

    if (list != null) {
      return list.map((e) => jsonDecode(e)).toList();
    } else {
      return null;
    }
  }

  Future<void> saveListData<T>(String key, List<T> list) async {
    final dataStore = await getSharedPreferences();
    final encodedList = list.map((e) => jsonEncode(e)).toList();
    await dataStore.setStringList(key, encodedList);
  }
}
