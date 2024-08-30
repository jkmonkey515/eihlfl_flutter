import 'dart:collection';
import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/fixtures/fixture.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:http/http.dart' as http;

/// A service to connect to the Airtable API for the Fixtures base/table
class FixturesServiceAPI {
  //Get the standings of the player from the Airtable API
  static Future<SplayTreeMap<String, List<Fixture>>?> getModel() async {
    //Build the list of Models
    List<Fixture>? airtableTable;

    //Load env variables
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['fixturesBaseId'];
    var tableId = dotenv.env['fixturesTableId'];
    var apiKey = dotenv.env['readAPIKey'];

    dynamic getPaginatedData([String? offset]) async {
      const sortByPosition =
          "sort%5B0%5D%5Bfield%5D=Game%20Week&sort%5B0%5D%5Bdirection%5D=asc";

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
              airtableTable?.add(Fixture.fromJson(v['fields']));
            }
          });
        }

        if (json["offset"] != null) {
          //Recursively get the next page:
          await getPaginatedData(json["offset"]);
        }
      } catch (e) {
        AlertService.showToast(
            "There was a network issue whenever trying to fetch fixture data");
      }
    }

    //Call recursive function
    await getPaginatedData();
    if (airtableTable == null) {
      return null;
    }

    SplayTreeMap<String, List<Fixture>> sortedAirtable =
        SplayTreeMap<String, List<Fixture>>();
    for (Fixture fixture in airtableTable!) {
      if (fixture.gameWeek == null) {
        continue; //Skip over as there is no gameWeek
      }

      int gW = fixture.gameWeek!;

      //TODO: This is technically view controller logic and not service logic; future iterations need a new view model object
      String key = "Game Week $gW";

      if (sortedAirtable[key] == null) sortedAirtable[key] = [];

      sortedAirtable[key] = (sortedAirtable[key] as List<Fixture>) + [fixture];
    }

    //Return the table
    return sortedAirtable;
  }
}
