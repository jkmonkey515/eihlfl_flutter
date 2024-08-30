import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/models/gw_teams/gw_team.dart';
import 'package:football_hockey/models/standings/player_standing.dart';
import 'package:football_hockey/models/top_scorers/top_overall_scorer.dart';
import 'package:football_hockey/utils/alert.dart';
import 'package:football_hockey/services/authentication_service.dart';
import 'package:football_hockey/services/gw_teams_service_api.dart';
import 'package:football_hockey/services/player_standing_service_api.dart';
import 'package:football_hockey/services/top_standings_service_api.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app_config.dart';
import '../../app_routes.dart';
import '../../blocs/dashboard_bloc.dart';
import '../../components/app_icon_vector.dart';
import '../../components/categories_list_view.dart';
import '../../components/latest_news_list_view.dart';
import '../../components/league_table_list_view.dart';
import '../../components/point_scorers_list_view.dart';
import '../../utils/spacer.dart';

class DashboardHomePage extends StatefulWidget {
  const DashboardHomePage({super.key});

  @override
  _DashboardHomePageState createState() => _DashboardHomePageState();
}

class _DashboardHomePageState extends State<DashboardHomePage> {
  //Local values
  GWTeam? team;
  List<PlayerStanding>? topTenPlayerStandings;
  List<TopOverallScorer>? topTenOverallPlayers;

  //Initialize state with remote values
  @override
  void initState() {
    super.initState();
    try {
      GWTeamsServiceAPI.getTeamForUser().then((value) => {
            if (mounted)
              {
                setState(() {
                  team = value;
                })
              }
          });
      PlayerStandingServiceAPI.getFirstTen().then((value) => {
            if (mounted)
              {
                setState(() {
                  topTenPlayerStandings = value;
                })
              }
          });
      TopStandingsServiceAPI.getTopTenPlayers().then((value) => {
            if (mounted)
              {
                setState(() {
                  topTenOverallPlayers = value;
                })
              }
          });
    } catch (e) {
      AlertService.showToast(
          "There was a network error while trying to get the home page players");
    }
  }

