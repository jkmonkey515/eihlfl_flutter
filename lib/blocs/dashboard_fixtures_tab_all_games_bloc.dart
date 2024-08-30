import 'package:get/get.dart';

class DashboardFixturesTabAllGamesBloc extends GetxController {
  void onGameWeekTextSubmitted(String? value) {
    gameWeekDefaultValue.value = value;
  }

  final gameWeekDefaultValue = RxnString();
  String? gameWeekDropdownValidator(String? value) {
    if (value == null || value.isEmpty) {
      return "Game week is necessary";
    }

    return null;
  }


}
