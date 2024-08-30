import 'package:flutter/material.dart';
import 'package:football_hockey/models/top_scorers/top_overall_scorer.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class PointScorersListView extends StatelessWidget {
  final List<TopOverallScorer>? playersList;
  TopOverallScorer? highlightedPlayer;
  List<TopOverallScorer>? remainingPlayers;
  final bool? showTrade;
  Function(int)? onTap;
  PointScorersListView(
      {super.key,
      this.playersList,
      this.highlightedPlayer,
      this.showTrade,
      this.onTap}) {
    if (highlightedPlayer == null) {
      //If not provided, assume the highlighted player is first one in the list
      if ((playersList?.length ?? 0) > 0) {
        highlightedPlayer = playersList?.firstOrNull;
      }

      remainingPlayers = playersList?.sublist(1);
    } else {
      remainingPlayers = playersList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
        child: Container(
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Get.theme.dividerColor),
          ),
          child: Column(mainAxisSize: MainAxisSize.min, children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: _TopScorerListViewHeader(player: highlightedPlayer),
            ),
            const Divider(height: 0.0),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
              child: ListView.separated(
                itemCount: remainingPlayers?.length ?? 0,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return _PointScorersListViewItem(
                      player: remainingPlayers?[index],
                      showTrade: showTrade,
                      onTap: onTap,
                      index: index);
                },
                separatorBuilder: (context, index) {
                  return 20.0.verticalSpacer;
                },
              ),
            ),
          ]),
        ));
  }
}

class _PointScorersListViewItem extends StatelessWidget {
  const _PointScorersListViewItem(
      {required this.index, this.player, this.showTrade, this.onTap});
  final TopOverallScorer? player;
  final bool? showTrade;
  final Function(int)? onTap;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _buildNumberText(),
      8.0.horizontalSpacer,
      Expanded(
        flex: 2,
        child: Center(
          child: _buildNameText(),
        ),
      ),
      8.0.horizontalSpacer,
      Expanded(
        flex: 1,
        child: Center(
          child: _buildPositionText(),
        ),
      ),
      8.0.horizontalSpacer,
      Expanded(
        flex: 2,
        child: Center(
          child: _buildTeamText(),
        ),
      ),
      8.0.horizontalSpacer,
      _buildPointsText(),
      showTrade == true ? _buildTradePlayerButton() : const SizedBox()
    ]);
  }

  Widget _buildTradePlayerButton() {
    return InkWell(
      onTap: () {
        if (onTap != null) onTap!(index);
      },
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
          ],
        ),
      ),
    );
  }

  Widget _buildNumberText() {
    return Text(
      "${index + 2}",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildNameText() {
    return Text(
      player?.getAbbrevName() ?? "–",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPositionText() {
    return Text(
      player?.getAbbrevPosition() ?? "–",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTeamText() {
    return Text(
      player?.getAbbrevTeamName() ?? "–",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPointsText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: player?.getPoints().toString() ?? "–",
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

class _TopScorerListViewHeader extends StatelessWidget {
  const _TopScorerListViewHeader({this.player});
  final TopOverallScorer? player;

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      _buildPlayerImage(),
      30.0.horizontalSpacer,
      Expanded(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTeamNameText(),
            6.0.verticalSpacer,
            _buildFullNameText(),
            6.0.verticalSpacer,
            _buildPositionText(),
          ],
        ),
      ),
      30.0.horizontalSpacer,
      _buildPointsText(),
    ]);
  }

  Widget _buildPlayerImage() {
    return SizedBox.square(
      dimension: 68.0,
      child: Stack(children: [
        CircleAvatar(
          radius: 34.0,
          backgroundColor: Get.theme.cardColor,
          child: player?.getTeamImage() == null
              ? const CircularProgressIndicator()
              : Image.asset(player!.getTeamImage()!),
        ),
        Align(
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
      ]),
    );
  }

  Widget _buildTeamNameText() {
    return Text(
      player?.getTeamName() ?? "– - - - - - -",
      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
    );
  }

  Widget _buildFullNameText() {
    return Text(
      player?.getFullName() ?? "– - - - - – - - - -",
      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w700),
    );
  }

  Widget _buildPositionText() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        player?.getPositionName() ?? "– - -",
        style: Get.textTheme.bodySmall?.copyWith(
          color: Get.theme.cardColor,
          fontWeight: FontWeight.w400,
          fontSize: 9.0,
        ),
      ),
    );
  }

  Widget _buildPointsText() {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: player?.getPoints().toString() ?? "–",
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Get.theme.colorScheme.primary,
            fontWeight: FontWeight.w600,
          ),
        ),
        const TextSpan(text: " "),
        TextSpan(
          text: "PTS",
          style: Get.textTheme.bodyMedium?.copyWith(
            color: Get.theme.iconTheme.color?.withOpacity(0.5),
            fontWeight: FontWeight.w600,
          ),
        ),
      ]),
    );
  }
}
