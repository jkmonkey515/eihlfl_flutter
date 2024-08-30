import 'package:flutter/material.dart';

class AppColors {
  MaterialColor red = getMaterialColor(const Color(0xffCB202D));
  MaterialColor green = getMaterialColor(const Color(0xff69BC63));
  MaterialColor white = getMaterialColor(const Color(0xffFFFFFF));
  MaterialColor black = getMaterialColor(const Color(0xff000000));
  MaterialColor santaFe = getMaterialColor(const Color(0xffB87253));
  MaterialColor mineShaft = getMaterialColor(const Color(0xff2D2D2D));
  MaterialColor lightBlue = getMaterialColor(const Color(0xffD0E1E8));

  Gradient badgeGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomRight,
    colors: [
      const Color(0xffFFFFFF),
      const Color(0xffB87253).withOpacity(0.2),
    ],
  );

  Gradient productGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xff000000).withOpacity(0.7),
      const Color(0xff000000).withOpacity(0.0),
    ],
  );

  static MaterialColor getMaterialColor(Color color) {
    final int red = color.red;
    final int green = color.green;
    final int blue = color.blue;

    final Map<int, Color> shades = {
      50: Color.fromRGBO(red, green, blue, .1),
      100: Color.fromRGBO(red, green, blue, .2),
      200: Color.fromRGBO(red, green, blue, .3),
      300: Color.fromRGBO(red, green, blue, .4),
      400: Color.fromRGBO(red, green, blue, .5),
      500: Color.fromRGBO(red, green, blue, .6),
      600: Color.fromRGBO(red, green, blue, .7),
      700: Color.fromRGBO(red, green, blue, .8),
      800: Color.fromRGBO(red, green, blue, .9),
      900: Color.fromRGBO(red, green, blue, 1),
    };

    return MaterialColor(color.value, shades);
  }
}
