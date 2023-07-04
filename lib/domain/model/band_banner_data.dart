import 'package:json_annotation/json_annotation.dart';

part 'band_banner_data.g.dart';

@JsonSerializable()
class BandBannerData {
  final int color;
  final String imgUrl;
  final String link;

  BandBannerData({
    required this.color,
    required this.imgUrl,
    required this.link,
  });

  Map<String, dynamic> toJson() => _$BandBannerDataToJson(this);
  factory BandBannerData.fromJson(Map<String, dynamic> json) => _$BandBannerDataFromJson(json);
}
