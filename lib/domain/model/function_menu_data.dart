import 'package:json_annotation/json_annotation.dart';

part 'function_menu_data.g.dart';

@JsonSerializable()
class FunctionMenuData {
  final String imgUrl;
  final String title;
  final String link;

  FunctionMenuData({
    required this.imgUrl,
    required this.title,
    required this.link,
  });

  factory FunctionMenuData.fromJson(Map<String, dynamic> json) => _$FunctionMenuDataFromJson(json);
  Map<String, dynamic> toJson() => _$FunctionMenuDataToJson(this);

}