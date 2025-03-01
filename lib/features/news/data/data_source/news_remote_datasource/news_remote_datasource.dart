import 'package:dio/dio.dart';

import '../../../../../app/constants/api_endpoints.dart';
import '../../../domain/entity/news_entity.dart';
import '../../model/news_api_model.dart';
import '../news_data_source.dart';

// API as the source
class NewsRemoteDataSource implements INewsDataSource {
  final Dio _dio;

  NewsRemoteDataSource(this._dio);

  @override
  Future<List<NewsEntity>> getNewsOverview() async {
    try {
      Response response = await _dio.get(ApiEndpoints.getNewsOverview);

      if (response.statusCode == 200) {
        // Ensure response structure is correct
        final jsonData = response.data;
        if (jsonData != null &&
            jsonData["success"] == true &&
            jsonData.containsKey("data")) {
          List<dynamic> data = jsonData["data"];

          if (data.isNotEmpty) {
            return data
                .map((json) => NewsApiModel.fromJson(json).toEntity())
                .toList();
          } else {
            throw Exception("News list is empty or null");
          }
        } else {
          throw Exception("Invalid response format or missing 'data' key");
        }
      } else {
        throw Exception(
            "Failed to fetch news overview: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Error fetching news overview: $e");
    }
  }

  @override
  Future<NewsEntity> getNewsDetails(String newsId) async {
    try {
      Response response = await _dio.get(ApiEndpoints.getNewsDetails(newsId));

      if (response.statusCode == 200) {
        final jsonData = response.data;

        if (jsonData != null &&
            jsonData["success"] == true &&
            jsonData.containsKey("data")) {
          var data = jsonData["data"];

          if (data != null) {
            return NewsApiModel.fromJson(data).toEntity();
          } else {
            throw Exception("News details data is null");
          }
        } else {
          throw Exception("Invalid response format or missing 'data' key");
        }
      } else {
        throw Exception("Failed to fetch news details: ${response.statusCode}");
      }
    } on DioException catch (e) {
      throw Exception("Dio error: ${e.message}");
    } catch (e) {
      throw Exception("Error fetching news details: $e");
    }
  }
}
