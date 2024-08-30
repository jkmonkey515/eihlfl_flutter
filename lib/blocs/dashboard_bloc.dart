import 'package:flutter/material.dart';
import 'package:football_hockey/pages/fixtures/dashboard_fixtures_page.dart';
import 'package:football_hockey/pages/home/dashboard_home_page.dart';
import 'package:football_hockey/pages/standings/dashboard_standings_page.dart';
import 'package:football_hockey/pages/team/dashboard_team_page.dart';
import 'package:football_hockey/pages/trade/dashboard_trade_page.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../components/app_bottom_nav_bar.dart';


class DashboardBloc extends GetxController {
  final currentIndex = RxInt(2);
  final currentWidget = Rx<Widget>(const DashboardHomePage());

  void onIndexChanged(int index) {
    currentIndex.value = index;
    currentWidget.value = models[index].widget;
  }

  final models = [
    BottomNavBarItemModel(
      title: "Team",
      vectorIconPath: AppConfigs.images.svgIcBottomNavBarTeam,
      positiveColor: const Color(0xff00AEEF),
      negativeColor: const Color(0xff1F1F1F),
      widget: const DashboardTeamPage(),
    ),
    BottomNavBarItemModel(
      title: "Trade",
      vectorIconPath: AppConfigs.images.svgIcBottomNavBarTrade,
      positiveColor: const Color(0xff00AEEF),
      negativeColor: const Color(0xff1F1F1F),
      widget: const DashboardTradePage(),
    ),
    BottomNavBarItemModel(
      title: "Home",
      vectorIconPath: AppConfigs.images.svgIcBottomNavBarHome,
      positiveColor: const Color(0xff00AEEF),
      negativeColor: const Color(0xff1F1F1F),
      widget: const DashboardHomePage(),
    ),
    BottomNavBarItemModel(
      title: "Fixtures",
      vectorIconPath: AppConfigs.images.svgIcBottomNavBarFixtures,
      positiveColor: const Color(0xff00AEEF),
      negativeColor: const Color(0xff1F1F1F),
      widget: const DashboardFixturesPage(),
    ),
    BottomNavBarItemModel(
      title: "Standings",
      vectorIconPath: AppConfigs.images.svgIcBottomNavBarScores,
      positiveColor: const Color(0xff00AEEF),
      negativeColor: const Color(0xff1F1F1F),
      widget: const DashboardStandingsPage(),
    ),
  ];
}
