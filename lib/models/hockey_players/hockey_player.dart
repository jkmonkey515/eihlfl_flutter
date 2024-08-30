import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:get/get.dart';

/// Holds an model for the EIHLFL 23-24 Top Scorers > "Full Data TPS" Airtable table
class HockeyPlayer {
  //Local values
  bool _isCaptian = false;
  String? tradedFor;

  //JSON values
  String? name;
  String? positions;
  String? team;
  String? nationality;
  int? squadNumber;
  int? goals;
  int? assists;
  int? fights;
  int? pPGoal;
  int? sHGoal;
  int? oTPSGWG;
  int? shutout;
  int? hattrick;
  int? minorPen;
  int? majorPen;
  int? s10MinPen;
  int? gamePenalty;
  int? teamPen;
  int? s8084SVS;
  int? s8589SVS;
  int? s90SVS;
  int? nMPTS;
  int? dEFPTS;
  int? fORPTS;
  int? fLPoints;
  int? captain;
  int? iD;

  HockeyPlayer copyWith() {
    return HockeyPlayer(
      name: name,
      positions: positions,
      team: team,
      nationality: nationality,
      squadNumber: squadNumber,
      goals: goals,
      assists: assists,
      fights: fights,
      pPGoal: pPGoal,
      sHGoal: sHGoal,
      oTPSGWG: oTPSGWG,
      shutout: shutout,
      hattrick: hattrick,
      minorPen: minorPen,
      majorPen: majorPen,
      s10MinPen: s10MinPen,
      gamePenalty: gamePenalty,
      teamPen: teamPen,
      s8084SVS: s8084SVS,
      s8589SVS: s8589SVS,
      s90SVS: s90SVS,
      nMPTS: nMPTS,
      dEFPTS: dEFPTS,
      fORPTS: fORPTS,
      fLPoints: fLPoints,
      captain: captain,
      iD: iD,
    );
  }

  HockeyPlayer(
      {this.name,
      this.positions,
      this.team,
      this.nationality,
      this.squadNumber,
      this.goals,
      this.assists,
      this.fights,
      this.pPGoal,
      this.sHGoal,
      this.oTPSGWG,
      this.shutout,
      this.hattrick,
      this.minorPen,
      this.majorPen,
      this.s10MinPen,
      this.gamePenalty,
      this.teamPen,
      this.s8084SVS,
      this.s8589SVS,
      this.s90SVS,
      this.nMPTS,
      this.dEFPTS,
      this.fORPTS,
      this.fLPoints,
      this.captain,
      this.iD});

  HockeyPlayer.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    positions = json['Position'];
    team = json['Team'];
    nationality = json['Nationality'];
    goals = json['Goals'];
    squadNumber = json['Squad Number'];
    assists = json['Assists'];
    fights = json['Fights'];
    pPGoal = json['PP Goal'];
    sHGoal = json['SH Goal'];
    oTPSGWG = json['OT/PS GWG'];
    shutout = json['Shutout'];
    hattrick = json['Hattrick'];
    minorPen = json['Minor Pen'];
    majorPen = json['Major Pen'];
    s10MinPen = json['10 Min Pen'];
    gamePenalty = json['Game Penalty'];
    teamPen = json['Team Pen'];
    s8084SVS = json['80-84% SVS'];
    s8589SVS = json['85-89% SVS'];
    s90SVS = json['90+% SVS'];
    nMPTS = json['N/M PTS'];
    dEFPTS = json['DEF PTS'];
    fORPTS = json['FOR PTS'];
    fLPoints = json['FL Points'];
    captain = json['Captain'];
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Position'] = positions;
    data['Team'] = team;
    data['Nationality'] = nationality;
    data['Squad Number'] = squadNumber;
    data['Goals'] = goals;
    data['Assists'] = assists;
    data['Fights'] = fights;
    data['PP Goal'] = pPGoal;
    data['SH Goal'] = sHGoal;
    data['OT/PS GWG'] = oTPSGWG;
    data['Shutout'] = shutout;
    data['Hattrick'] = hattrick;
    data['Minor Pen'] = minorPen;
    data['Major Pen'] = majorPen;
    data['10 Min Pen'] = s10MinPen;
    data['Game Penalty'] = gamePenalty;
    data['Team Pen'] = teamPen;
    data['80-84% SVS'] = s8084SVS;
    data['85-89% SVS'] = s8589SVS;
    data['90+% SVS'] = s90SVS;
    data['N/M PTS'] = nMPTS;
    data['DEF PTS'] = dEFPTS;
    data['FOR PTS'] = fORPTS;
    data['FL Points'] = fLPoints;
    data['Captain'] = captain;
    data['ID'] = iD;
    return data;
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
    return _isCaptian ? (captain ?? 0) : (fLPoints ?? 0);
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

  void setIsCaptain(bool captian) {
    _isCaptian = captian;
  }

  bool getIsCaptain() {
    return _isCaptian;
  }

  int? getNumber() {
    return squadNumber;
  }

  int getGoals() {
    if (positions == "Netminder") {
      return ((goals) ?? 0) + (s8084SVS ?? 0) + (s8589SVS ?? 0) + (s90SVS ?? 0);
    } else {
      return goals ?? 0;
    }
  }

  String getStatGoalName() {
    if (positions == "Netminder") {
      return "Saves";
    } else {
      return "Goals";
    }
  }

  int getAssists() {
    return assists ?? 0;
  }

  String? getTeamName() {
    return team;
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

  String? getNationalityAbbrev() {
    var nationality = this.nationality ?? "";
    List<String> words = nationality.split(' ');
    String initials = '';
    if (words.length >= 2) {
      initials = words[0][0] + words[1][0];
    } else {
      initials = nationality;
    }
    return initials.toUpperCase();
  }

  String? getFullName() {
    return name;
  }

  String? getPositionName() {
    return positions;
  }

  bool? isBritish() {
    return name?.toUpperCase() != name; // Is NOT uppercased - is british
  }
}
