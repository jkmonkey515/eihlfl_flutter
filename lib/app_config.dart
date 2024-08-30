import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';
import 'app_constants.dart';
import 'app_images.dart';
import 'app_routes.dart';

class AppConfigs {
  static final AppConfigs _singleton = AppConfigs._internal();

  factory AppConfigs() => _singleton;

  AppConfigs._internal();

  static AppColors colors = AppColors();
  static AppConstants constants = AppConstants();
  static AppImages images = AppImages();
  static AppRoutes routes = AppRoutes();

  static final _textStyle = GoogleFonts.openSans(
    color: const Color(0xff1C1717),
    letterSpacing: 0.0,
  );

  static ThemeData themeData = ThemeData(
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayLarge: _textStyle.copyWith(
        fontSize: 96.0,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
      ),
      displayMedium: _textStyle.copyWith(
        fontSize: 60.0,
        fontWeight: FontWeight.w300,
        overflow: TextOverflow.ellipsis,
      ),
      displaySmall: _textStyle.copyWith(
        fontSize: 48.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      headlineMedium: _textStyle.copyWith(
        fontSize: 34.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      headlineSmall: _textStyle.copyWith(
        fontSize: 24.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      titleLarge: _textStyle.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      titleMedium: _textStyle.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      titleSmall: _textStyle.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      bodyLarge: _textStyle.copyWith(
        fontSize: 16.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      bodyMedium: _textStyle.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      bodySmall: _textStyle.copyWith(
        fontSize: 12.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
      labelLarge: _textStyle.copyWith(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        overflow: TextOverflow.ellipsis,
      ),
      labelSmall: _textStyle.copyWith(
        fontSize: 10.0,
        fontWeight: FontWeight.w400,
        overflow: TextOverflow.ellipsis,
      ),
    ),
    primaryColor: Colors.black,
    colorScheme: const ColorScheme.light(
      brightness: Brightness.light,
      primary: Color(0xff00AEEF),
      secondary: Color(0xffFF5E5E),
      background: Color(0xffF5F5F5),
    ),
    visualDensity: VisualDensity.adaptivePlatformDensity,
    scaffoldBackgroundColor: const Color(0xffF5F5F5),
    dividerColor: const Color(0xffE2E2E2),
    dividerTheme: const DividerThemeData(
      color: Color(0xffE2E2E2),
      thickness: 1.0,
    ),
    cardColor: const Color(0xffFFFFFF),
    iconTheme: const IconThemeData(
      color: Color(0xff1F1F1F),
      size: 24.0,
    ),
    appBarTheme: AppBarTheme(
      elevation: 1.0,
      toolbarHeight: 60.0,
      shadowColor: const Color(0xffE2E2E2),
      backgroundColor: const Color(0xffFFFFFF),
      titleTextStyle: _textStyle.copyWith(
        fontSize: 20.0,
        fontWeight: FontWeight.w600,
        overflow: TextOverflow.ellipsis,
        color: const Color(0xff1C1717),
      ),
      iconTheme: const IconThemeData(
        color: Color(0xff1C1717),
        size: 24.0,
      ),
      actionsIconTheme: const IconThemeData(
        color: Color(0xff1C1717),
        size: 24.0,
      ),
    ),
  );

  static void makeStatusBarTransparent() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
    );
  }
}
