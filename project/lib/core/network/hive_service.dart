import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';

import '../../app/constants/hive_table_constant.dart';
import '../../features/auth/data/model/auth_hive_model.dart';
import '../../features/teams/data/model/teams_hive_model.dart';

class HiveService {
  static Future<void> init() async {
    // Initialize the database
    var directory = await getApplicationDocumentsDirectory();
    var path = '${directory.path}softwarica_user_management.db';

    Hive.init(path);

    // Register Adapters

    Hive.registerAdapter(TeamsHiveModelAdapter());
    Hive.registerAdapter(AuthHiveModelAdapter());
  }

  // Batch Queries
  Future<void> addTeams(TeamsHiveModel teams) async {
    var box = await Hive.openBox<TeamsHiveModel>(HiveTableConstant.teamsBox);
    await box.put(teams.teamsId, teams);
  }

  Future<void> deleteTeams(String id) async {
    var box = await Hive.openBox<TeamsHiveModel>(HiveTableConstant.teamsBox);
    await box.delete(id);
  }

  Future<List<TeamsHiveModel>> getAllTeams() async {
    var box = await Hive.openBox<TeamsHiveModel>(HiveTableConstant.teamsBox);
    return box.values.toList()
      ..sort((a, b) => a.teamsName.compareTo(b.teamsName));
  }

/*
  register box
  {
    fname : "asd",
    lname : "asd",
    batch : {batchId : 1, batchName : "Batch 1"},
    courses : [{courseId : 1, courseName : "Course 1"}, {courseId : 2, courseName : "Course 2"}],
  }
*/

// OR

/*
 {
    fname : "asd",
    lname : "asd",
    batch : 1,
    courses : [1,3,4],
  }
*/

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
    var auth = box.values.firstWhere(
        (element) =>
            element.username == username && element.password == password,
        orElse: () => AuthHiveModel.initial());
    return auth;
  }

  Future<void> clearAll() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.teamsBox);
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  // Clear User Box
  Future<void> clearUserBox() async {
    await Hive.deleteBoxFromDisk(HiveTableConstant.userBox);
  }

  Future<void> close() async {
    await Hive.close();
  }
}
