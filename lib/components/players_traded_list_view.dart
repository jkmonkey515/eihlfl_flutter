import 'package:flutter/material.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class PlayersTradingListView extends StatelessWidget {
  const PlayersTradingListView({
    super.key,
    required this.headerTitle,
    required this.headerPadding,
    required this.headerEditButtonVisible,
    required this.onHeaderEditButtonTap,
    required this.isCaptain,
    required this.playerList,
    required this.playerButtonWidget,
    required this.playerButtonHandler,
    this.playerItemSelector,
  });

  final String headerTitle;
  final EdgeInsetsGeometry headerPadding;
  final bool headerEditButtonVisible;
  final VoidCallback onHeaderEditButtonTap;
  final List<HockeyPlayer> playerList;
  final bool isCaptain;
  final Function(int)? playerItemSelector;
  final Widget playerButtonWidget;
  final Function(int?) playerButtonHandler;
  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 0.0),
          Container(
            color: Get.theme.colorScheme.background,
            padding: headerPadding,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  Text(
                    headerTitle,
                    style: Get.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      fontSize: 18.0,
                    ),
                  ),
                  10.horizontalSpacer,
                  Center(
                      child: AppVectorIcon(
                    boxDimension: 14.0,
                    iconDimension: 14.0,
                    vectorIconPath: AppConfigs.images.svgIcTrade,
                    color: Get.theme.primaryColor,
                  )),
                ])
              ],
            ),
          ),
          const Divider(height: 0.0),
          ListView.separated(
            itemCount: playerList.length,
            shrinkWrap: true,
            padding: EdgeInsets.zero,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return GestureDetector(
                  onTap: () {
                    if (playerItemSelector != null) {
                      playerItemSelector!(index);
                    }
                  },
                  child: PlayersTradedListViewItem(
                    index: index,
                    isCaptain: isCaptain,
                    player: playerList[index],
                    playerButtonWidget: playerButtonWidget,
                    playerButtonHandler: playerButtonHandler,
                  ));
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0.0);
            },
          ),
        ]);
  }
}

class PlayersTradedListViewItem extends StatelessWidget {
  const PlayersTradedListViewItem({
    super.key,
    required this.index,
    required this.isCaptain,
    required this.player,
    required this.playerButtonWidget,
    required this.playerButtonHandler,
  });

  final HockeyPlayer player;
  final int index;
  final bool isCaptain;
  final Widget playerButtonWidget;
  final Function(int?) playerButtonHandler;

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Get.theme.cardColor,
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: Column(children: [
          Visibility(
              visible: player.tradedFor != null,
              child: Column(children: [
                Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: 'Trading to recieve ',
                          style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w200,
                              fontStyle: FontStyle.italic)),
                      TextSpan(
                          text:
                              "${player.tradedFor} (${player.getAbbrevTeamName()})",
                          style: Get.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w600,
                              fontStyle: FontStyle.italic)),
                    ]))),
                10.0.verticalSpacer,
              ])),
          Row(children: [
            _buildImage(),
            4.0.horizontalSpacer,
            Expanded(
              flex: 1,
              child: Center(
                child: _buildNumberText(),
              ),
            ),
            4.0.horizontalSpacer,
            Expanded(
              flex: 2,
              child: Center(
                child: _buildNameText(),
              ),
            ),
            4.0.horizontalSpacer,
            Expanded(
              flex: 1,
              child: Center(
                child: _buildPositionText(),
              ),
            ),
            4.0.horizontalSpacer,
            Expanded(flex: 1, child: _buildPointsText()),
            4.0.horizontalSpacer,
            Expanded(
              flex: 2,
              child: Center(child: _buildButton(index)),
            )
          ]),
        ]));
  }

  Widget _buildButton(int? index) {
    return Ink(
        child: InkWell(
            onTap: () async {
              playerButtonHandler(index);
            },
            child: playerButtonWidget));
  }

  Widget _buildImage() {
    return SizedBox.square(
      dimension: 52.0,
      child: Stack(children: [
        CircleAvatar(
          radius: 26.0,
          backgroundColor: Get.theme.cardColor,
          child: Image.asset(player.getTeamImage() ?? ""),
        ),
        Visibility(
          visible: true,
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 9.0,
              backgroundColor: Get.theme.colorScheme.primary,
              child: Center(
                child: AppVectorIcon(
                  boxDimension: 9.0,
                  iconDimension: 9.0,
                  vectorIconPath: AppConfigs.images.svgIcTrade,
                  color: Get.theme.cardColor,
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildNumberText() {
    return Text(
      "#${player.getNumber()}",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildNameText() {
    return Text(
      player.getAbbrevName(),
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPositionText() {
    return Text(
      player.getAbbrevPosition(),
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPointsText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: player.getPoints().toString(),
          style: Get.textTheme.bodySmall?.copyWith(
            color: Get.theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const TextSpan(text: " "),
        TextSpan(
          text: "PTS",
          style: Get.textTheme.bodySmall?.copyWith(
            color: Get.theme.iconTheme.color?.withOpacity(0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}
