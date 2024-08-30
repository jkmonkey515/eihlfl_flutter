import 'package:get/get.dart';


class CheckEmailBloc extends GetxController {
  void onAppBarCloseButtonTap() {
    Get.back();
  }

  void onOpenEmailButtonTap() {
    //Navigate back two till the Login page
    Get.back();
    Get.back();
  }
}
