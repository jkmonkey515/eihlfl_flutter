import 'package:flutter/material.dart';
import 'package:football_hockey/models/standings/player_standing.dart';
import 'package:football_hockey/pages/standings/dashboard_standings_team_list.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class LeagueTableListView extends StatelessWidget {
  final List<PlayerStanding>? playerStandings;
  const LeagueTableListView({super.key, this.playerStandings});

  @override
  Widget build(BuildContext context) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      16.0.verticalSpacer,
      const _LeagueTableListViewHeader(),
      16.0.verticalSpacer,
      ListView.separated(
        itemCount: playerStandings?.length ?? 10,
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return _LeagueTableListViewItem(
              player:
                  (playerStandings != null ? playerStandings![index] : null),
              index: index);
        },
        separatorBuilder: (context, index) {
          return 8.0.verticalSpacer;
        },
      ),
    ]);
  }
}

class _LeagueTableListViewItem extends StatelessWidget {
  const _LeagueTableListViewItem({this.player, required this.index});

  final PlayerStanding? player;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap:
            _showTeamPreview, //DISPLAY -> Team > List > w header like the card
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          decoration: BoxDecoration(
            color: Get.theme.cardColor,
            borderRadius: BorderRadius.circular(5.0),
            border: Border.all(color: Get.theme.dividerColor),
          ),
          child: Row(children: [
            _buildNumberText(),
            8.0.horizontalSpacer,
            Expanded(
              flex: 1,
              child: Center(
                child: _buildNameText(player?.getName()),
              ),
            ),
            8.0.horizontalSpacer,
            Expanded(
              flex: 1,
              child: Center(
                child: _buildTeamText(player?.getTeamName()),
              ),
            ),
            8.0.horizontalSpacer,
            _buildPointsText(player?.getPoints()),
          ]),
        ));
  }

  void _showTeamPreview() {
    if (player?.getName() != null) {
      Get.to(() => DashboardStandingsTeamList(
            player: player?.getName(),
          ));
    }
  }

  Widget _buildNumberText() {
    Color iconColor = Colors.transparent;

    if (index + 1 == 1) iconColor = const Color(0xffFFC323);
    if (index + 1 == 2) iconColor = const Color(0xffA1A6AD);
    if (index + 1 == 3) iconColor = const Color(0xffBA7760);

    return Row(mainAxisSize: MainAxisSize.min, children: [
      AppVectorIcon(
        boxDimension: 12.0,
        iconDimension: 12.0,
        vectorIconPath: AppConfigs.images.svgIcCup,
        color: iconColor,
      ),
      10.0.horizontalSpacer,
      Text(
        "${index + 1}",
        style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
      ),
    ]);
  }

  Widget _buildNameText(String? fullName) {
    return Text(
      fullName ?? "– - - - -",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildTeamText(String? name) {
    return Text(
      name ?? "- - - - - - - - - - ",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPointsText(int? points) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: points?.toString() ?? "– -",
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

class _LeagueTableListViewHeader extends StatelessWidget {
  const _LeagueTableListViewHeader();

  @override
  Widget build(BuildContext context) {
    TextStyle? style =
        Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600);

    return Opacity(
      opacity: 0.25,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("#", style: style),
            Text("Name", style: style),
            Text("Team", style: style),
            Text("Points", style: style),
          ],
        ),
      ),
    );
  }
}
