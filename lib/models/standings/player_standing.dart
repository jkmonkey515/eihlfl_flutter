/// player_standing.dart
///
/// The `PlayerStanding` model, which represents the standings of a player in a game. The class is designed to accept JSON data from the Airtable API and provides a structured representation of player statistics and information.
///
/// Author: Josh Beck
/// Date: 02/02/2024
///
/// # PlayerStanding Class
///
/// The `PlayerStanding` class is a model representing the standings of a player in a game. It is designed to accept JSON data from the Airtable API and provides a structured representation of player statistics and information.
///
/// ## Purpose
/// The purpose of the `PlayerStanding` class is to encapsulate the standings data of a player, including scores for different game weeks, email address, total points, team supported, team name, player name, and position, among others. It is designed to provide a clear and organized structure for representing player standings within the app.
///
/// ## JSON Serialization
/// The class is designed to seamlessly consume JSON data from the Airtable API, allowing for easy deserialization of the JSON response into instances of the `PlayerStanding` class. This enables the app to efficiently process and utilize player standings data obtained from the API.
///
/// ## Usage
/// The `PlayerStanding` class can be instantiated with the necessary properties populated from the JSON response, making it a convenient and straightforward way to work with player standings data within the app.
///
/// ## Example
/// ```dart
/// // Example JSON data from Airtable API
/// {
///   "eIHLGW18": 100,
///   "email": "example@example.com",
///   "points": 500,
///   "teamSupported": "Example Team",
///   // Other properties...
/// }
///
/// // Deserialization of JSON data into PlayerStanding instance
/// PlayerStanding player = PlayerStanding.fromJson(jsonData);
/// ```

class PlayerStanding {
  int? eIHLGW18;
  String? email;
  int? points;
  int? eIHLGW4;
  String? teamSupported;
  int? eIHLGW13;
  int? eIHLGW8;
  int? eIHLGW15;
  int? eIHLGW7;
  int? eIHLGW14;
  int? eIHLGW11;
  int? eIHLGW5;
  int? eIHLGW9;
  int? eIHLGW1;
  int? eIHLGW12;
  int? eIHLGW10;
  int? eIHLGW3;
  int? eIHLGW17;
  int? eIHLGW19;
  int? eIHLGW6;
  String? teamName;
  String? name;
  int? eIHLGW16;
  int? eIHLGW2;
  String? position;

  PlayerStanding(
      {this.eIHLGW18,
      this.email,
      this.points,
      this.eIHLGW4,
      this.teamSupported,
      this.eIHLGW13,
      this.eIHLGW8,
      this.eIHLGW15,
      this.eIHLGW7,
      this.eIHLGW14,
      this.eIHLGW11,
      this.eIHLGW5,
      this.eIHLGW9,
      this.eIHLGW1,
      this.eIHLGW12,
      this.eIHLGW10,
      this.eIHLGW3,
      this.eIHLGW17,
      this.eIHLGW19,
      this.eIHLGW6,
      this.teamName,
      this.name,
      this.eIHLGW16,
      this.eIHLGW2,
      this.position});

  PlayerStanding.fromJson(Map<String, dynamic> json) {
    eIHLGW18 = json['EIHL GW18'];
    email = json['Email'];
    points = json['Points'];
    eIHLGW4 = json['EIHL GW4'];
    teamSupported = json['Team Supported'];
    eIHLGW13 = json['EIHL GW13'];
    eIHLGW8 = json['EIHL GW8'];
    eIHLGW15 = json['EIHL GW15'];
    eIHLGW7 = json['EIHL GW7'];
    eIHLGW14 = json['EIHL GW14'];
    eIHLGW11 = json['EIHL GW11'];
    eIHLGW5 = json['EIHL GW5'];
    eIHLGW9 = json['EIHL GW9'];
    eIHLGW1 = json['EIHL GW1'];
    eIHLGW12 = json['EIHL GW12'];
    eIHLGW10 = json['EIHL GW10'];
    eIHLGW3 = json['EIHL GW3'];
    eIHLGW17 = json['EIHL GW17'];
    eIHLGW19 = json['EIHL GW19'];
    eIHLGW6 = json['EIHL GW6'];
    teamName = json['Team Name'];
    name = json['Name'];
    eIHLGW16 = json['EIHL GW16'];
    eIHLGW2 = json['EIHL GW2'];
    position = json['Position'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['EIHL GW18'] = eIHLGW18;
    data['Email'] = email;
    data['Points'] = points;
    data['EIHL GW4'] = eIHLGW4;
    data['Team Supported'] = teamSupported;
    data['EIHL GW13'] = eIHLGW13;
    data['EIHL GW8'] = eIHLGW8;
    data['EIHL GW15'] = eIHLGW15;
    data['EIHL GW7'] = eIHLGW7;
    data['EIHL GW14'] = eIHLGW14;
    data['EIHL GW11'] = eIHLGW11;
    data['EIHL GW5'] = eIHLGW5;
    data['EIHL GW9'] = eIHLGW9;
    data['EIHL GW1'] = eIHLGW1;
    data['EIHL GW12'] = eIHLGW12;
    data['EIHL GW10'] = eIHLGW10;
    data['EIHL GW3'] = eIHLGW3;
    data['EIHL GW17'] = eIHLGW17;
    data['EIHL GW19'] = eIHLGW19;
    data['EIHL GW6'] = eIHLGW6;
    data['Team Name'] = teamName;
    data['Name'] = name;
    data['EIHL GW16'] = eIHLGW16;
    data['EIHL GW2'] = eIHLGW2;
    data['Position'] = position;
    return data;
  }


  String? getName() {
    return name;
  }

  String? getTeamName() {
    return teamName;
  }

  int? getPoints() {
    return points;
  }
}
