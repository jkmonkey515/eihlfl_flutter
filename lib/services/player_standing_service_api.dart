/// player_standings_service.dart
///
/// This file contains the `PlayerStandingsService` class, which is responsible for interacting with the Airtable API to retrieve and process player standings data for the app.
///
/// Author: Josh Beck
/// Date: 02/02/2024
///
/// # PlayerStandingsService Class
///
/// The `PlayerStandingsService` class provides methods for fetching player standings data from the Airtable API and processing it for consumption within the app. It encapsulates the logic for retrieving, decoding, and handling player standings data, serving as the primary interface for accessing this functionality.
///
/// ## Methods
/// - `fetchPlayerStandings()`: Retrieves player standings data from the Airtable API.
/// - `processPlayerStandings(jsonData)`: Processes the JSON data obtained from the API into a list of `PlayerStanding` objects using the `PlayerStandingDecoder` class.
///
/// ## Example
/// ```dart
/// // Fetching player standings data
/// List<dynamic> jsonData = await PlayerStandingsService.fetchPlayerStandings();
///
/// // Processing JSON data into a list of PlayerStanding objects
/// List<PlayerStanding> playerStandings = PlayerStandingsService.processPlayerStandings(jsonData);
/// ```

import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/standings/player_standing.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:http/http.dart' as http;

class PlayerStandingServiceAPI {
  static List<PlayerStanding>? _standingsCache;
  //Get the standings of the player from the Airtable API

  static clearCaches() {
    _standingsCache = null;
  }

  static Future<List<PlayerStanding>?> getModel() async {
    //Encoded string to sort by Position column in ascending order

    // Load .env variables
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['playerStandingsBaseId'];
    var tableId = dotenv.env['playerStandingsTableId'];
    var apiKey = dotenv.env['readAPIKey'];

    //Build the list of Models
    List<PlayerStanding>? airtableTable;

    dynamic getPaginatedData([String? offset]) async {
      const sortByPosition =
          "sort%5B0%5D%5Bfield%5D=Position&sort%5B0%5D%5Bdirection%5D=asc";

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
              airtableTable?.add(PlayerStanding.fromJson(v['fields']));
            }
          });
        }

        if (json["offset"] != null) {
          //Recursively get the next page:
          await getPaginatedData(json["offset"]);
        }
      } catch (e) {
        AlertService.showToast(
            "There was an issue when attempting to fetch the player standings");
      }
    }

    //Call recursive function
    await getPaginatedData();

    _standingsCache = airtableTable;
    //Return the table
    return airtableTable;
  }

  static Future<String?> getNameFromEmail(String email) async {
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['playerStandingsBaseId'];
    var tableId = dotenv.env['playerStandingsTableId'];
    var apiKey = dotenv.env['readAPIKey'];

    email = email.toLowerCase();
    var filterByEmail = "filterByFormula=LOWER({email}) = LOWER(\"$email\")";
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
    String? name;
    //Add list of records
    if (json['records'] != null &&
        (json['records'] as List).firstOrNull != null &&
        (json['records'] as List).firstOrNull['fields'] != null) {
      name = PlayerStanding.fromJson(
              (json['records'] as List).firstOrNull['fields'])
          .name;
    } //ELSE: No records matching that filter criteria

    return name;
  }

  static Future<List<PlayerStanding>?> getFirstTen() async {
    if (_standingsCache == null) {
      //It has not been set
      await getModel();
    }
    if (_standingsCache == null || (_standingsCache?.length ?? 0) <= 0) {
      return null;
    }
    if ((_standingsCache?.length ?? 0) < 10) return [..._standingsCache!];
    return [..._standingsCache!].take(10).toList();
  }
}
