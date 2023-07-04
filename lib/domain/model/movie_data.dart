import 'package:cgv/common/convert.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_data.g.dart';

@JsonSerializable()
class MovieData {
  late int id;
  final int ranking;
  late MovieType movieType;
  final String title;
  final String imgPoster;
  final String percent;
  final String accumulateCount;
  final String eggState;
  final String eggPercent;
  @JsonKey(
    fromJson: Convert.stringToList,
    toJson: Convert.listToString,
  )
  final List<String> screenTypes;
  final String ageGrade;
  final String dDay;
  final String onlyCGV;

  MovieData({
    required this.id,
    required this.movieType,
    required this.ranking,
    required this.title,
    required this.imgPoster,
    required this.percent,
    required this.accumulateCount,
    required this.eggState,
    required this.eggPercent,
    required this.screenTypes,
    required this.ageGrade,
    required this.dDay,
    required this.onlyCGV,
  });

  // https://img.cgv.co.kr/WebApp/images/common/ico/ico_egg_great_48x48.png
  // https://img.cgv.co.kr/WebApp/images/common/ico/ico_egg_preegg_48x48.png

  String getRankImage() {
    return 'https://img.cgv.co.kr/WebApp/images/main/home/txt_movieInfo_count${ranking.toString().padLeft(2, '0')}.png';
  }

  String getEggStateImage() {
    return eggState == 0
        ? 'https://img.cgv.co.kr/WebApp/images/common/ico/ico_egg_preegg_48x48.png'
        : 'https://img.cgv.co.kr/WebApp/images/common/ico/ico_egg_great_48x48.png';
  }

  String getGradeImage() {
    return 'assets/images/img_rank_$ageGrade.svg'.toLowerCase();
  }

  List<String> getScreenTypeImage() {
    return screenTypes
        .map((e) =>
            'https://img.cgv.co.kr/WebApp/images/main/@3x/ico_screenType$e.png')
        .toList();
  }

  factory MovieData.fromJson(Map<String, dynamic> json) =>
      _$MovieDataFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDataToJson(this);
}

enum MovieType {
  movieChart('movieChartList_0_0'),
  current('movieChartList_0_1'),
  iceCon('movieChartList_0_2'),
  artHouse('movieChartList_0_3'),
  cgvOnly('movieChartList_0_4');

  final String className;
  const MovieType(this.className);
}
