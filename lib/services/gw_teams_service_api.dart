import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/gw_teams/gw_team.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/models/trades/trade.dart';
import 'package:football_hockey/services/admin_service_api.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';
import 'package:football_hockey/services/trading_service_api.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:http/http.dart' as http;

/// A service to connect to the Airtable API for the GW Teams base/table
class GWTeamsServiceAPI {
  //Get the standings of the player from the Airtable API
  static Future<List<GWTeam>?> getAllTeams() async {
    //Load env variables
    var apiKey = dotenv.env['readAPIKey'];
    var baseId = dotenv.env['gwTeamsBaseId'];
    var baseUrl = dotenv.env['baseUrl'];

    //Build the list of Models
    List<GWTeam>? airtableTable;

    //Get the current week admin table ID
    var adminModel = await AdminServiceAPI.getModel();
    var tableId = adminModel?.gWTeamsColumnTableName;

    if (tableId == null) {
      throw Exception(
          "Unable to get tableId from the Admin model for GW Teams table");
    }

    dynamic getPaginatedData([String? offset]) async {
      const sortByPosition =
          "sort%5B0%5D%5Bfield%5D=Name&sort%5B0%5D%5Bdirection%5D=asc";

      var offsetField = "";
      if (offset != null) {
        offsetField = "&offset=$offset";
      }

      //Build the URI
      var uri =
          Uri.parse('$baseUrl/$baseId/$tableId?$sortByPosition$offsetField');
      var headers = {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'Application/json',
      };

      //Await the response
      final response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        throw Exception(response.body);
      }

      //Decode the JSON
      var json = jsonDecode(response.body);

      //Add list of records
      if (json['records'] != null) {
        airtableTable ??= []; //If array is null, assign it to be initialized
        json['records'].forEach((v) {
          if (v['fields'] != null) {
            airtableTable?.add(GWTeam.fromJson(v['fields']));
          }
        });
      }

      if (json["offset"] != null) {
        //Recursively get the next page:
        await getPaginatedData(json["offset"]);
      }
    }

    //Call recursive function
    await getPaginatedData();

