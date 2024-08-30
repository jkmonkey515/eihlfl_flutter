import "dart:convert";
import 'dart:io';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/models/trades/trade.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:football_hockey/services/trading_service.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:football_hockey/utils/errors.dart';
import 'package:http/http.dart' as http;

/// A service to connect to the Airtable API for the Trading base/table
class TradingServiceAPI {
  //Get the standings of the player from the Airtable API
  static Future<Trade?> getTrade(String username) async {
    //Load .env variables
    // Load .env variables
    String baseUrl = dotenv.get('baseUrl');
    String apiKey = dotenv.get('writeAPIKey');
    String baseId = dotenv.get('tradingBaseId');
    String tableId = dotenv.get('tradingTableId');

    //Ensure that the cutoff time is in the future
    List<Trade>? allGWTradesForPlayer;

    dynamic getPaginatedData([String? offset]) async {
      var offsetField = "";
      if (offset != null) {
        offsetField = "&offset=$offset";
      }

      var filterByUsername =
          "filterByFormula=LOWER({Name}) = LOWER(\"$username\")";
      //Ensure that the cutoff time is in the future
      //Build the URI
      var uri =
          Uri.parse('$baseUrl/$baseId/$tableId?$filterByUsername$offsetField');

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
        if (json == null) return null;
        //Add list of records
        //Add list of records
        if (json['records'] != null) {
          allGWTradesForPlayer ??=
              []; //If array is null, assign it to be initialized
          json['records'].forEach((v) {
            if (v['fields'] != null) {
              allGWTradesForPlayer?.add(Trade.fromJson(v['fields'], v['id']));
            }
          });
        }
        if (json["offset"] != null) {
          //Recursively get the next page:
          await getPaginatedData(json["offset"]);
        }
      } catch (e) {
        AlertService.showToast(
            "There was an error whenever trying to fetch trade data");
      }
    }

    //Call recursive function
    await getPaginatedData();

    // If there is a trade that matches the next cutoff date, return that
    for (Trade trade in allGWTradesForPlayer ?? []) {
      if ((trade.gameWeekStartDate ?? 0) >= _getNextCutoffDate()) {
        return trade;
      }
    }

