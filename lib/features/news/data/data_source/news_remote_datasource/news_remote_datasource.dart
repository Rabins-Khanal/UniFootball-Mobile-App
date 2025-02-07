import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/news_entity.dart';
import '../../model/news_api_model.dart';
import '../news_data_source.dart';

//Api as the source
class NewsRemoteDataSource implements INewsDataSource {
  final Dio _dio;

  NewsRemoteDataSource(this._dio);

  @override
  Future<List<NewsEntity>> getNewsOverview() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getNewsOverview);

      if (response.statusCode == 200) {
        List<dynamic> data =
            response.data['news']; // Adjust based on API response
        return data
            .map((json) => NewsApiModel.fromJson(json).toEntity())
            .toList();
      } else {
        throw Exception("Failed to fetch news overview");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: $e");
    } catch (e) {
      throw Exception("Error fetching news overview: $e");
    }
  }

  @override
  Future<NewsEntity> getNewsDetails(String newsId) async {
    try {
      Response response = await _dio.get(ApiEndpoints.getNewsDetails(newsId));

      if (response.statusCode == 200) {
        var data = response.data['news']; // Adjust based on API response
        return NewsApiModel.fromJson(data).toEntity();
      } else {
        throw Exception("Failed to fetch news details");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: $e");
    } catch (e) {
      throw Exception("Error fetching news details: $e");
    }
  }
}
