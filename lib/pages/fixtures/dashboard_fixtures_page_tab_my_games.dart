import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class DashboardFixturesPageTabMyGames extends StatelessWidget {
  const DashboardFixturesPageTabMyGames({super.key});

  @override
  Widget build(BuildContext context) {
    // final bloc = Get.put(DashboardFixturesTabMyGamesBloc());

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100.0),
      child: Center(
        child: Text(
          "My games \nis under development",
          style: GoogleFonts.viga(
            color: Get.theme.colorScheme.primary,
            fontWeight: FontWeight.w400,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
          maxLines: 2,
        ),
      ),
    );
  }
}
