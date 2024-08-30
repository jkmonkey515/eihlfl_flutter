import 'package:flutter/material.dart';
import 'package:football_hockey/components/league_table_list_view.dart';
import 'package:football_hockey/models/standings/player_standing.dart';

class DashboardStandingsPageTabLeagueTable extends StatelessWidget {
  final List<PlayerStanding>? playerStandings;
  const DashboardStandingsPageTabLeagueTable({super.key, this.playerStandings});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 10.0),
      child: LeagueTableListView(playerStandings: playerStandings),
    );
  }
}
