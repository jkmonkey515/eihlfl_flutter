import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../blocs/dashboard_bloc.dart';
import '../components/app_bottom_nav_bar.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(DashboardBloc());

    return Scaffold(
      body: _buildBody(bloc),
      bottomNavigationBar: _buildBottomNavBar(bloc),
    );
  }

  Widget _buildBody(DashboardBloc bloc) {
    return Obx(() {
      return bloc.currentWidget.value;
    });
  }

  Widget _buildBottomNavBar(DashboardBloc bloc) {
    return Obx(() {
      return AppBottomNavBar(
        currentIndex: bloc.currentIndex.value,
        onIndexChanged: bloc.onIndexChanged,
        models: bloc.models,
      );
    });
  }
}
