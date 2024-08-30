import 'package:football_hockey/app_config.dart';

/// Holds the Fixture Airtable model
class Fixture {
  String? awayTeam;
  String? homeTeam;
  int? gameWeek;
  int? homeScore;
  int? awayScore;

  Fixture(
      {this.awayTeam,
      this.homeTeam,
      this.gameWeek,
      this.homeScore,
      this.awayScore});

  Fixture.fromJson(Map<String, dynamic> json) {
    awayTeam = json['Away Team'];
    homeTeam = json['Home Team'];
    gameWeek = json['Game Week'];
    homeScore = json['Home Score'];
    awayScore = json['Away Score'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Away Team'] = awayTeam;
    data['Home Team'] = homeTeam;
    data['Game Week'] = gameWeek;
    data['Home Score'] = homeScore;
    data['Away Score'] = awayScore;
    return data;
  }

  String? getHomeTeamLogo() {
    return getTeamImage(homeTeam);
  }

  String? getHomeTeamName() {
    return _helperAbbrev(homeTeam.toString());
  }

  String? getHomeScore() {
    //So no "null" string is ever returned do a ternary
    return homeScore?.toString();
  }

  String? getAwayTeamLogo() {
    return getTeamImage(awayTeam);
  }

  String? getAwayTeamName() {
    return _helperAbbrev(awayTeam.toString());
  }

  String? getAwayScore() {
    //So no "null" string is ever returned do a ternary

    return awayScore?.toString();
  }

  String _helperAbbrev(String input) {
    List<String> words = input.split(' ');
    if (words.length == 1) {
      return words[0];
    } else {
      return words[1];
    }
  }

  String? getTeamImage(String? team) {
    switch (team?.toLowerCase()) {
      case "belfast giants":
        return AppConfigs.images.belfastLogo;
      case "cardiff devils":
        return AppConfigs.images.cardiffLogo;
      case "coventry blaze":
        return AppConfigs.images.coventryLogo;
      case "dundee stars":
        return AppConfigs.images.dundeeLogo;
      case "fife flyers":
        return AppConfigs.images.fifeLogo;
      case "glasgow clan":
        return AppConfigs.images.glasgowLogo;
      case "guildford flames":
        return AppConfigs.images.guildfordLogo;
      case "manchester storm":
        return AppConfigs.images.manchesterLogo;
      case "nottingham panthers":
        return AppConfigs.images.nottinghamLogo;
      case "sheffield steelers":
        return AppConfigs.images.sheffieldLogo;
      default:
        return AppConfigs.images.fantasyLogo;
    }
  }
}
