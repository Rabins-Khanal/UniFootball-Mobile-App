import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';

class ApiEndpoints {
  ApiEndpoints._();

  static const Duration connectionTimeout = Duration(seconds: 1000);
  static const Duration receiveTimeout = Duration(seconds: 1000);
  static const String baseUrl = "http://192.168.16.101/api/v1/";
  // For iPhone
  //static const String baseUrl = "http://localhost:3000/api/v1/";

  // ====================== Auth Routes ======================
  static const String login = "auth/login";
  static const String register = "auth/register";
  static const String getAllUsers = "auth/getAllUsers";
  static const String updateUser = "auth/updateUser/";
  static const String deleteUser = "auth/deleteUser/";
  static const String imageUrl = "http://192.168.16.101/uploads/";
  // static const String imageUrl = "http://10.0.2.2:3000/uploads/";
  static const String uploadImage = "auth/uploadImage";

  // ====================== News Routes ======================
  // Endpoint for fetching the news overview
  static String getNewsOverview = 'news/';
  static String getComments = '/comments';
  static String getFixtures = '/fixtures';

  // Endpoint for fetching news details by newsId
  static String getNewsDetails(String newsId) => 'news/$newsId';
  static String getComment(String commentId) => 'comments/$commentId';
  static String getFixture(String commentId) => 'fixtures/$FixtureEntity';
}
