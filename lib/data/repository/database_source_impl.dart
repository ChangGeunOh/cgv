import 'package:cgv/data/database/local_database.dart';
import 'package:cgv/domain/model/banner_data.dart';
import 'package:cgv/domain/model/movie_data.dart';

import '../../domain/repository/database_source.dart';

class DatabaseSourceImpl extends DatabaseSource {
  final LocalDatabase _database;

  DatabaseSourceImpl({
    required LocalDatabase database,
  }) : _database = database;

  @override
  Future<void> saveMovieData(MovieData movieData) async {
    await _database.saveMovieData(movieData);
  }

  @override
  Future<List<MovieData>> loadMovieList(MovieType movieType) async {
    return _database.loadMovieList(movieType);
  }

  @override
  Future<void> delete(String table) async {
    await _database.delete(table);
  }


  @override
  Future<List<BannerData>> loadBannerList() async {
    return _database.loadBannerList();
  }

  @override
  Future<void> saveBannerData(BannerData element) async {
    _database.saveBannerData(element);
  }
}
