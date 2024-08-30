import 'package:flutter/material.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/models/standings/player_standing.dart';
import 'package:football_hockey/pages/standings/dashboard_standings_page_tab_league_table.dart';
import 'package:football_hockey/services/player_standing_service_api.dart';
import 'package:skeletonizer/skeletonizer.dart';

class DashboardStandingsPage extends StatefulWidget {
  const DashboardStandingsPage({super.key});

  @override
  State<DashboardStandingsPage> createState() => _DashboardStandingsPageState();
}

class _DashboardStandingsPageState extends State<DashboardStandingsPage> {
  List<PlayerStanding>? playerStandings;
  @override
  void initState() {
    super.initState();
    PlayerStandingServiceAPI.getModel().then((value) {
      if (mounted) {
        setState(() {
          playerStandings = value;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppToolbar.build(
          titleText: "Standings",
          backButtonVisible: false,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                child: Skeletonizer(
              enabled: playerStandings == null,
              child: SingleChildScrollView(
                child: DashboardStandingsPageTabLeagueTable(
                    playerStandings: playerStandings),
              ),
            )),
          ],
        ));
  }
}
