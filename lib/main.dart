// import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:football_hockey/services/user_info_service.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'firebase_options.dart';

import 'app_config.dart';
import 'app_routes.dart';

import 'dart:io' show Platform;

Future<void> main() async {
  // ensure initialization
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // load .env variables
  await dotenv.load(fileName: ".env");

  // Load in-app purchases
  await Purchases.setLogLevel(LogLevel.debug);

  PurchasesConfiguration? configuration;
  if (Platform.isAndroid) {
    //TODO: Implement Android
    // configuration = PurchasesConfiguration(<public_google_api_key>);
  } else if (Platform.isIOS) {
    if (dotenv.env["appStoreId"] != null)
      configuration = PurchasesConfiguration(dotenv.env["appStoreId"]!);
  }
  if (configuration != null) Purchases.configure(configuration);

  await GetStorage.init();

  // Get username to check login state
  var username = await UserInfoService.getUserName();
  var showLoginFlow = (username == null);
  runApp(
    // DevicePreview(
    //   enabled: !kReleaseMode,
    //   builder: (context) {
         GetMaterialApp(
          title: 'EIHLFL',
          initialRoute:
              showLoginFlow ? PageRoutes.splash : PageRoutes.dashboard,
          getPages: AppConfigs.routes.getPages,
          theme: AppConfigs.themeData,
          debugShowCheckedModeBanner: false,
          builder: (context, child) {
            return Directionality(
              textDirection: TextDirection.ltr,
              child: child ?? const SizedBox(),
            );
          },
        // );
      // },
    ),
  );
}
