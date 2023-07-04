import 'package:cgv/common/const/constants.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/repository/network_source.dart';

part 'network_source_impl.g.dart';

@RestApi()
abstract class NetworkSourceImpl extends NetworkSource {

  factory NetworkSourceImpl(Dio dio, {String baseUrl}) = _NetworkSourceImpl;
  // https://m.cgv.co.kr/WebAPP/MovieV4/movieList.aspx?mtype=now&iPage=1
  @override
  @GET('path')
  Future<List<String>> loadBanners();

  @override
  @GET('#none')
  Future<dynamic> loadMovieChart();

}