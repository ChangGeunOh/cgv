import 'package:cgv/domain/model/band_banner_data.dart';
import 'package:cgv/domain/model/banner_data.dart';

import '../../../../domain/model/card_data.dart';
import '../../../../domain/model/function_menu_data.dart';
import '../../../../domain/model/movie_data.dart';

class HomeState {
  final int index;
  final int badge;
  final List<BannerData> banners;
  final int currentPage;
  final bool isMovieChart;
  final int indexSubMovieChart;
  final List<MovieData> movieList;
  final List<FunctionMenuData> functionMenuList;
  final List<FunctionMenuData> eventList;
  final BandBannerData? bandBannerData;
  final List<CardData>? iceIconList;
  final List<CardData>? recommendMoviesList;

  HomeState({
    int? index,
    int? badge,
    List<BannerData>? banners,
    int? currentPage,
    bool? isMovieChart,
    int? indexSubMovieChart,
    List<MovieData>? movieList,
    List<FunctionMenuData>? functionMenuList,
    List<FunctionMenuData>? eventList,
    this.bandBannerData,
    this.iceIconList,
    this.recommendMoviesList,
  })  : index = index ?? 0,
        badge = badge ?? 0,
        banners = banners ?? List.empty(),
        currentPage = currentPage ?? 0,
        isMovieChart = isMovieChart ?? true,
        indexSubMovieChart = indexSubMovieChart ?? 0,
        movieList = movieList ?? List.empty(),
        functionMenuList = functionMenuList ?? List.empty(),
        eventList = eventList ?? List.empty();

  HomeState copyWith({
    int? index,
    int? badge,
    int? currentPage,
    List<BannerData>? banners,
    bool? isMovieChart,
    int? indexSubMovieChart,
    List<MovieData>? movieList,
    List<FunctionMenuData>? functionMenuList,
    List<FunctionMenuData>? eventList,
    BandBannerData? bandBannerData,
    List<CardData>? iceIconList,
    List<CardData>? recommendMoviesList,
  }) {
    return HomeState(
      index: index ?? this.index,
      badge: badge ?? this.badge,
      currentPage: currentPage ?? this.currentPage,
      banners: banners ?? this.banners,
      isMovieChart: isMovieChart ?? this.isMovieChart,
      indexSubMovieChart: indexSubMovieChart ?? this.indexSubMovieChart,
      movieList: movieList ?? this.movieList,
      functionMenuList: functionMenuList ?? this.functionMenuList,
      eventList: eventList ?? this.eventList,
      bandBannerData: bandBannerData ?? this.bandBannerData,
      iceIconList: iceIconList ?? this.iceIconList,
      recommendMoviesList: recommendMoviesList ?? this.recommendMoviesList,
    );
  }
}
