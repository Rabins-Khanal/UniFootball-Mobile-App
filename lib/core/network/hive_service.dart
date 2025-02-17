import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/auth_hive_model.dart';
import '../../features/news/data/model/news_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}/unifootball_app.db';

    Hive.init(path);

    // Register Adapters
    Hive.registerAdapter(AuthHiveModelAdapter());
    Hive.registerAdapter(
        NewsHiveModelAdapter()); // Register the NewsHiveModel adapter
  }

  // Auth Queries
  Future<void> register(AuthHiveModel auth) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.put(auth.userId, auth);
  }

  Future<void> deleteAuth(String id) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    await box.delete(id);
  }

  Future<List<AuthHiveModel>> getAllAuth() async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    return box.values.toList();
  }

  // Login using username and password
  Future<AuthHiveModel?> login(String username, String password) async {
    var box = await Hive.openBox<AuthHiveModel>(HiveTableConstant.userBox);
    var user = box.values.firstWhere((element) =>
        element.username == username && element.password == password);
    box.close();
    return user;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }

  // News Queries
  Future<void> saveNews(List<NewsHiveModel> newsList) async {
    var box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    for (var news in newsList) {
      await box.put(news.newsId, news); // Save news by newsId
    }
  }

  Future<List<NewsHiveModel>> getAllNews() async {
    var box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    return box.values.toList();
  }

  Future<NewsHiveModel?> getNewsById(String newsId) async {
    var box = await Hive.openBox<NewsHiveModel>(HiveTableConstant.newsBox);
    return box.get(newsId);
  }

  Future<void> clearNewsBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.newsBox);
  }
}
