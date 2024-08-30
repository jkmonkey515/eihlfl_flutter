import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/blocs/dashboard_team_tab_squad_bloc.dart';
import 'package:football_hockey/components/app_tab_bar.dart';
import 'package:football_hockey/models/hockey_players/hockey_player.dart';
import 'package:football_hockey/models/top_scorers/top_overall_scorer.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class DashboardTeamPageTabSquad extends StatefulWidget {
  const DashboardTeamPageTabSquad({super.key});

  @override
  State<DashboardTeamPageTabSquad> createState() =>
      _DashboardTeamPageTabSquadState();
}

class _DashboardTeamPageTabSquadState extends State<DashboardTeamPageTabSquad> {
  final SquadOverallPlayerTransferObject transferObject =
      SquadOverallPlayerTransferObject();

  var playerListReturned = false;
  @override
  void initState() {
    super.initState();
    transferObject.getPlayers().then((value) => {
          if (mounted)
            {
              setState(() {
                if (value == true) {
                  playerListReturned = true;
                }
              })
            }
        });
  }

  @override
  Widget build(BuildContext context) {
    return !playerListReturned
        ? const Padding(
            padding: EdgeInsets.all(20.0),
            child: Center(child: CircularProgressIndicator()))
        : DashboardTeamPageSquadTabinated(
            squadTabBloc:
                DashboardTeamSquadTabBloc(transferObject: transferObject.lines),
          );
  }
}

class DashboardTeamPageSquadTabinated extends StatefulWidget {
  final DashboardTeamSquadTabBloc squadTabBloc;
  const DashboardTeamPageSquadTabinated(
      {super.key, required this.squadTabBloc});

  @override
  State<DashboardTeamPageSquadTabinated> createState() =>
      _DashboardTeamPageSquadTabinatedState();
}

class _DashboardTeamPageSquadTabinatedState
    extends State<DashboardTeamPageSquadTabinated> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      AppTabBar(
          smallTabBar: true,
          models: widget.squadTabBloc.tabBarModels,
          index: widget.squadTabBloc.tabBarCurrentIndex,
          onIndexChanged: (index) {
            if (mounted) {
              setState(() {
                widget.squadTabBloc.onTabBarIndexChanged(index);
              });
            }
          }),
      widget.squadTabBloc.tabBarModels[widget.squadTabBloc.tabBarCurrentIndex]
          .widget
    ]);
  }
}

class DashboardTeamPageTabSquadLine extends StatelessWidget {
  final OverallPlayerPosition line;

  const DashboardTeamPageTabSquadLine({super.key, required this.line});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 20.0),
        child: AspectRatio(
            aspectRatio: 0.75,
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(35.0),
                border: Border.all(color: Get.theme.dividerColor),
              ),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(35.0),
                  child: Stack(children: [
                    AspectRatio(
                      aspectRatio: 0.75,
                      child: SvgPicture.asset(
                        AppConfigs.images.svgImgBackgroundPlayground,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.0.horizontalSpacer,
                            const Spacer(flex: 1),
                            const Expanded(
                              flex: 2,
                              child: Player(),
                            ),
                            16.0.horizontalSpacer,
                            Expanded(
                              flex: 2,
                              child: Player(player: line.netminder),
                            ),
                            16.0.horizontalSpacer,
                            const Expanded(
                              flex: 2,
                              child: Player(),
                            ),
                            const Spacer(flex: 1),
                            16.0.horizontalSpacer,
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.0.horizontalSpacer,
                            const Expanded(
                              flex: 2,
                              child: Player(),
                            ),
                            10.0.horizontalSpacer,
                            Expanded(
                              flex: 2,
                              child: Player(player: line.defenseLeft),
                            ),
                            10.0.horizontalSpacer,
                            Expanded(
                              flex: 2,
                              child: Player(player: line.defenseRight),
                            ),
                            10.0.horizontalSpacer,
                            const Expanded(
                              flex: 2,
                              child: Player(),
                            ),
                            16.0.horizontalSpacer,
                          ],
                        ),
                        Divider(
                          height: 0.0,
                          color: const Color(0xff00AEEF).withOpacity(0.1),
                          thickness: 2.0,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            16.0.horizontalSpacer,
                            const Spacer(flex: 1),
                            Expanded(
                              flex: 2,
                              child: Player(player: line.forwardLeft),
                            ),
                            16.0.horizontalSpacer,
                            Expanded(
                              flex: 2,
                              child: Player(player: line.forwardCenter),
                            ),
                            16.0.horizontalSpacer,
                            Expanded(
                              flex: 2,
                              child: Player(player: line.forwardRight),
                            ),
                            const Spacer(flex: 1),
                            16.0.horizontalSpacer,
                          ],
                        ),
                      ],
                    ),
                  ])),
            )));
  }
}

class Player extends StatelessWidget {
  const Player({super.key, this.player});

  final HockeyPlayer? player;

  @override
  Widget build(BuildContext context) {
    return (player?.getTeamImage() == null)
        ? _buildEmpty()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage(player!.getTeamImage()!),
              8.0.verticalSpacer,
              _buildName(player?.getAbbrevName() ?? ""),
            ],
          );
  }

  Widget _buildEmpty() {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xffFFEFEF),
            width: 2.0,
          ),
        ),
      ),
    );
  }

  Widget _buildImage(String image) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: Image.asset(
        image,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildName(String abbrevName) {
    return FittedBox(
      fit: BoxFit.none,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 3.0),
          decoration: BoxDecoration(
            color: Get.theme.primaryColor,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: (Text(
            abbrevName,
            style: Get.textTheme.bodySmall?.copyWith(
              color: Get.theme.cardColor,
              fontWeight: FontWeight.w400,
              fontSize: 8.0,
            ),
          ))),
    );
  }
}
