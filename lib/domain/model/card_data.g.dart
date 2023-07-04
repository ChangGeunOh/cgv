// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'card_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CardData _$CardDataFromJson(Map<String, dynamic> json) => CardData(
      title: json['title'] as String,
      imgUrl: json['imgUrl'] as String,
      description: json['description'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$CardDataToJson(CardData instance) => <String, dynamic>{
      'title': instance.title,
      'imgUrl': instance.imgUrl,
      'link': instance.link,
      'description': instance.description,
    };