    //Return the table
    return airtableTable;
  }

  static Future<GWTeam?> getTeamForUser([String? username]) async {
    //Load env variables
    var apiKey = dotenv.env['readAPIKey'];
    var baseId = dotenv.env['gwTeamsBaseId'];
    var baseUrl = dotenv.env['baseUrl'];

    //Get the current week admin table ID
    var adminModel = await AdminServiceAPI.getModel();
    var tableId = adminModel?.gWTeamsColumnTableName;

    if (tableId == null) {
      // Unable to get tableId from the Admin model for GW Teams table
      return null;
    }
    username ??= await _getUsersName();
    var filterByEmail = "filterByFormula=LOWER({Name}) = LOWER(\"$username\")";
    //Build the URI
    var uri =
        Uri.parse(Uri.encodeFull('$baseUrl/$baseId/$tableId?$filterByEmail'));
    var headers = {
      'Authorization': 'Bearer $apiKey',
      'Accept': 'Application/json',
    };

    //Await the response
    final response = await http.get(uri, headers: headers);

    if (response.statusCode != 200) {
      throw Exception(response.body);
    }

    //Decode the JSON
    var json = jsonDecode(response.body);

    GWTeam? team;
    //Add list of records
    if (json['records'][0]['fields'] != null) {
      team = GWTeam.fromJson(json['records'][0]['fields']);
    }

    return team;
  }

  static Future<(List<HockeyPlayer>?, HockeyPlayer?)> getTeamPlayerList(
      [String? username, bool? onlyWeeklyPoints]) async {
    var team = await getTeamForUser(username);
    if (team == null) return (null, null);

    HockeyPlayer? captian;
    List<HockeyPlayer> playerList = [];

    Map<String?, int?> playerNames = {
      team.netminder: team.netminderPoints,
      team.defence1: team.defence1Points,
      team.defence2: team.defence2Points,
      team.defence3: team.defence3Points,
      team.defence4: team.defence4Points,
      team.defence5: team.defence5Points,
      team.defence6: team.defence6Points,
      team.forward1: team.forward1Points,
      team.forward2: team.forward2Points,
      team.forward3: team.forward3Points,
      team.forward4: team.forward4Points,
      team.forward5: team.forward5Points,
      team.forward6: team.forward6Points,
      team.forward7: team.forward7Points,
      team.forward8: team.forward8Points,
      team.forward9: team.forward9Points,
      team.forward10: team.forward10Points,
      team.forward11: team.forward11Points,
      team.forward12: team.forward12Points,
    };

    for (var name in playerNames.keys) {
      var points = playerNames[name];
      if (name != null) {
        HockeyPlayer? player =
            await HockeyPlayerServiceAPI.getPlayerByName(name);
        if (player == null) continue; // Skip iteration

        if (player.name?.toLowerCase() == team.teamCaptain?.toLowerCase()) {
          var copyPlayer = player.copyWith();
          if (onlyWeeklyPoints == true) {
            copyPlayer.fLPoints = points;
            copyPlayer.captain = team.captainPoints;
          }

          captian = copyPlayer;
        } else {
          // Save the points from the GWTeam object to the HockyPlayer object
          var copyPlayer = player.copyWith();

          if (onlyWeeklyPoints == true) {
            copyPlayer.fLPoints = points;
            copyPlayer.captain = null;
          }

          playerList.add(copyPlayer);
        }
      }
    }
    captian
        ?.setIsCaptain(true); //Set as captain for points calculations / display
    return (playerList, captian);
  }

  static Future<(List<HockeyPlayer>? traded, List<HockeyPlayer>? untraded)>
      getTradesFromPlayerList() async {
    //Get trades for the user (if any exist)
    var name = await _getUsersName();
    if (name == null) {
      return (null, null); //If the username is unretrievable, return null
    }

    Trade? trade = await TradingServiceAPI.getTrade(name);
    var playerListTuple = await getTeamPlayerList();
    var captian = playerListTuple.$2;
    var playerList = playerListTuple.$1;
    if (playerList == null || captian == null) {
      return (null, null);
    }

    // Inject the captian at the appropriate position
    if (captian.positions == "netminder") {
      //Inject at first index
      playerList.insert(0, captian);
    } else {
      var firstIndex = playerList
          .indexWhere((element) => element.positions == captian.positions);
      playerList.insert(firstIndex, captian);
    }

    List<HockeyPlayer>? tradedPlayers;

    // Find the index of a trade in the player list if the name is not null
    int? searchIndex = getIndexOfTrade(trade?.trade1Name, playerList);
    if (searchIndex != null && searchIndex != -1) {
      var removedElement = playerList.removeAt(searchIndex);
      tradedPlayers ??= [];
      removedElement.tradedFor = trade?.tradeFor1Name;
      tradedPlayers.add(removedElement);
    }

    // Check the second trade value
    searchIndex = getIndexOfTrade(trade?.trade2Name, playerList);
    if (searchIndex != null && searchIndex != -1) {
      var removedElement = playerList.removeAt(searchIndex);
      tradedPlayers ??= [];
      removedElement.tradedFor = trade?.tradeFor2Name;
      tradedPlayers.add(removedElement);
    }

    // Check the third trade value
    searchIndex = getIndexOfTrade(trade?.trade3Name, playerList);
    if (searchIndex != null && searchIndex != -1) {
      var removedElement = playerList.removeAt(searchIndex);
      tradedPlayers ??= [];
      removedElement.tradedFor = trade?.tradeFor3Name;
      tradedPlayers.add(removedElement);
    }

    return (tradedPlayers, playerList);
  }

  static int? getIndexOfTrade(
      String? tradeName, List<HockeyPlayer> playerList) {
    return tradeName != null
        ? playerList.indexWhere(
            (player) => player.name?.toLowerCase() == tradeName.toLowerCase())
        : null;
  }

  static Future<String?> _getUsersName() async {
    var name = await UserInfoService.getUserName();
    if (name == null) {
      var email = await UserInfoService.getUserEmail();

      if (email != null) {
        await UserInfoService.saveUserName(email);
        name = await UserInfoService.getUserName();
      }
    }
    return name;
  }
}
