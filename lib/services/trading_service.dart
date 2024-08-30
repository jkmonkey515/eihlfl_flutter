import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/models/trades/trade.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';
import 'package:football_hockey/utils/errors.dart';

/// An internal service for Trading logic
class TradingService {
  static Future<void> checkTrade(HockeyPlayer player, Trade? trades,
      List<HockeyPlayer>? currentTeam) async {
    if (currentTeam == null) throw TradeError(TradeErrorType.noCurrentTeam);

    var mutableTeam = [...currentTeam];
    // Remove the player from consideration
    if (trades?.trade1Name == player.name) {
      mutableTeam.remove(player);
    }
    if (trades?.trade2Name == player.name) {
      mutableTeam.remove(player);
    }
    if (trades?.trade3Name == player.name) {
      mutableTeam.remove(player);
    }

    // Inject the traded players into the consideration for the future
    if (trades?.tradeFor1Name != null) {
      var tradedForPlayer =
          await HockeyPlayerServiceAPI.getPlayerByName(trades!.tradeFor1Name!);
      if (tradedForPlayer != null) mutableTeam.add(tradedForPlayer);
    }

    if (trades?.tradeFor2Name != null) {
      var tradedForPlayer =
          await HockeyPlayerServiceAPI.getPlayerByName(trades!.tradeFor2Name!);
      if (tradedForPlayer != null) mutableTeam.add(tradedForPlayer);
    }

    if (trades?.tradeFor3Name != null) {
      var tradedForPlayer =
          await HockeyPlayerServiceAPI.getPlayerByName(trades!.tradeFor3Name!);
      if (tradedForPlayer != null) mutableTeam.add(tradedForPlayer);
    }

    // CHECKS :

    // CHECK #1 - Must not be more than 3 current players from one team
    Map<String, int> playerTeamCounts = {};
    for (HockeyPlayer player in mutableTeam) {
      var team = player.team!;

      // Ignore the captain as the captain is a duplicate
      if (playerTeamCounts.containsKey(player.team) &&
          player.getIsCaptain() == false) {
        playerTeamCounts[team] = playerTeamCounts[team]! + 1;
      } else {
        playerTeamCounts[team] = 1;
      }
    }

    const defaultReturn = MapEntry("default", -1);
    var moreThanThree = playerTeamCounts.entries.firstWhere(
        (element) => element.value > 3,
        orElse: () => defaultReturn);

    if (moreThanThree.value != defaultReturn.value) {
      throw TradeError(TradeErrorType.tooManyFromATeam);
    }

    // CHECK #2 - Must be at least 5 British players (add isBritish parameter to the function)
    var totalBrits = 0;
    for (HockeyPlayer player in mutableTeam) {
      if (player.isBritish() ?? false) totalBrits += 1;
    }

    if (totalBrits < 5) {
      TradeError(TradeErrorType.notEnoughBritish);
    }

    // Must be the correct number of each position [1 netminder, 6 defensemen, 12 forwards]
    var netminderCount = 0;
    var defenseCount = 0;
    var forwardCount = 0;

    for (HockeyPlayer player in mutableTeam) {
      if (player.positions?.toLowerCase() == "netminder") netminderCount += 1;
      if (player.positions?.toLowerCase() == "defenceman") defenseCount += 1;
      if (player.positions?.toLowerCase() == "forward") forwardCount += 1;
    }

    // These values will occasionally be higher because the pending trade is added to the array
    if (netminderCount < 1 || defenseCount < 6 || forwardCount < 12) {
      throw TradeError(TradeErrorType.notEnoughPositions);
    }

    // NOT CHECKING HOW MANY TRADES HAVE BEEN MADE HERE
  }
}
