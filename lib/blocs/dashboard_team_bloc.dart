import 'package:flutter/material.dart';
import 'package:football_hockey/pages/team/dashboard_team_page_tab_list.dart';
import 'package:football_hockey/pages/team/dashboard_team_page_tab_squad.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../components/app_tab_bar.dart';


class DashboardTeamBloc extends GetxController {
  var isLoading = false;
  final tabBarCurrentIndex = RxInt(0);
  final tabBarCurrentWidget = Rx<Widget>(const DashboardTeamPageTabSquad());

  void onTabBarIndexChanged(int value) {
    tabBarCurrentIndex.value = value;
    tabBarCurrentWidget.value = tabBarModels[value].widget;
  }

  final tabBarModels = <AppTabBarItemModel>[
    AppTabBarItemModel(
      title: "Squad",
      vectorIconPath: AppConfigs.images.svgIcTeamManagement,
      widget: const DashboardTeamPageTabSquad(),
    ),
    AppTabBarItemModel(
      title: "List",
      vectorIconPath: AppConfigs.images.svgIcList,
      widget:  const DashboardTeamPageTabList(),
    ),
  ];
}
