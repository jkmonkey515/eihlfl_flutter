import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class CustomLauncher {
  Future<void> open({
    required String url,
    LaunchMode? mode,
    String? webOnlyWindowName,
  }) async {
    launchUrlString(
      url,
      mode: mode ?? LaunchMode.externalApplication,
      webOnlyWindowName: webOnlyWindowName ?? '_self',
    );
  }

  Future<void> callTo({required String phoneNumber}) async {
    launchUrl(Uri(
      scheme: "tel",
      path: phoneNumber,
    ));
  }

  Future<void> mailTo({required String emailAddress}) async {
    launchUrl(Uri(
      scheme: "mailto",
      path: emailAddress,
    ));
  }
}
