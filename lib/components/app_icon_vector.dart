import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppVectorIcon extends StatelessWidget {
  const AppVectorIcon({
    super.key,
    required this.boxDimension,
    required this.iconDimension,
    required this.vectorIconPath,
    this.color,
    this.onTap,
  });

  final double boxDimension;
  final double iconDimension;
  final String vectorIconPath;
  final Color? color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox.square(
        dimension: boxDimension,
        child: Center(
          child: SvgPicture.asset(
            vectorIconPath,
            // ignore: deprecated_member_use
            color: color ?? Get.theme.iconTheme.color,
            width: iconDimension,
            height: iconDimension,
          ),
        ),
      ),
    );
  }
}
