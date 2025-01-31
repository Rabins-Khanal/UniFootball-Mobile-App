import 'package:hive/hive.dart';

import '../../../domain/entity/news_entity.dart';
import '../../model/news_hive_model.dart';
import '../news_data_source.dart';

class NewsLocalDataSource implements INewsDataSource {
  final Box<NewsHiveModel> _newsBox;

  NewsLocalDataSource(this._newsBox);

  @override
  Future<List<NewsEntity>> getNewsOverview() async {
    try {
      final newsList = _newsBox.values.toList();
      return newsList.map((newsHiveModel) => newsHiveModel.toEntity()).toList();
    } catch (e) {
      throw Exception("Error fetching news from local storage: $e");
    }
  }

  @override
  Future<NewsEntity> getNewsDetails(String newsId) async {
    try {
      final newsHiveModel = _newsBox.get(newsId);
      if (newsHiveModel != null) {
        return newsHiveModel.toEntity();
      } else {
        throw Exception("News not found in local storage");
      }
    } catch (e) {
      throw Exception("Error fetching news details from local storage: $e");
    }
  }

  // Save news to local storage
  Future<void> saveNews(List<NewsEntity> newsEntities) async {
    try {
      for (var news in newsEntities) {
        final newsHiveModel = NewsHiveModel.fromEntity(news);
        await _newsBox.put(news.newsId, newsHiveModel);
      }
    } catch (e) {
      throw Exception("Error saving news to local storage: $e");
    }
  }
}
