import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/components/app_icon_vector.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/components/players_list_view.dart';
import 'package:football_hockey/components/players_traded_list_view.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/pages/trade/dashboard_trade_list_page.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:football_hockey/services/gw_teams_service_api.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';
import 'package:football_hockey/services/trading_service_api.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardTradePage extends StatefulWidget {
  const DashboardTradePage({key}) : super(key: key);

  @override
  _DashboardTradePageState createState() => _DashboardTradePageState();
}

class _DashboardTradePageState extends State<DashboardTradePage> {
  HockeyPlayer? player;
  List<HockeyPlayer>? teamPlayerList;
  List<HockeyPlayer>? tradedPlayerList;
  Future<void> getTeamPlayerList() async {
    try {
      var playerList = await GWTeamsServiceAPI.getTradesFromPlayerList();
      var trades = playerList.$1;
      var otherPlayers = playerList.$2;

      if (mounted) {
        setState(() {
          teamPlayerList = otherPlayers;
          tradedPlayerList = trades;
          player = teamPlayerList?.firstOrNull;
        });
      }
    } catch (e) {
      AlertService.showToast(
        "There was a network issue when trying to fetch the dashboard trade page.",
      );
    }
  }

  @override
  void initState() {
    super.initState();
    loadStatePlayerList();
  }

  void loadStatePlayerList() {
    // Ignore asyncronous call wrapper
    getTeamPlayerList();
  }

