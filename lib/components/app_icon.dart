import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppIcon extends StatelessWidget {
  const AppIcon({
    super.key,
    required this.boxDimension,
    required this.iconDimension,
    required this.icon,
    this.color,
    this.onTap,
  });

  final double boxDimension;
  final double iconDimension;
  final IconData icon;
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
          child: Icon(
            icon,
            // ignore: deprecated_member_use
            color: color ?? Get.theme.iconTheme.color,
            size: iconDimension,
          ),
        ),
      ),
    );
  }
}
