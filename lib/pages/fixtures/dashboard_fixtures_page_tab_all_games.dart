import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/dashboard_fixtures_tab_all_games_bloc.dart';
import 'package:football_hockey/components/app_dropdown.dart';
import 'package:football_hockey/models/fixtures/fixture.dart';
import 'package:football_hockey/services/fixtures_service_api.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';



class DashboardFixturesPageTabAllGames extends StatefulWidget {
  const DashboardFixturesPageTabAllGames({super.key});

  @override
  State<DashboardFixturesPageTabAllGames> createState() =>
      _DashboardFixturesPageTabAllGamesState();
}

class _DashboardFixturesPageTabAllGamesState
    extends State<DashboardFixturesPageTabAllGames> {
  final bloc = Get.put(DashboardFixturesTabAllGamesBloc());

  SplayTreeMap<String, List<Fixture>>? fixtureOptions;
  Map<String, _GameResultsListView>? gameResultsWidgets;
  String? index;
  @override
  void initState() {
    super.initState();

    gameResultsWidgets = <String, _GameResultsListView>{};
    if (mounted) {
      setState(() {
        gameResultsWidgets!["default"] =
            const _GameResultsListView(fixtureList: null);
      });
    }

    FixturesServiceAPI.getModel().then((value) {
      if (mounted) {
        setState(() {
          fixtureOptions = value;
          fixtureOptions?.forEach((key, value) {
            {
              if (gameResultsWidgets != null) {
                gameResultsWidgets![key] =
                    (_GameResultsListView(fixtureList: value));
              }
            }
          });
          index = fixtureOptions?.keys.first;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(32.0, 0.0, 32.0, 24.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppDropdown(
                hint: "Game week",
                label: "",
                validator: bloc.gameWeekDropdownValidator,
                defaultValue:
                    fixtureOptions?.keys.toList().firstOrNull ?? "Loading...",
                values: fixtureOptions?.keys.toList() ?? List<String>.empty(),
                onChange: (index) => {
                      if (mounted)
                        {
                          setState(() => this.index = index),
                        }
                    }),
            24.0.verticalSpacer,
            Center(
                child: (gameResultsWidgets?.containsKey(index) ?? false)
                    ? (gameResultsWidgets?[index] ??
                        const CircularProgressIndicator())
                    : const CircularProgressIndicator())
          ]),
    );
  }
}

class _GameResultsListView extends StatelessWidget {
  final List<Fixture>? fixtureList;
  const _GameResultsListView({required this.fixtureList});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(12.0),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: fixtureList?.length ?? 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: _GameResultsListViewItem(
              firstTeamLogo: fixtureList?[index].getHomeTeamLogo() ?? "-",
              firstTeamName: fixtureList?[index].getHomeTeamName() ?? "–",
              firstTeamScore: fixtureList?[index].getHomeScore() ?? "",
              secondTeamLogo: fixtureList?[index].getAwayTeamLogo() ?? "-",
              secondTeamName: fixtureList?[index].getAwayTeamName() ?? "–",
              secondTeamScore: fixtureList?[index].getAwayScore() ?? "",
            ),
          );
        },
      ),
    );
  }
}

class _GameResultsListViewItem extends StatelessWidget {
  const _GameResultsListViewItem({
    required this.firstTeamLogo,
    required this.firstTeamName,
    required this.firstTeamScore,
    required this.secondTeamLogo,
    required this.secondTeamName,
    required this.secondTeamScore,
  });

  final String firstTeamLogo;
  final String firstTeamName;
  final String firstTeamScore;
  final String secondTeamLogo;
  final String secondTeamName;
  final String secondTeamScore;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Center(
            child: _buildLogoAndName(firstTeamLogo, firstTeamName),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: _buildScoresText(firstTeamScore, secondTeamScore),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: _buildLogoAndName(secondTeamLogo, secondTeamName),
          ),
        ),
      ]),
    );
  }

  Widget _buildLogoAndName(String logo, String name) {
    return Column(mainAxisSize: MainAxisSize.min, children: [
      Image.asset(
        logo,
        fit: BoxFit.contain,
        width: 56.0,
        height: 56.0,
      ),
      6.0.verticalSpacer,
      Text(
        name,
        style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      ),
    ]);
  }

  Widget _buildScoresText(String firstTeamScore, String secondTeamScore) {
    TextStyle? style =
        Get.textTheme.headlineMedium?.copyWith(fontWeight: FontWeight.w600);

    return RichText(
      text: TextSpan(children: [
        TextSpan(text: firstTeamScore.toString(), style: style),
        TextSpan(text: " - ", style: style),
        TextSpan(text: secondTeamScore.toString(), style: style),
      ]),
    );
  }
}
