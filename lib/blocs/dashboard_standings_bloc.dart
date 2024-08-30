import 'package:flutter/material.dart';
import 'package:football_hockey/pages/standings/dashboard_standings_page_tab_league_table.dart';
import 'package:football_hockey/pages/standings/dashboard_standings_page_tab_player_rankings.dart';
import 'package:get/get.dart';

import '../components/app_tab_bar.dart';

class DashboardStandingsBloc extends GetxController {
  final tabBarCurrentIndex = RxInt(0);
  final tabBarCurrentWidget =
      Rx<Widget>(const DashboardStandingsPageTabLeagueTable());

  void onTabBarIndexChanged(int value) {
    tabBarCurrentIndex.value = value;
    tabBarCurrentWidget.value = tabBarModels[value].widget;
  }

  final tabBarModels = <AppTabBarItemModel>[
    AppTabBarItemModel(
      title: "League Table",
      widget: const DashboardStandingsPageTabLeagueTable(),
    ),
    AppTabBarItemModel(
      title: "Player Rankings",
      widget: const DashboardStandingsPageTabPlayerRankings(),
    ),
  ];
}
