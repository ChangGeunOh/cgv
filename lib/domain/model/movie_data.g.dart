// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieData _$MovieDataFromJson(Map<String, dynamic> json) => MovieData(
      id: json['id'] as int,
      movieType: $enumDecode(_$MovieTypeEnumMap, json['movieType']),
      ranking: json['ranking'] as int,
      title: json['title'] as String,
      imgPoster: json['imgPoster'] as String,
      percent: json['percent'] as String,
      accumulateCount: json['accumulateCount'] as String,
      eggState: json['eggState'] as String,
      eggPercent: json['eggPercent'] as String,
      screenTypes: Convert.stringToList(json['screenTypes'] as String),
      ageGrade: json['ageGrade'] as String,
      dDay: json['dDay'] as String,
      onlyCGV: json['onlyCGV'] as String,
    );

Map<String, dynamic> _$MovieDataToJson(MovieData instance) => <String, dynamic>{
      'id': instance.id,
      'ranking': instance.ranking,
      'movieType': _$MovieTypeEnumMap[instance.movieType]!,
      'title': instance.title,
      'imgPoster': instance.imgPoster,
      'percent': instance.percent,
      'accumulateCount': instance.accumulateCount,
      'eggState': instance.eggState,
      'eggPercent': instance.eggPercent,
      'screenTypes': Convert.listToString(instance.screenTypes),
      'ageGrade': instance.ageGrade,
      'dDay': instance.dDay,
      'onlyCGV': instance.onlyCGV,
    };

const _$MovieTypeEnumMap = {
  MovieType.movieChart: 'movieChart',
  MovieType.current: 'current',
  MovieType.iceCon: 'iceCon',
  MovieType.artHouse: 'artHouse',
  MovieType.cgvOnly: 'cgvOnly',
};