    //Return the table
    return null;
  }

  /// Return null if there were no slots open for trades (indicating too many trades)
  static Trade? injectTradeWithPlayer(
      Trade trade, HockeyPlayer player, HockeyPlayer forPlayer) {
    if (trade.trade1Name == null) {
      trade.trade1Name = player.name;
      trade.tradeFor1Name = forPlayer.name;
      player.tradedFor = forPlayer.name;
      return trade; //Terminate early
    }
    if (trade.trade2Name == null) {
      trade.trade2Name = player.name;
      trade.tradeFor2Name = forPlayer.name;
      player.tradedFor = forPlayer.name;
      return trade; // Terminate early
    }
    if (trade.trade3Name == null) {
      trade.trade3Name = player.name;
      trade.tradeFor3Name = forPlayer.name;
      player.tradedFor = forPlayer.name;
      return trade; //Terminate early
    }

    // Was unable to make a trade, TOO MANY TRADES have been made
    return null;
  }

  static Trade removeTradeFromPlayer(Trade trade, HockeyPlayer player) {
    if (trade.trade3Name == player.name) {
      trade.trade3Name = null;
      trade.tradeFor3Name = null;
      player.tradedFor = null;
    }
    if (trade.trade2Name == player.name) {
      trade.trade2Name = null;
      trade.tradeFor2Name = null;
      player.tradedFor = null;
    }
    if (trade.trade1Name == player.name) {
      trade.trade1Name = null;
      trade.tradeFor1Name = null;
      player.tradedFor = null;
    }

    return trade;
  }

  static Future<void> saveTrade(HockeyPlayer tradePlayer,
      HockeyPlayer forPlayer, Trade trade, String username) async {
    // Load .env variables
    String baseUrl = dotenv.get('baseUrl');
    String apiKey = dotenv.get('writeAPIKey');
    String baseId = dotenv.get('tradingBaseId');
    String tableId = dotenv.get('tradingTableId');

    try {
      //Inject the player

      HttpClient httpClient = HttpClient();
      var url = '$baseUrl/$baseId/$tableId';
      HttpClientRequest request = await httpClient.putUrl(Uri.parse(url));

      request.headers.set('content-type', 'application/json');
      request.headers.set("authorization", 'Bearer $apiKey');

      var jsonObj = jsonEncode({
        "records": [trade.toJson()],
        "performUpsert": {
          "fieldsToMergeOn": ["GW Start Date (MS)", "Name"]
        },
      });
      request.add(utf8.encode(jsonObj));
      await request.close();
    } catch (e) {
      AlertService.showToast(e.toString());
    }
  }

  static int _getNextCutoffDate() {
    DateTime now = DateTime.now().toUtc();
    int daysSinceEpoch = now.millisecondsSinceEpoch ~/ (24 * 60 * 60 * 1000);
    int daysUntilWednesday = (now.weekday - DateTime.wednesday) % 7;
    int millisecondsSinceEpoch =
        (daysSinceEpoch - daysUntilWednesday + 7) * 24 * 60 * 60 * 1000;
    return millisecondsSinceEpoch;
  }

  static Future<String?> attemptTrade(HockeyPlayer player,
      HockeyPlayer forPlayer, List<HockeyPlayer> currentTeam,
      {bool? undo}) async {
    var username = await UserInfoService.getUserName();

    if (username == null) {
      return _getConstraintMessage(TradeErrorType.tradeUnlinkedFromUser);
    }
    //Get the existing trades
    var trade = await getTrade(username);
    trade ??= Trade(
      playerName: username,
      gameWeekStartDate: _getNextCutoffDate(),
    );

    //The trade is able to be completed successfully
    if (undo == null || undo == false) {
      var updatedTrade = injectTradeWithPlayer(trade, player, forPlayer);
      if (updatedTrade == null) {
        return _getConstraintMessage(TradeErrorType.tooManyTrades);
      }

      updatedTrade.playerName = username;
      updatedTrade.gameWeekStartDate = _getNextCutoffDate();
      try {
        await TradingService.checkTrade(
            player, updatedTrade, currentTeam); //Throws TradeError

        await saveTrade(
          player,
          forPlayer,
          trade,
          username,
        );
      } on TradeError catch (e) {
        // A little hacky but is a workaround if the player trade fails to ensure that the "Trade Player" button is still shown
        player.tradedFor = null;
        return _getConstraintMessage(e.type);
      }
    } else {
      var updatedTrade = removeTradeFromPlayer(trade, player);
      updatedTrade.playerName = username;

      await saveTrade(
        player,
        forPlayer,
        trade,
        username,
      );
    }

    return null;
  }

  static String _getConstraintMessage(TradeErrorType tradeError) {
    switch (tradeError) {
      case TradeErrorType.tooManyTrades:
        return "You can only make up to 3 trades.  Please remove a trade before making a new one.";
      case TradeErrorType.notEnoughPositions:
        return "There must be 1 Netminder, 6 Defensemen, and 12 Forwards.  Please remove a trade before making a new one or select the appropriate matching position.";
      case TradeErrorType.notEnoughBritish:
        return "There must be at least 5 British players.  Please select a British player.";
      case TradeErrorType.tooManyFromATeam:
        return "There must NOT be more than 3 players from the same team.  Please remove a trade before making a new one.";
      case TradeErrorType.tradeNotFound:
        return "Trade not found.  Internal error.";
      case TradeErrorType.noCurrentTeam:
        return "There was no current team. Internal error.";
      case TradeErrorType.tradeUnlinkedFromUser:
        return "Trade was not linked to a user. Internal error.";
      default:
        return "An unspecified constraint was violated by this trae";
    }
  }
}
