import 'package:football_hockey/app_config.dart';

/// Holds an instance of the GW Team Airtable model
class GWTeam {
  String? defence1;
  int? forward12Points;
  int? forward5Points;
  String? forward5;
  int? forward4Points;
  int? forward3Points;
  String? teamCaptain;
  String? forward7;
  int? forward1Points;
  String? forward3;
  String? forward9;
  String? teamSupported;
  String? defence6;
  String? defence2;
  int? defence3Points;
  String? netminder;
  String? teamName;
  int? forward10Points;
  int? points;
  int? netminderPoints;
  String? defence3;
  String? defence5;
  String? forward6;
  String? forward2;
  int? forward7Points;
  int? captain;
  String? forward8;
  int? defence1Points;
  String? defence4;
  String? forward4;
  String? forward12;
  int? forward6Points;
  int? forward11Points;
  String? forward11;
  int? defence4Points;
  int? forward8Points;
  int? defence2Points;
  int? defence5Points;
  int? defence6Points;
  String? forward10;
  String? name;
  int? forward9Points;
  String? forward1;
  int? forward2Points;
  int? highestWeeklyScore;
  int? captainPoints;

  GWTeam(
      {this.defence1,
      this.defence2,
      this.forward12Points,
      this.forward5Points,
      this.forward5,
      this.forward4Points,
      this.forward3Points,
      this.teamCaptain,
      this.forward7,
      this.forward1Points,
      this.forward3,
      this.forward9,
      this.teamSupported,
      this.defence6,
      this.defence3Points,
      this.netminder,
      this.teamName,
      this.forward10Points,
      this.points,
      this.netminderPoints,
      this.defence3,
      this.defence5,
      this.forward6,
      this.forward2,
      this.forward7Points,
      this.captain,
      this.forward8,
      this.defence1Points,
      this.defence4,
      this.forward4,
      this.forward12,
      this.forward6Points,
      this.forward11Points,
      this.forward11,
      this.defence4Points,
      this.forward8Points,
      this.defence2Points,
      this.defence5Points,
      this.defence6Points,
      this.forward10,
      this.name,
      this.forward9Points,
      this.forward1,
      this.forward2Points,
      this.highestWeeklyScore,
      this.captainPoints});

  GWTeam.fromJson(Map<String, dynamic> json) {
    defence1 = json['Defence 1'];

    forward5 = json['Forward 5'];

    teamCaptain = json['Team Captain'];
    forward7 = json['Forward 7'];

    forward3 = json['Forward 3'];
    forward9 = json['Forward 9'];
    teamSupported = json['Team Supported'];
    defence6 = json['Defence 6'];

    netminder = json['Netminder'];
    teamName = json['Team Name'];

    points = json['Points'];

    defence3 = json['Defence 3'];
    defence5 = json['Defence 5'];
    forward6 = json['Forward 6'];
    forward2 = json['Forward 2'];

    captain = json['Captain'];
    forward8 = json['Forward 8'];

    defence4 = json['Defence 4'];
    forward4 = json['Forward 4'];
    forward12 = json['Forward 12'];

    forward11 = json['Forward 11'];
    defence2 = json['Defence 2'];
    forward10 = json['Forward 10'];
    name = json['Name'];

    forward1 = json['Forward 1'];

    highestWeeklyScore = json['Highest Weekly Score'];

    captainPoints = json['Captain Points'];
    forward6Points = json['Forward 6 Points'];
    forward2Points = json['Forward 2 Points'];
    forward9Points = json['Forward 9 Points'];
    defence4Points = json['Defence 4 Points'];
    forward8Points = json['Forward 8 Points'];
    defence2Points = json['Defence 2 Points'];
    defence5Points = json['Defence 5 Points'];
    defence6Points = json['Defence 6 Points'];
    forward11Points = json['Forward 11 Points'];
    defence1Points = json['Defence 1 Points'];
    forward7Points = json['Forward 7 Points'];
    netminderPoints = json['Netminder Points'];
    forward10Points = json['Forward 10 Points'];
    defence3Points = json['Defence 3 Points'];
    forward1Points = json['Forward 1 Points'];
    forward12Points = json['Forward 12 Points'];
    forward5Points = json['Forward 5 Points'];
    forward4Points = json['Forward 4 Points'];
    forward3Points = json['Forward 3 Points'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Defence 1'] = defence1;
    data['Forward 12 Points'] = forward12Points;
    data['Forward 5 Points'] = forward5Points;
    data['Forward 5'] = forward5;
    data['Forward 4 Points'] = forward4Points;
    data['Forward 3 Points'] = forward3Points;
    data['Team Captain'] = teamCaptain;
    data['Forward 7'] = forward7;
    data['Forward 1 Points'] = forward1Points;
    data['Forward 3'] = forward3;
    data['Forward 9'] = forward9;
    data['Team Supported'] = teamSupported;
    data['Defence 6'] = defence6;
    data['Defence 3 Points'] = defence3Points;
    data['Netminder'] = netminder;
    data['Team Name'] = teamName;
    data['Forward 10 Points'] = forward10Points;
    data['Defence 2'] = defence2;
    data['Points'] = points;
    data['Netminder Points'] = netminderPoints;
    data['Defence 3'] = defence3;
    data['Defence 5'] = defence5;
    data['Forward 6'] = forward6;
    data['Forward 2'] = forward2;
    data['Forward 7 Points'] = forward7Points;
    data['Captain'] = captain;
    data['Forward 8'] = forward8;
    data['Defence 1 Points'] = defence1Points;
    data['Defence 4'] = defence4;
    data['Forward 4'] = forward4;
    data['Forward 12'] = forward12;
    data['Forward 6 Points'] = forward6Points;
    data['Forward 11 Points'] = forward11Points;
    data['Forward 11'] = forward11;
    data['Defence 4 Points'] = defence4Points;
    data['Forward 8 Points'] = forward8Points;
    data['Defence 2 Points'] = defence2Points;
    data['Defence 5 Points'] = defence5Points;
    data['Defence 6 Points'] = defence6Points;
    data['Forward 10'] = forward10;
    data['Name'] = name;
    data['Forward 9 Points'] = forward9Points;
    data['Forward 1'] = forward1;
    data['Forward 2 Points'] = forward2Points;
    data['Highest Weekly Score'] = highestWeeklyScore;
    data['Captain Points'] = captainPoints;
    return data;
  }

  String? getTeamImage() {
    switch (teamSupported?.toLowerCase()) {
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

  bool? _isPendingTrading;
  bool? isPendingTrading() {
    return _isPendingTrading;
  }

  void setIsPendingTrading(bool pendingTrading) {
    _isPendingTrading = pendingTrading;
  }
}
