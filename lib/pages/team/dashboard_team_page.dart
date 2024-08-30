import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/blocs/dashboard_team_bloc.dart';
import 'package:football_hockey/components/app_tab_bar.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/models/gw_teams/gw_team.dart';
import 'package:football_hockey/services/gw_teams_service_api.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';


class DashboardTeamPage extends StatefulWidget {
  const DashboardTeamPage({super.key});

  @override
  _DashboardTeamPageState createState() => _DashboardTeamPageState();
}

class _DashboardTeamPageState extends State<DashboardTeamPage> {
  late DashboardTeamBloc bloc;
  GWTeam? teamInfo;

  @override
  void initState() {
    super.initState();
    bloc = Get.put(DashboardTeamBloc());
    GWTeamsServiceAPI.getTeamForUser().then(
      (returnValue) {
        if (mounted) {
          setState(() {
            teamInfo = returnValue;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Team",
        backButtonVisible: false,
      ),
      body: Obx(() {
        return Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _HeaderSection(teamInfo: teamInfo),
            AppTabBar(
              models: bloc.tabBarModels,
              index: bloc.tabBarCurrentIndex.value,
              onIndexChanged: bloc.onTabBarIndexChanged,
            ),
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

class _HeaderSection extends StatefulWidget {
  final GWTeam? teamInfo;
  const _HeaderSection({this.teamInfo});

  @override
  _HeaderSectionState createState() => _HeaderSectionState();
}

class _HeaderSectionState extends State<_HeaderSection> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppConfigs.images.pngImgBackgroundShape1),
          fit: BoxFit.cover,
        ),
      ),
      child: Row(children: [
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildWeekNumberText(widget.teamInfo?.name),
              12.0.verticalSpacer,
              _buildPlayerNameText(widget.teamInfo?.teamName),
              12.0.verticalSpacer,
              _buildPointText(
                  widget.teamInfo?.points, widget.teamInfo?.highestWeeklyScore),
            ],
          ),
        ),
        Expanded(
          child: Align(
            alignment: Alignment.center,
            child: _buildPlayerImage(widget.teamInfo?.getTeamImage()),
          ),
        ),
      ]),
    );
  }

  Widget _buildWeekNumberText(String? weekNumberText) {
    return Skeletonizer(
        enabled: weekNumberText == null,
        child: Text(
          weekNumberText ?? "- - - - - -",
          style: Get.textTheme.titleLarge?.copyWith(
            color: Get.theme.cardColor,
            fontWeight: FontWeight.w700,
            fontSize: 18.0,
            height: 1.0,
          ),
        ));
  }

  Widget _buildPlayerNameText(String? teamName) {
    return Skeletonizer(
        enabled: teamName == null,
        child: Text(
          teamName ?? "- - - - - - -",
          style: GoogleFonts.viga(
            color: Get.theme.colorScheme.primary,
            fontWeight: FontWeight.w400,
            fontSize: 22.0,
            height: 1.0,
          ),
        ));
  }

  Widget _buildPointText(int? points, int? highestWeeklyScore) {
    return Skeletonizer(
        enabled: points == null || highestWeeklyScore == null,
        child: Text(
          "${points ?? 0} / ${highestWeeklyScore ?? 0} PTS",
          style: Get.textTheme.bodyLarge?.copyWith(
            color: Get.theme.cardColor,
            fontWeight: FontWeight.w400,
            fontSize: 18.0,
            height: 1.0,
          ),
        ));
  }

  Widget _buildPlayerImage(String? teamImage) {
    return teamImage == null
        ? const Center(child: CircularProgressIndicator())
        : Image.asset(
            teamImage,
            alignment: Alignment.topCenter,
            fit: BoxFit.cover,
            height: 176.0,
            width: 150.0,
          );
  }
}