  @override
  Widget build(BuildContext context) {
    final dashboardBloc = Get.put(DashboardBloc());

    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(children: [
        _buildBackgroundImage(),
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: _HeaderSection(team),
              ),
            ),
            20.0.verticalSpacer,
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CategoriesListView(
                      onManageTeamButtonTap: () {
                        dashboardBloc.onIndexChanged(0);
                      },
                      onTradesButtonTap: () {
                        dashboardBloc.onIndexChanged(1);
                      },
                      onRostersButtonTap: () {
                        Get.toNamed(PageRoutes.rosters);
                      },
                      onFixturesButtonTap: () {
                        dashboardBloc.onIndexChanged(3);
                      },
                      onStandingsButtonTap: () {
                        dashboardBloc.onIndexChanged(4);
                      },
                    ),
                    30.0.verticalSpacer,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: _LabelSection(
                        title: "Latest News",
                        viewAllVisible: false,
                        onViewAllButtonTap: () {},
                      ),
                    ),
                    20.0.verticalSpacer,
                    const LatestNewsListView(),
                    40.0.verticalSpacer,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: _LabelSection(
                        title: "League Table",
                        viewAllVisible: true,
                        onViewAllButtonTap: () {
                          dashboardBloc.onIndexChanged(4);
                        },
                      ),
                    ),
                    5.0.verticalSpacer,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: Skeletonizer(
                          enabled: (topTenPlayerStandings == null),
                          child: LeagueTableListView(
                              playerStandings: topTenPlayerStandings)),
                    ),
                    40.0.verticalSpacer,
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: _LabelSection(
                        title: "Top 10 Point Scorers",
                        viewAllVisible: false,
                        onViewAllButtonTap: () {},
                      ),
                    ),
                    Skeletonizer(
                        enabled: (topTenOverallPlayers == null),
                        child: PointScorersListView(
                            playersList: topTenOverallPlayers)),
                    5.0.verticalSpacer,
                    Center(
                        child: TextButton(
                            onPressed: _homePageHandler,
                            child: const Text(
                              "Logout",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid),
                            ))),
                    Center(
                        child: TextButton(
                            onPressed: _termsAndConditionsHandler,
                            child: const Text(
                              "Terms and Conditions",
                              style: TextStyle(
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.solid),
                            ))),
                    Center(
                        child: TextButton(
                            onPressed: _deleteAccountHandler,
                            child: const Text(
                              "Delete Account",
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                decorationStyle: TextDecorationStyle.solid,
                                color: Colors.red,
                              ),
                            ))),
                    20.0.verticalSpacer,
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }

  void _homePageHandler() {
    AuthenticationService.logout().then(
      (value) {
        Navigator.pushNamedAndRemoveUntil(
            context, PageRoutes.splash, (route) => false);
      },
    );
  }

  void _deleteAccountHandler() async {
    var url = dotenv.env["deleteAccountLink"];
    if (url == null) return;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  void _termsAndConditionsHandler() async {
    var url = dotenv.env["termsAndConditionLink"];
    if (url == null) return;

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  PreferredSize _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(90.0),
      child: Center(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildAppBarLogoButton(),
                _buildSponserBanner(),
                // _buildAppBarMenuButton(), TODO: Enable upon having a menu bar
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSponserBanner() {
    return Row(children: [
      Text(
        "Sponsored By McBookie: ",
        style: Get.textTheme.bodySmall?.copyWith(
            color: AppConfigs.colors.lightBlue, fontStyle: FontStyle.italic),
      ),
      const SizedBox(
        width: 5,
      ),
      ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.asset(
            AppConfigs.images.mcBookieLogo,
            fit: BoxFit.contain,
            width: 36.0,
            height: 36.0,
          ))
    ]);
  }

  Widget _buildAppBarLogoButton() {
    return Image.asset(
      AppConfigs.images.fantasyLogo,
      fit: BoxFit.contain,
      width: 56.0,
      height: 56.0,
    );
  }

  Widget _buildAppBarMenuButton() {
    return AppVectorIcon(
      boxDimension: 48.0,
      iconDimension: 24.0,
      vectorIconPath: AppConfigs.images.svgIcMenu,
      color: Get.theme.colorScheme.primary,
    );
  }

  Widget _buildBackgroundImage() {
    return Image.asset(
      AppConfigs.images.pngImgBackgroundShape1,
      fit: BoxFit.cover,
      width: Get.size.width,
      height: 240.0,
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final GWTeam? teamInfo;
  const _HeaderSection(this.teamInfo);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: Get.size.width,
      height: 230.0,
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomCenter,
          child: _buildCard(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: _buildPlayerImage(),
        ),
      ]),
    );
  }

  Widget _buildCard() {
    return Container(
      width: Get.size.width,
      height: 200.0,
      decoration: BoxDecoration(
        color: const Color(0xffE2E2E2),
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Stack(children: [
        Align(
          alignment: Alignment.bottomRight,
          child: _buildWaveShapeImage(),
        ),
        Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWeekNumberText(teamInfo?.name),
                  12.0.verticalSpacer,
                  _buildPlayerNameText(teamInfo?.teamName),
                  12.0.verticalSpacer,
                  _buildPointText(
                      teamInfo?.points, teamInfo?.highestWeeklyScore),
                ],
              ),
            )),
      ]),
    );
  }

  Widget _buildWaveShapeImage() {
    return Image.asset(
      AppConfigs.images.pngImgBackgroundShapeWave,
      fit: BoxFit.cover,
      height: 120.0,
      width: Get.size.width,
    );
  }

  Widget _buildWeekNumberText(String? weekNumberText) {
    return Skeletonizer(
        enabled: weekNumberText == null,
        child: Text(
          weekNumberText ?? "- - - - - -",
          style: Get.textTheme.titleLarge?.copyWith(
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
          teamName ?? "- - - - - - - -",
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
            fontWeight: FontWeight.w400,
            height: 1.0,
          ),
        ));
  }

  Widget _buildPlayerImage() {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: teamInfo?.getTeamImage() == null
            ? const Align(
                alignment: Alignment.centerRight,
                child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 60.0),
                    child: CircularProgressIndicator()))
            : Image.asset(
                teamInfo?.getTeamImage() ?? "",
                fit: BoxFit.contain,
                height: 230.0,
                width: 160.0,
              ));
  }
}

class _LabelSection extends StatelessWidget {
  const _LabelSection({
    required this.title,
    required this.viewAllVisible,
    required this.onViewAllButtonTap,
  });

  final String title;
  final bool viewAllVisible;
  final VoidCallback onViewAllButtonTap;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text(
        title,
        style: Get.textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
      Visibility(
        visible: viewAllVisible,
        child: GestureDetector(
          onTap: onViewAllButtonTap,
          behavior: HitTestBehavior.opaque,
          child: Text(
            "View all",
            style: Get.textTheme.bodyMedium?.copyWith(
              color: Get.theme.colorScheme.primary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    ]);
  }
}