  @override
  Widget build(BuildContext context) {
    // Your existing build method code goes here

    return Scaffold(
        appBar: AppToolbar.build(
          titleText: "Trade",
          backButtonVisible: false,
        ),
        body: Skeletonizer(
            enabled: teamPlayerList == null,
            child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _HeaderSection(
                      () => {
                            //Reload logic on back button or successful trade
                            if (mounted)
                              {
                                setState(() {
                                  player = null;
                                  tradedPlayerList = null;
                                  teamPlayerList = null;
                                }),
                                loadStatePlayerList()
                              }
                          },
                      player,
                      teamPlayerList,
                      tradedPlayerList),
                  _StatisticsListView(player),
                  Expanded(
                    child: SingleChildScrollView(
                        child: Column(children: [
                      (tradedPlayerList == null || tradedPlayerList!.isEmpty)
                          ? Container()
                          : _buildTradedListView(),
                      _buildPlayerListView()
                    ])),
                  ),
                ])));
  }

  bool _isUndoButtonLoading = false;
  Widget _buildUndoButtonComponent() {
    return Container(
      padding: const EdgeInsets.all(7.0),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: const BorderRadius.all(Radius.circular(5.0)),
        color: Get.theme.colorScheme.primary,
        border: Border.all(
            color: Get.theme.colorScheme.primary,
            width: 2.0), // Add an outline border
      ),
      child: !_isUndoButtonLoading
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.undo_rounded,
                    color: Get.theme.colorScheme.inversePrimary, size: 15.0),
                5.0.horizontalSpacer,
                Text(
                  "Undo",
                  style: Get.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Get.theme.colorScheme.inversePrimary),
                ),
              ],
            )
          : const SizedBox(
              width: 12,
              height: 12,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ),
    );
  }

  Widget _buildTradedListView() {
    return PlayersTradingListView(
      headerTitle: "Pending Trades",
      headerPadding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
      headerEditButtonVisible: false,
      onHeaderEditButtonTap: () {},
      isCaptain: false,
      playerList: tradedPlayerList ?? [],
      playerButtonWidget: _buildUndoButtonComponent(),
      playerButtonHandler: (index) => _undoButtonHandler(index),
      playerItemSelector: (index) async {
        if (mounted) {
          setState(() {
            player = null;
          });
        }

        var name = (tradedPlayerList ?? [])[index].name ?? "";
        var foundPlayer = await HockeyPlayerServiceAPI.getPlayerByName(name);
        if (mounted) {
          setState(() {
            player = foundPlayer;
          });
        }
      },
    );
  }

  void _undoButtonHandler(int? index) async {
    if (index != null && tradedPlayerList?[index].tradedFor != null) {
      if (mounted) {
        setState(() {
          _isUndoButtonLoading = true;
        });
      }

      var selectedPlayer = tradedPlayerList?[index];
      var tradedForPlayer = await HockeyPlayerServiceAPI.getPlayerByName(
          tradedPlayerList![index].tradedFor!);
      if (selectedPlayer == null ||
          teamPlayerList == null ||
          tradedForPlayer == null) return null;

      TradingServiceAPI.attemptTrade(
              selectedPlayer, tradedForPlayer, teamPlayerList!,
              undo: true)
          .then((value) => {
                // tradeErrorMessage
                if (mounted)
                  {
                    setState(() {
                      player = null;
                      tradedPlayerList = null;
                      teamPlayerList = null;
                      _isUndoButtonLoading = false;
                    }),
                    loadStatePlayerList()
                  }
              });
    }
  }

  Widget _buildPlayerListView() {
    return PlayersListView(
      headerTitle: "Trade Players",
      headerPadding: const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
      headerEditButtonVisible: false,
      onHeaderEditButtonTap: () {},
      isCaptain: false,
      playerList: teamPlayerList ?? [],
      playerItemSelector: (index) async {
        if (mounted) {
          setState(() {
            player = null;
          });
        }

        var name = (teamPlayerList ?? [])[index].name ?? "";
        var foundPlayer = await HockeyPlayerServiceAPI.getPlayerByName(name);
        if (mounted) {
          setState(() {
            player = foundPlayer;
          });
        }
      },
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final HockeyPlayer? player;
  final List<HockeyPlayer>? teamsPlayers;
  final List<HockeyPlayer>? pendingTrades;
  final Function reloadState;
  const _HeaderSection(
      this.reloadState, this.player, this.teamsPlayers, this.pendingTrades);

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 230.0,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConfigs.images.pngImgBackgroundShape1),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left: 30.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildPositionText(),
                12.0.verticalSpacer,
                _buildPlayerNameText(),
                12.0.verticalSpacer,
                _buildTeamNameText(),
                30.0.verticalSpacer,
                (player?.tradedFor == null)
                    ? _buildTradePlayerButton()
                    : const SizedBox(),
              ],
            ),
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: _buildPlayerImage(),
          ),
        ),
      ]),
    );
  }

  Widget _buildPositionText() {
    return Text(
      "#${player?.getNumber() ?? "- - -"} ${player?.getAbbrevPosition() ?? "- - -"}",
      style: Get.textTheme.titleLarge?.copyWith(
        color: Get.theme.cardColor,
        fontWeight: FontWeight.w700,
        fontSize: 18.0,
        height: 1.0,
      ),
    );
  }

  Widget _buildPlayerNameText() {
    return Text(
      player?.getFullName() ?? "- - - - - - - - - -",
      style: GoogleFonts.viga(
        color: Get.theme.colorScheme.primary,
        fontWeight: FontWeight.w400,
        fontSize: 22.0,
        height: 1.0,
      ),
    );
  }

  Widget _buildTeamNameText() {
    return Text(
      player?.getTeamName() ?? "– - - - - -",
      style: Get.textTheme.bodyLarge?.copyWith(
        color: Get.theme.cardColor,
        fontWeight: FontWeight.w400,
        fontSize: 18.0,
        height: 1,
      ),
    );
  }

  void _tradePlayerHandler() {
    Get.to(() => TradeListPage(
          tradePlayer: player,
          teamsPlayers: teamsPlayers ?? [],
          pendingTrades: pendingTrades ?? [],
        ))?.then((value) => {reloadState()});
  }

  Widget _buildTradePlayerButton() {
    return InkWell(
      onTap: _tradePlayerHandler,
      child: Ink(
        padding: const EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Get.theme.dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppVectorIcon(
              boxDimension: 20.0,
              iconDimension: 20.0,
              vectorIconPath: AppConfigs.images.svgIcTrade,
              color: Get.theme.colorScheme.primary,
            ),
            10.0.horizontalSpacer,
            Text(
              "Trade Player",
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerImage() {
    return player?.getTeamImage() == null
        ? const Center(child: CircularProgressIndicator())
        : Image.asset(
            player?.getTeamImage() ?? "",
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
          );
  }
}

class _StatisticsListView extends StatelessWidget {
  final HockeyPlayer? player;
  const _StatisticsListView(this.player);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        _StatisticsListViewItem(
            title: "PTS", value: player?.getPoints().toString() ?? "–"),
        _StatisticsListViewItem(
            title: player?.getStatGoalName() ?? "Goals",
            value: player?.getGoals().toString() ?? "–"),
        _StatisticsListViewItem(
            title: "ASSISTS", value: player?.getAssists().toString() ?? "–"),
        _StatisticsListViewItem(
            title: "TEAM",
            value: player?.getTeamName().toString() ?? "- - - – - - - - -"),
        _StatisticsListViewItem(
            title: "NATIONALITY",
            value: player?.getNationalityAbbrev().toString() ?? "– - - - -"),
      ]),
    );
  }
}

class _StatisticsListViewItem extends StatelessWidget {
  const _StatisticsListViewItem({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Opacity(
        opacity: 0.3,
        child: Text(
          title,
          style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
      10.0.verticalSpacer,
      Text(
        value,
        style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    ]);
  }
}
