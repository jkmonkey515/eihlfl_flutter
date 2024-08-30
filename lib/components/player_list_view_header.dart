import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/components/app_icon_vector.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class PlayerListViewHeader extends StatelessWidget {
  const PlayerListViewHeader({super.key, this.player});
  final HockeyPlayer? player;

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
