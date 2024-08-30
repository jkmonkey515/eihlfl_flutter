import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/components/app_icon_vector.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/components/player_list_view_header.dart';
import 'package:football_hockey/components/players_traded_list_view.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:football_hockey/services/hockey_player_service_api.dart';
import 'package:football_hockey/services/trading_service_api.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

class TradeListPage extends StatefulWidget {
  final HockeyPlayer? tradePlayer;
  final List<HockeyPlayer> teamsPlayers;
  final List<HockeyPlayer> pendingTrades;
  const TradeListPage(
      {super.key,
      this.tradePlayer,
      required this.teamsPlayers,
      required this.pendingTrades});

  @override
  _TradeListPageState createState() => _TradeListPageState();
}

class _TradeListPageState extends State<TradeListPage> {
  //Local values

  List<HockeyPlayer>? playersForTrade;

  //Initialize state with remote values
  @override
  void initState() {
    super.initState();
    try {
      //Get all the players
      HockeyPlayerServiceAPI.getTradablePlayersFor(
              widget.tradePlayer, widget.teamsPlayers, widget.pendingTrades)
          .then((value) => {
                if (mounted)
                  {
                    setState(() {
                      playersForTrade = value;
                    })
                  }
              });
    } catch (e) {
      AlertService.showToast(
        "There was a network error while trying to get the trade list players",
      );
    }
  }

  final _showAlert = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppToolbar.build(
            titleText: "Trade Player",
            backButtonVisible: true,
            onBackButtonTap: (() => Get.back())),
        body: Column(
          children: [
            Visibility(
                visible: widget.tradePlayer != null,
                child: Container(
                    decoration: BoxDecoration(
                      color: Get.theme.cardColor,
                      borderRadius: BorderRadius.circular(5.0),
                      border: Border.all(color: Get.theme.dividerColor),
                    ),
                    child: Column(children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30.0, vertical: 20.0),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Player to Trade",
                                style: Get.textTheme.titleLarge?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 18.0,
                                ),
                              ),
                              const Divider(),
                              PlayerListViewHeader(player: widget.tradePlayer)
                            ]),
                      ),
                    ]))),
            Expanded(
                child: Skeletonizer(
              enabled: (playersForTrade == null),
              child: SingleChildScrollView(
                  child: PlayersTradingListView(
                      headerTitle: "Players for Trade",
                      headerPadding:
                          const EdgeInsets.fromLTRB(30.0, 50.0, 30.0, 20.0),
                      headerEditButtonVisible: false,
                      onHeaderEditButtonTap: () {},
                      isCaptain: false,
                      playerList: playersForTrade ?? [],
                      playerButtonWidget: _buildTradeButtonComponent(),
                      playerButtonHandler: _tradeRequestHandler)),
            )),
          ],
        ));
  }

  dynamic _tradeRequestHandler(int? index) async {
    if (mounted) {
      setState(() {
        _tradeIsPending = true;
      });
    }
    // set up the button
    if (playersForTrade == null) return;
    var player = (playersForTrade ?? []).elementAtOrNull(index ?? -1);
    if (player == null) return;
    if (widget.tradePlayer == null) return;

    //Attempt to trade the player
    var tradeErrorMessage = await TradingServiceAPI.attemptTrade(
        widget.tradePlayer!, player, widget.teamsPlayers);
    if (mounted) {
      setState(() {
        _tradeIsPending = false;
      });
    }
    if (tradeErrorMessage == null) {
      //Successful player trade
      Get.back();
    } else {
      _displayAlert(tradeErrorMessage);
    }
  }

  void _displayAlert(String withMsg) {
    Widget okButton = TextButton(
      child: const Text("Make Another Trade"),
      onPressed: () {
        Get.back();
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: const Text("Trade Prevented"),
      content: SingleChildScrollView(child: Text(withMsg, maxLines: 100)),
      actions: [
        okButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  bool _tradeIsPending = false;
  Widget _buildTradeButtonComponent() {
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
      child: !_tradeIsPending
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppVectorIcon(
                  boxDimension: 12.0,
                  iconDimension: 12.0,
                  vectorIconPath: AppConfigs.images.svgIcTrade,
                  color: Get.theme.colorScheme.inversePrimary,
                ),
                5.0.horizontalSpacer,
                Text(
                  "Trade",
                  style: Get.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Get.theme.colorScheme.inversePrimary),
                )
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

  PreferredSize _buildAppBar() {
    return const PreferredSize(
      preferredSize: Size.fromHeight(90.0),
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // _buildAppBarLogoButton(),
                // _buildSponserBanner(),
                // _buildAppBarMenuButton(), TODO: Enable upon having a menu bar
              ],
            ),
          ),
        ),
      ),
    );
  }
}
