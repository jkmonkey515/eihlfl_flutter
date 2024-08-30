import 'package:flutter/material.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_by_team_per_week.dart';
import 'package:get/get.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../utils/spacer.dart';

class RostersListView extends StatelessWidget {
  final List<TopScorerByTeamPerWeek>? playersList;
  const RostersListView({super.key, required this.playersList});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
        enabled: playersList == null,
        child: Column(children: [
          16.0.verticalSpacer,
          const _RostersListViewHeader(),
          16.0.verticalSpacer,
          Expanded(
            child: ListView.separated(
              itemCount: playersList?.length ?? 0,
              shrinkWrap: true,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemBuilder: (context, index) {
                return _RostersListViewItem(player: playersList?[index]);
              },
              separatorBuilder: (context, index) {
                return 8.0.verticalSpacer;
              },
            ),
          ),
        ]));
  }
}

class _RostersListViewItem extends StatelessWidget {
  final TopScorerByTeamPerWeek? player;
  const _RostersListViewItem({this.player});

  @override
  Widget build(BuildContext context) {
    String teamImage = player?.getTeamImage() ?? "";
    String fullName = player?.getFullName() ?? "-";
    String teamName = player?.getTeamName() ?? "-";
    String position = player?.getAbbrevPosition() ?? "-";
    String points = player?.getPoints().toString() ?? "-";

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Align(
            alignment: Alignment.centerLeft,
            child: _buildNameText(fullName, teamImage),
          ),
        ),
        8.0.horizontalSpacer,
        Expanded(
          flex: 2,
          child: Center(
            child: _buildTeamText(teamName),
          ),
        ),
        8.0.horizontalSpacer,
        Expanded(
          flex: 1,
          child: Center(
            child: _buildPositionText(position),
          ),
        ),
        8.0.horizontalSpacer,
        Expanded(
          flex: 2,
          child: Center(
            child: _buildPointsText(points),
          ),
        ),
      ]),
    );
  }

  Widget _buildNameText(String fullName, String? teamImage) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        width: 16.0,
        height: 16.0,
        child: CircleAvatar(
          radius: 8.0,
          backgroundColor: Get.theme.cardColor,
          child: teamImage == null
              ? const CircularProgressIndicator()
              : Image.asset(teamImage),
        ),
      ),
      6.0.horizontalSpacer,
      Expanded(
        child: Text(
          fullName,
          style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
        ),
      ),
    ]);
  }

  Widget _buildTeamText(String teamName) {
    return Text(
      teamName,
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPositionText(String position) {
    return Text(
      position,
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPointsText(String points) {
    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: points,
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

class _RostersListViewHeader extends StatelessWidget {
  const _RostersListViewHeader();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(children: [
        Expanded(
          flex: 3,
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Text(
                "Name",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Text(
                "Team",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Text(
                "Position",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: Center(
            child: Opacity(
              opacity: 0.5,
              child: Text(
                "Points",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
