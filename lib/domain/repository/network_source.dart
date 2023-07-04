abstract class NetworkSource {
  Future<List<String>> loadBanners();

  Future<dynamic> loadMovieChart();
}