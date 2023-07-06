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
  final List<CardData> functionMenuList;
  final List<CardData> eventList;
  final BandBannerData? bandBannerData;
  final List<CardData>? iceIconList;
  final List<CardData>? recommendMoviesList;
  final CardData? popEventData;
  final List<CardData>? popEventList;
  final bool isShowTop;
  final bool isPopShow;
  final bool isNotToday;

  HomeState({
    int? index,
    int? badge,
    List<BannerData>? banners,
    int? currentPage,
    bool? isMovieChart,
    int? indexSubMovieChart,
    List<MovieData>? movieList,
    List<CardData>? functionMenuList,
    List<CardData>? eventList,
    this.bandBannerData,
    this.iceIconList,
    this.recommendMoviesList,
    this.popEventData,
    this.popEventList,
    bool? isShowTop,
    bool? isPopShow,
    bool? isNotToday,
  })  : index = index ?? 0,
        badge = badge ?? 0,
        banners = banners ?? List.empty(),
        currentPage = currentPage ?? 0,
        isMovieChart = isMovieChart ?? true,
        indexSubMovieChart = indexSubMovieChart ?? 0,
        movieList = movieList ?? List.empty(),
        functionMenuList = functionMenuList ?? List.empty(),
        eventList = eventList ?? List.empty(),
        isShowTop = isShowTop ?? false,
        isPopShow = isPopShow ?? true,
        isNotToday = isNotToday ?? false;

  HomeState copyWith({
    int? index,
    int? badge,
    int? currentPage,
    List<BannerData>? banners,
    bool? isMovieChart,
    int? indexSubMovieChart,
    List<MovieData>? movieList,
    List<CardData>? functionMenuList,
    List<CardData>? eventList,
    BandBannerData? bandBannerData,
    List<CardData>? iceIconList,
    List<CardData>? recommendMoviesList,
    CardData? popEventData,
    List<CardData>? popEventList,
    bool? isShowTop,
    bool? isPopShow,
    bool? isNotToday,
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
      popEventData: popEventData ?? this.popEventData,
      popEventList: popEventList ?? this.popEventList,
      isShowTop: isShowTop ?? this.isShowTop,
      isPopShow: isPopShow ?? this.isPopShow,
      isNotToday: isNotToday ?? this.isNotToday,
    );
  }
}
