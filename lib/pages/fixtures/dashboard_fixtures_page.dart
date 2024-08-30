import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/dashboard_fixtures_bloc.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:get/get.dart';

class DashboardFixturesPage extends StatelessWidget {
  const DashboardFixturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(DashboardFixturesBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Fixtures",
        backButtonVisible: false,
      ),
      body: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: bloc.tabBarCurrentWidget.value,
              ),
            ),
          ],
        );
      }),
    );
  }
}
