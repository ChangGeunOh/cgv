import 'package:json_annotation/json_annotation.dart';

part 'banner_data.g.dart';

@JsonSerializable()
class BannerData {
  late int id;
  late String imgBanner;
  late String linkBanner;

  BannerData({
    int? id,
    String? imgBanner,
    String? linkBanner,
  })  : id = id ?? -1,
        imgBanner = imgBanner ?? '',
        linkBanner = linkBanner ?? '';
  
  Map<String, dynamic> toJson() => _$BannerDataToJson(this);
  factory BannerData.fromJson(Map<String, dynamic> json) => _$BannerDataFromJson(json);
}
