import "dart:convert";
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/admin/admin.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:http/http.dart' as http;

/// An admin service to connect to the Airtable API for the Admin base/table
class AdminServiceAPI {
  //Get the standings of the player from the Airtable API
  static Future<Admin?> getModel() async {
    //Load env variables
    var baseUrl = dotenv.env['baseUrl'];
    var baseId = dotenv.env['adminBaseId'];
    var tableId = dotenv.env['adminTableId'];
    var apiKey = dotenv.env['readAPIKey'];

    //Build the list of Models
    Admin? adminModel;

    const sortByAdminID =
        "sort%5B0%5D%5Bfield%5D=Admin+ID&sort%5B0%5D%5Bdirection%5D=asc";
    //Build the URI
    var uri = Uri.parse('$baseUrl/$baseId/$tableId?$sortByAdminID');

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
      if (json['records'][0]["fields"] != null) {
        adminModel = Admin.fromJson(json['records'][0]["fields"]);
      }

      //Return the table
      return adminModel;
    } catch (e) {
      AlertService.showToast(
          "There was a network issue when trying to capture the administrative information");
    }
    return null;
  }
}
