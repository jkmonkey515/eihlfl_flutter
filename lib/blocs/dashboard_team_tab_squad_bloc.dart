import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/components/app_tab_bar.dart';
import 'package:football_hockey/models/top_scorers/top_overall_scorer.dart';
import 'package:football_hockey/pages/team/dashboard_team_page_tab_squad.dart';

class DashboardTeamSquadTabBloc {
  OverallPlayerLines transferObject;
  DashboardTeamSquadTabBloc({required this.transferObject}) {
    tabBarModels = <AppTabBarItemModel>[
      AppTabBarItemModel(
          title: "Line 1",
          vectorIconPath: AppConfigs.images.svgIcTeamManagement,
          widget: DashboardTeamPageTabSquadLine(line: transferObject.line1)),
      AppTabBarItemModel(
        title: "Line 2",
        vectorIconPath: AppConfigs.images.svgIcTeamManagement,
        widget: DashboardTeamPageTabSquadLine(line: transferObject.line2),
      ),
      AppTabBarItemModel(
        title: "Line 3",
        vectorIconPath: AppConfigs.images.svgIcTeamManagement,
        widget: DashboardTeamPageTabSquadLine(line: transferObject.line3),
      ),
      AppTabBarItemModel(
        title: "Line 4",
        vectorIconPath: AppConfigs.images.svgIcTeamManagement,
        widget: DashboardTeamPageTabSquadLine(line: transferObject.line4),
      )
    ];
    tabBarCurrentWidget =
        DashboardTeamPageTabSquadLine(line: transferObject.line1);
  }

  var isLoading = false;
  var tabBarCurrentIndex = 0;
  Widget? tabBarCurrentWidget;
  List<Widget>? widgetPages;

  void onTabBarIndexChanged(int value) {
    tabBarCurrentIndex = value;
    tabBarCurrentWidget = tabBarModels[value].widget;
  }

  var tabBarModels;
}
