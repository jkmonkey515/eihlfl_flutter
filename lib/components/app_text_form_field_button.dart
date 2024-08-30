import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AppTextFormFieldButton extends StatelessWidget {
  const AppTextFormFieldButton({
    super.key,
    required this.boxDimension,
    required this.iconDimension,
    required this.icon,
    this.color,
  });

  final double boxDimension;
  final double iconDimension;
  final String icon;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: boxDimension,
      height: boxDimension,
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(4.0),
      child: SvgPicture.asset(
        icon,
        // ignore: deprecated_member_use
        color: color ?? Get.theme.iconTheme.color,
        width: iconDimension,
        height: iconDimension,
      ),
    );
  }
}
