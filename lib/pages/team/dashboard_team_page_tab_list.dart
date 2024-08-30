import 'package:flutter/material.dart';
import 'package:football_hockey/components/players_list_view.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/services/gw_teams_service_api.dart';

class DashboardTeamPageTabList extends StatefulWidget {
  const DashboardTeamPageTabList({super.key});

  @override
  State<DashboardTeamPageTabList> createState() =>
      DashboardTeamPageTabListState();
}

class DashboardTeamPageTabListState extends State<DashboardTeamPageTabList> {
  List<HockeyPlayer>? teamPlayerList;
  HockeyPlayer? captian;
  @override
  void initState() {
    super.initState();

    GWTeamsServiceAPI.getTeamPlayerList(null, true).then((value) {
      if (mounted) {
        setState(() {
          teamPlayerList = value.$1;
          captian =
              value.$2; //isCaptian value is set in the teamPlayerList getter
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final bloc = Get.put(DashboardTeamListTabBloc());

    return (teamPlayerList == null || captian == null)
        ? const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()))
        : Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                PlayersListView(
                    headerTitle: "Captain",
                    headerPadding: const EdgeInsets.all(30.0),
                    headerEditButtonVisible: false,
                    onHeaderEditButtonTap: () {},
                    isCaptain: true,
                    playerList: (captian != null) ? [captian!] : []),
                PlayersListView(
                    headerTitle: "Team",
                    headerPadding: const EdgeInsets.all(30.0),
                    headerEditButtonVisible: false,
                    onHeaderEditButtonTap: () {},
                    isCaptain: false,
                    playerList: teamPlayerList!),
              ]);
  }
}
