import 'package:uni_football_app/features/fixtures/domain/entity/fixture_entity.dart';

class FixtureModel extends FixtureEntity {
  FixtureModel({
    required super.team1,
    required super.team2,
    required super.team1Logo,
    required super.team2Logo,
    required super.venue,
    required super.date,
  });

  factory FixtureModel.fromJson(Map<String, dynamic> json) {
    return FixtureModel(
      team1: json['team1'],
      team2: json['team2'],
      team1Logo: json['team1Logo'],
      team2Logo: json['team2Logo'],
      venue: json['venue'],
      date: DateTime.parse(json['date']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'team1': team1,
      'team2': team2,
      'team1Logo': team1Logo,
      'team2Logo': team2Logo,
      'venue': venue,
      'date': date.toIso8601String(),
    };
  }
}
