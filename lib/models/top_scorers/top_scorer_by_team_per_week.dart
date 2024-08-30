import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_model.dart';

/// Holds an model for the EIHLFL 23-24 Top Scorers > "Top Scorers by Week by Team" Airtable table
class TopScorerByTeamPerWeek implements TopScorerModel {
  String? name;
  String? positions;
  String? team;
  String? nationality;
  int? fLPoints;
  int? gW1;
  int? gW2;
  int? gW3;
  int? gW4;
  int? gW5;
  int? gW6;
  int? gW7;
  int? gW8;
  int? gW9;
  int? gW10;
  int? gW11;
  int? gW12;
  int? gW13;
  int? gW14;
  int? gW15;
  int? gW16;
  int? gW17;
  int? gW18;
  int? gW19;

  TopScorerByTeamPerWeek(
      {this.name,
      this.positions,
      this.team,
      this.nationality,
      this.fLPoints,
      this.gW1,
      this.gW2,
      this.gW3,
      this.gW4,
      this.gW5,
      this.gW6,
      this.gW7,
      this.gW8,
      this.gW9,
      this.gW10,
      this.gW11,
      this.gW12,
      this.gW13,
      this.gW14,
      this.gW15,
      this.gW16,
      this.gW17,
      this.gW18,
      this.gW19});

  TopScorerByTeamPerWeek.fromJson(Map<String, dynamic> json) {
    name = json['Name'];
    positions = json['Positions'];
    team = json['Team'];
    nationality = json['Nationality'];
    fLPoints = json['FL Points'];
    gW1 = json['GW1'];
    gW2 = json['GW2'];
    gW3 = json['GW3'];
    gW4 = json['GW4'];
    gW5 = json['GW5'];
    gW6 = json['GW6'];
    gW7 = json['GW7'];
    gW8 = json['GW8'];
    gW9 = json['GW9'];
    gW10 = json['GW10'];
    gW11 = json['GW11'];
    gW12 = json['GW12'];
    gW13 = json['GW13'];
    gW14 = json['GW14'];
    gW15 = json['GW15'];
    gW16 = json['GW16'];
    gW17 = json['GW17'];
    gW18 = json['GW18'];
    gW19 = json['GW19'];
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Name'] = name;
    data['Positions'] = positions;
    data['Team'] = team;
    data['Nationality'] = nationality;
    data['FL Points'] = fLPoints;
    data['GW1'] = gW1;
    data['GW2'] = gW2;
    data['GW3'] = gW3;
    data['GW4'] = gW4;
    data['GW5'] = gW5;
    data['GW6'] = gW6;
    data['GW7'] = gW7;
    data['GW8'] = gW8;
    data['GW9'] = gW9;
    data['GW10'] = gW10;
    data['GW11'] = gW11;
    data['GW12'] = gW12;
    data['GW13'] = gW13;
    data['GW14'] = gW14;
    data['GW15'] = gW15;
    data['GW16'] = gW16;
    data['GW17'] = gW17;
    data['GW18'] = gW18;
    data['GW19'] = gW19;
    return data;
  }

  String? getFullName() {
    return name;
  }

  String? getTeamName() {
    return team;
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
