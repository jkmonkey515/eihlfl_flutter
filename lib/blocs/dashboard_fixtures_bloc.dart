import 'package:flutter/material.dart';
import 'package:football_hockey/pages/fixtures/dashboard_fixtures_page_tab_all_games.dart';
import 'package:football_hockey/pages/fixtures/dashboard_fixtures_page_tab_my_games.dart';
import 'package:get/get.dart';

import '../components/app_tab_bar.dart';

class DashboardFixturesBloc extends GetxController {
  final tabBarCurrentIndex = RxInt(0);
  final tabBarCurrentWidget =
      Rx<Widget>(const DashboardFixturesPageTabAllGames());

  void onTabBarIndexChanged(int value) {
    tabBarCurrentIndex.value = value;
    tabBarCurrentWidget.value = tabBarModels[value].widget;
  }

  final tabBarModels = <AppTabBarItemModel>[
    AppTabBarItemModel(
      title: "All Games",
      widget: const DashboardFixturesPageTabAllGames(),
    ),
    AppTabBarItemModel(
      title: "My Games",
      widget: const DashboardFixturesPageTabMyGames(),
    ),
  ];
}
