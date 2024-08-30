import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/top_scorers/top_overall_scorer.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_by_team_per_week.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_model.dart';
import 'package:http/http.dart' as http;

/// A service to connect to the Airtable API for the Top Scorers base/table
class TopStandingsServiceAPI {
  static Uri buildUri<T extends TopScorerModel>([String? pageOffset]) {
    //Load .env variables
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['topStandingsBaseId'];
    var topScorersOverallId = dotenv.env['topScorersOverallId'];
    var topScorersByTeamPerWeekId = dotenv.env['topScorersByTeamPerWeekId'];

    //Encoded string to sort by ID column in ascending order
    const sortByID = "sort%5B0%5D%5Bfield%5D=ID&sort%5B0%5D%5Bdirection%5D=asc";

    //Add the page offset if applicable
    var offsetField = "";
    if (pageOffset != null) {
      offsetField = "&offset=$pageOffset";
    }
    //Build the URI based on the model type passed
    switch (T) {
      case TopOverallScorer:
        return Uri.parse(
            '$baseUrl/$baseId/$topScorersOverallId?$sortByID$offsetField');
      case TopScorerByTeamPerWeek:
        return Uri.parse(
            '$baseUrl/$baseId/$topScorersByTeamPerWeekId?$sortByID$offsetField');
      default:
        throw Exception(
            "top_standings_service_api -> buildUri: Invalid Model Type passed");
    }
  }

  //Get the standings of the player from the Airtable API
  static Future<List<T>?> getModel<T extends TopScorerModel>() async {
    List<T>? airtableTable;

    // Load .env variable
    var apiKey = dotenv.env['readAPIKey'];

    dynamic getPaginatedData([String? offset]) async {
      //Build the URI based on the model type passed
      var uri = buildUri<T>(offset);
      var headers = {
        'Authorization': 'Bearer $apiKey',
        'Accept': 'Application/json',
      };

      //Await the JSON response
      final response = await http.get(uri, headers: headers);

      if (response.statusCode != 200) {
        Exception(response.body);
      } //Unsuccessful return

      //Decode the JSON
      var json = jsonDecode(response.body);

      //Add list of records
      if (json['records'] != null) {
        airtableTable ??= []; //If array is null, assign it to be initialized
        json['records'].forEach((v) {
          if (v['fields'] != null) {
            switch (T) {
              case TopOverallScorer:
                airtableTable?.add(TopOverallScorer.fromJson(v['fields']) as T);
              case TopScorerByTeamPerWeek:
                airtableTable
                    ?.add(TopScorerByTeamPerWeek.fromJson(v['fields']) as T);
              default:
                throw Exception(
                    "top_standings_service_api -> getModel: Invalid Model Type passed");
            }
          } // MARK: Log malformed player standing data
        });
      }

      if (json["offset"] != null) {
        //Recursively get the next page:
        await getPaginatedData(json["offset"]);
      }
    }

    //Call recursive function
    await getPaginatedData();

    //Return list of records
    return airtableTable;
  }

  static Future<List<TopOverallScorer>?> getTopTenPlayers() async {
    // Get all top standing players
    var playerList = await getModel<TopOverallScorer>();
    if (playerList == null || (playerList.length) <= 0) return null;
    if ((playerList.length) < 10) return [...playerList];
    return [...playerList].take(10).toList();
  }
}
