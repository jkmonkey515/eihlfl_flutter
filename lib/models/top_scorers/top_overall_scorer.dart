import 'package:flutter/widgets.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_model.dart';
import 'package:get/get.dart';
import 'package:football_hockey/models/gw_teams/gw_team.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/services/gw_teams_service_api.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';

/// Holds an model for the EIHLFL 23-24 Top Scorers > "Top Scorers Overall" Airtable table
class TopOverallScorer implements TopScorerModel {
  String? name;
  String? positions;
  String? team;
  String? nationality;
  int? goals;
  int? assists;
  int? fights;
  int? pPGoal;
  int? sHGoal;
  int? oTPSGWG;
  int? shutout;
  int? hatty;
  int? minorPen;
  int? majorPen;
  int? i10MinPen;
  int? gamePenalty;
  int? teamPen;
  int? i8084SVS;
  int? i8589SVS;
  int? i90SVS;
  int? fLPoints;

  TopOverallScorer(
      {this.name,
      this.positions,
      this.team,
      this.nationality,
      this.goals,
      this.assists,
      this.fights,
      this.pPGoal,
      this.sHGoal,
      this.oTPSGWG,
      this.shutout,
      this.hatty,
      this.minorPen,
      this.majorPen,
      this.i10MinPen,
      this.gamePenalty,
      this.teamPen,
      this.i8084SVS,
      this.i8589SVS,
      this.i90SVS,
      this.fLPoints});

  TopOverallScorer.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    positions = json['Positions'];
    team = json['Team'];
    nationality = json['Nationality'];
    goals = json['Goals'];
    assists = json['Assists'];
    fights = json['Fights'];
    pPGoal = json['PP Goal'];
    sHGoal = json['SH Goal'];
    oTPSGWG = json['OT/PS GWG'];
    shutout = json['Shutout'];
    hatty = json['Hatty'];
    minorPen = json['Minor Pen'];
    majorPen = json['Major Pen'];
    i10MinPen = json['10 Min Pen'];
    gamePenalty = json['Game Penalty'];
    teamPen = json['Team Pen'];
    i8084SVS = json['80-84% SVS'];
    i8589SVS = json['85-89% SVS'];
    i90SVS = json['90+% SVS'];
    fLPoints = json['FL Points'];
  }

  get playerStandings => null;

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Positions'] = positions;
    data['Team'] = team;
    data['Nationality'] = nationality;
    data['Goals'] = goals;
    data['Assists'] = assists;
    data['Fights'] = fights;
    data['PP Goal'] = pPGoal;
    data['SH Goal'] = sHGoal;
    data['OT/PS GWG'] = oTPSGWG;
    data['Shutout'] = shutout;
    data['Hatty'] = hatty;
    data['Minor Pen'] = minorPen;
    data['Major Pen'] = majorPen;
    data['10 Min Pen'] = i10MinPen;
    data['Game Penalty'] = gamePenalty;
    data['Team Pen'] = teamPen;
    data['80-84% SVS'] = i8084SVS;
    data['85-89% SVS'] = i8589SVS;
    data['90+% SVS'] = i90SVS;
    data['FL Points'] = fLPoints;
    return data;
  }

  String? getAbbrevTeamName() {
    if (team == null) return null;
    List<String> splitName = team!.split(' ');
    if (splitName.length >= 2) {
      return splitName[1];
    } else {
      return team;
    }
  }

  String getAbbrevName() {
    var first = name?.split(" ")[0];
    var last = name?.split(" ")[1];

    if (first == null || last == null) {
      return "– –";
    }

    return "${first.characters.firstOrNull?.capitalize} $last";
  }

  String getAbbrevPosition() {
    switch (positions?.toLowerCase() ?? "") {
      case "forward":
        return "FWD";
      case "defenceman":
        return "DEF";
      case "netminder":
        return "NM";
      default:
        return "–";
    }
  }

  int getPoints() {
    return (fLPoints ?? 0);
  }

  String? getTeamName() {
    return team;
  }

  String? getFullName() {
    return name;
  }

  String? getPositionName() {
    return positions;
  }

  String? getTeamImage() {
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

class OverallPlayerPosition {
  HockeyPlayer? forwardLeft;
  HockeyPlayer? forwardCenter;
  HockeyPlayer? forwardRight;
  HockeyPlayer? defenseLeft;
  HockeyPlayer? defenseRight;
  HockeyPlayer? netminder;
}

class OverallPlayerLines {
  OverallPlayerPosition line1 = OverallPlayerPosition();
  OverallPlayerPosition line2 = OverallPlayerPosition();
  OverallPlayerPosition line3 = OverallPlayerPosition();
  OverallPlayerPosition line4 = OverallPlayerPosition();
}

class SquadOverallPlayerTransferObject {
  OverallPlayerLines lines = OverallPlayerLines();
  bool isLoading = true;
  GWTeam? gwTeam;
  int? line;
  SquadOverallPlayerTransferObject({this.line});

  Future<void> _setNetminder() async {
    if (gwTeam?.netminder == null) {
      return;
    }
    var player =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam!.netminder!);
    lines.line1.netminder = player;
    lines.line2.netminder = player;
    lines.line3.netminder = player;
    lines.line4.netminder = player;
  }

  Future<void> _setDefenseLeft() async {
    var l1 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence1 ?? "");
    lines.line1.defenseLeft = l1;

    var l2 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence3 ?? "");
    lines.line2.defenseLeft = l2;

    var l3 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence5 ?? "");
    lines.line3.defenseLeft = l3;
  }

  Future<void> _setDefenseRight() async {
    var l1 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence2 ?? "");
    lines.line1.defenseRight = l1;

    var l2 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence4 ?? "");
    lines.line2.defenseRight = l2;

    var l3 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.defence6 ?? "");
    lines.line3.defenseRight = l3;
  }

  Future<void> _setForwardLeft() async {
    var l1 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward1 ?? "");
    lines.line1.forwardLeft = l1;

    var l2 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward4 ?? "");
    lines.line2.forwardLeft = l2;

    var l3 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward7 ?? "");
    lines.line3.forwardLeft = l3;

    var l4 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward10 ?? "");
    lines.line4.forwardLeft = l4;
  }

  Future<void> _setForwardCenter() async {
    var l1 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward2 ?? "");
    lines.line1.forwardCenter = l1;

    var l2 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward5 ?? "");
    lines.line2.forwardCenter = l2;

    var l3 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward8 ?? "");
    lines.line3.forwardCenter = l3;

    var l4 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward11 ?? "");
    lines.line4.forwardCenter = l4;
  }

  Future<void> _setForwardRight() async {
    var l1 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward3 ?? "");
    lines.line1.forwardRight = l1;

    var l2 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward6 ?? "");
    lines.line2.forwardRight = l2;

    var l3 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward9 ?? "");
    lines.line3.forwardRight = l3;

    var l4 =
        await HockeyPlayerServiceAPI.getPlayerByName(gwTeam?.forward12 ?? "");
    lines.line4.forwardRight = l4;
  }

  /// Returns 'false' on unsuccessful return of the teams, will return true on completion (not necessarily totally successful query)
  Future<bool> getPlayers() async {
    gwTeam = await GWTeamsServiceAPI.getTeamForUser();
    if (gwTeam == null) return false;
    await _setNetminder();
    await _setForwardLeft();
    await _setForwardCenter();
    await _setForwardRight();
    await _setDefenseLeft();
    await _setDefenseRight();
    return true;
  }
}
