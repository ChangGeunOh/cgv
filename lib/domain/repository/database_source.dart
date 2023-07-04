import 'package:cgv/domain/model/banner_data.dart';
import 'package:cgv/domain/model/movie_data.dart';

abstract class DatabaseSource {
  Future<void> saveMovieData(MovieData movieData);
  Future<List<MovieData>> loadMovieList(MovieType movieType);
  Future<void> saveBannerData(BannerData element);
  Future<List<BannerData>> loadBannerList();
  Future<void> delete(String table);

}