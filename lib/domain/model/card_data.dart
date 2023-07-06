import 'package:json_annotation/json_annotation.dart';

part 'card_data.g.dart';

@JsonSerializable(genericArgumentFactories: true)
class CardData {
  final String title;
  final String imgUrl;
  final String? link;
  final String? description;
  final int? color;

  const CardData({
    required this.title,
    required this.imgUrl,
    this.description,
    this.link,
    this.color,
  });

  factory CardData.fromJson(Map<String, dynamic> json) => _$CardDataFromJson(json);
  Map<String, dynamic> toJson() => _$CardDataToJson(this);
}