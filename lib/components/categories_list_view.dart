import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class CategoriesListView extends StatelessWidget {
  const CategoriesListView({
    super.key,
    required this.onManageTeamButtonTap,
    required this.onTradesButtonTap,
    required this.onRostersButtonTap,
    required this.onFixturesButtonTap,
    required this.onStandingsButtonTap,
  });

  final VoidCallback onManageTeamButtonTap;
  final VoidCallback onTradesButtonTap;
  final VoidCallback onRostersButtonTap;
  final VoidCallback onFixturesButtonTap;
  final VoidCallback onStandingsButtonTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.0,
      child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: [
            _CategoriesListViewItem(
              text: "Manage Team",
              vectorIconPath: AppConfigs.images.svgIcTeamManagement,
              onTap: onManageTeamButtonTap,
            ),
            5.0.horizontalSpacer,
            _CategoriesListViewItem(
              text: "Trades",
              vectorIconPath: AppConfigs.images.svgIcTrade,
              onTap: onTradesButtonTap,
            ),
            5.0.horizontalSpacer,
            _CategoriesListViewItem(
              text: "Rosters",
              vectorIconPath: AppConfigs.images.svgIcFixture,
              onTap: onRostersButtonTap,
            ),
            5.0.horizontalSpacer,
            _CategoriesListViewItem(
              text: "Fixtures",
              vectorIconPath: AppConfigs.images.svgIcBottomNavBarFixtures,
              onTap: onFixturesButtonTap,
            ),
            5.0.horizontalSpacer,
            _CategoriesListViewItem(
              text: "Standings",
              vectorIconPath: AppConfigs.images.svgIcBottomNavBarScores,
              onTap: onStandingsButtonTap,
            ),
          ]),
    );
  }
}

class _CategoriesListViewItem extends StatelessWidget {
  const _CategoriesListViewItem({
    required this.text,
    required this.vectorIconPath,
    required this.onTap,
  });

  final String text;
  final String vectorIconPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(5.0),
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Get.theme.cardColor,
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Get.theme.dividerColor),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            AppVectorIcon(
              boxDimension: 16.0,
              iconDimension: 16.0,
              vectorIconPath: vectorIconPath,
              color: Get.theme.colorScheme.primary,
            ),
            10.0.horizontalSpacer,
            Text(
              text,
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }
}
