import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:http/http.dart' as http;

/// A service to connect to the Airtable API for the EIHLFL 23-24 Top Scorers base > "Full Data TPS" table
class HockeyPlayerServiceAPI {
  //Internal list populated whenever getModel() is called
  static List<HockeyPlayer>? _playerListCache;

  static clearCaches() {
    _playerListCache = null;
  }

  //Get the standings of the player from the Airtable API
  static Future<List<HockeyPlayer>?> getAllPlayers() async {
    //Load .env variables
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['overallPlayersBaseId'];
    var tableId = dotenv.env['overallPlayersTableId'];
    var apiKey = dotenv.env['readAPIKey'];

    //Build the list of Models
    List<HockeyPlayer>? airtableTable;

    dynamic getPaginatedData([String? offset]) async {
      var offsetField = "";
      if (offset != null) {
        offsetField = "offset=$offset";
      }

      //Build the URI
      var uri = Uri.parse('$baseUrl/$baseId/$tableId?$offsetField');
      var headers = {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'Application/json',
      };

      try {
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
              airtableTable?.add(HockeyPlayer.fromJson(v['fields']));
            }
          });
        }

        if (json["offset"] != null) {
          //Recursively get the next page:
          await getPaginatedData(json["offset"]);
        }
      } catch (e) {
        AlertService.showToast(
            "There was an issue when attempting to retrieve the overall players ${e.toString()}");
      }
    }

    //Call recursive function
    await getPaginatedData();

    //Save into temporary static local variable
    _playerListCache = airtableTable;

    //Return the table
    return airtableTable;
  }

  /// Get players that are compatible for trading
  static Future<List<HockeyPlayer>?> getTradablePlayersFor(
      HockeyPlayer? player,
      List<HockeyPlayer>? currentTeammates,
      List<HockeyPlayer>? currentPendingTrades) async {
    //Set cache if it is not set

    if (_playerListCache == null) {
      await getAllPlayers();
    }
    if (_playerListCache == null) {
      // If still null, return null
      return null;
    } // Otherwise, continue ->

    var filteredPlayers = [..._playerListCache!];

    // If the target player is not null, filter
    if (player != null) {
      // Sort by positions
      filteredPlayers = filteredPlayers
          .where((element) => element.positions == player.positions)
          .toList();
    }

    // Eliminate existing players on team if applicable so we don't accidently save the same twice
    // O (n*m) - Essentially O(n) as the teams sizes are hypothetically constant
    if (currentTeammates != null && player != null) {
      // Remove players where the name matches to an element in the team list
      filteredPlayers.removeWhere((pendingPlayer) =>
          currentTeammates
              .indexWhere((teammate) => pendingPlayer.name == teammate.name) >=
          0);
    }

    // Eliminate existing trades if applicable so we don't accidently save the same twice
    // O (n*m) - Essentially O(n) as the trade sizes are hypothetically constant
    if (currentPendingTrades != null && player != null) {
      // Remove players where the name matches to an element in the trading list
      filteredPlayers.removeWhere((pendingPlayer) =>
          currentPendingTrades
              .indexWhere((trade) => pendingPlayer.name == trade.name) >=
          0);
    }

    return filteredPlayers;
  }

  //MARK: O(n) complexity -> could be optized in the future by changing List storage to a HashMap keyed by name to allow O(1) complexity
  static Future<HockeyPlayer?> getPlayerByName(String name) async {
    if (_playerListCache == null) {
      //Must call getModel() first
      await getAllPlayers();
    } else if (_playerListCache!.isEmpty) {
      //If the playerList is empty, it means that it has been checked but set to null (refer to _playerList setter in getModel())
      return null;
    }

    var mutablePlayerList = [..._playerListCache!];
    for (var player in mutablePlayerList) {
      if (player.name?.toLowerCase() == name.toLowerCase()) {
        return player;
      }
    }

    return null;
  }
}
