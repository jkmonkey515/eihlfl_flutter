import 'package:flutter/material.dart';
import 'package:football_hockey/models/top_scorers/top_scorer_by_team_per_week.dart';
import 'package:football_hockey/services/top_standings_service_api.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../app_config.dart';
import '../../blocs/rosters_bloc.dart';
import '../../components/app_icon_vector.dart';
import '../../components/rosters_list_view.dart';

class RostersPage extends StatefulWidget {
  const RostersPage({super.key});

  @override
  State<RostersPage> createState() => _RostersPageState();
}

class _RostersPageState extends State<RostersPage> {
  List<TopScorerByTeamPerWeek>? playersList;
  @override
  void initState() {
    super.initState();
    TopStandingsServiceAPI.getModel<TopScorerByTeamPerWeek>().then((value) => {
          setState(() {
            playersList = value;
          })
        });
  }

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(RostersBloc());

    return Scaffold(
      appBar: _buildAppBar(bloc),
      body: RostersListView(playersList: playersList),
    );
  }

  PreferredSize _buildAppBar(RostersBloc bloc) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(AppConfigs.images.pngImgBackgroundShape1),
            fit: BoxFit.cover,
          ),
          border: Border(
            bottom: BorderSide(color: Get.theme.dividerColor),
          ),
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 24.0),
              child: Row(
                children: [
                  _buildAppBarBackIconButton(bloc),
                  Expanded(
                    child: _buildAppBarTitleText(bloc),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarBackIconButton(RostersBloc bloc) {
    return AppVectorIcon(
      boxDimension: 40.0,
      iconDimension: 20.0,
      vectorIconPath: AppConfigs.images.svgIcArrowLeft,
      color: Get.theme.cardColor,
      onTap: bloc.onAppBarBackButtonTap,
    );
  }

  Widget _buildAppBarTitleText(RostersBloc bloc) {
    return Text(
      "ROSTERS",
      style: GoogleFonts.viga(
        color: Get.theme.colorScheme.primary,
        fontWeight: FontWeight.w400,
        fontSize: 22.0,
      ),
    );
  }
}
