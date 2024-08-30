import 'package:flutter/material.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class PlayersListView extends StatelessWidget {
  const PlayersListView({
    super.key,
    required this.headerTitle,
    required this.headerPadding,
    required this.headerEditButtonVisible,
    required this.onHeaderEditButtonTap,
    required this.isCaptain,
    required this.playerList,
    this.playerItemSelector,
  });

  final String headerTitle;
  final EdgeInsetsGeometry headerPadding;
  final bool headerEditButtonVisible;
  final VoidCallback onHeaderEditButtonTap;
  final List<HockeyPlayer> playerList;
  final bool isCaptain;
  final Function(int)? playerItemSelector;
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
                Text(
                  headerTitle,
                  style: Get.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
                ),
                Visibility(
                  visible: headerEditButtonVisible,
                  child: GestureDetector(
                    onTap: onHeaderEditButtonTap,
                    behavior: HitTestBehavior.opaque,
                    child: Text(
                      "Edit",
                      style: Get.textTheme.bodyMedium?.copyWith(
                        color: Get.theme.colorScheme.primary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ),
                ),
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
                  child: PlayersListViewItem(
                      index: index,
                      isCaptain: isCaptain,
                      player: playerList[index]));
            },
            separatorBuilder: (context, index) {
              return const Divider(height: 0.0);
            },
          ),
        ]);
  }
}

class PlayersListViewItem extends StatelessWidget {
  const PlayersListViewItem({
    super.key,
    required this.index,
    required this.isCaptain,
    required this.player,
  });

  final HockeyPlayer player;
  final int index;
  final bool isCaptain;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Get.theme.cardColor,
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
      child: Row(children: [
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
        Expanded(
          flex: 2,
          child: Center(
            child: _buildTeamText(),
          ),
        ),
        4.0.horizontalSpacer,
        _buildPointsText(),
      ]),
    );
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
          visible: isCaptain,
          child: Align(
            alignment: Alignment.topRight,
            child: CircleAvatar(
              radius: 9.0,
              backgroundColor: const Color(0xffFFC323),
              child: Center(
                child: AppVectorIcon(
                  boxDimension: 9.0,
                  iconDimension: 9.0,
                  vectorIconPath: AppConfigs.images.svgIcCup,
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

  Widget _buildTeamText() {
    return Text(
      player.team ?? "- -",
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
