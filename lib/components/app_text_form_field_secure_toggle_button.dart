import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppTextFormFieldSecureToggleButton extends StatelessWidget {
  const AppTextFormFieldSecureToggleButton({
    super.key,
    required this.boxDimension,
    required this.iconDimension,
    required this.value,
    required this.onTap,
  });

  final double boxDimension;
  final double iconDimension;
  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        width: boxDimension,
        height: boxDimension,
        alignment: Alignment.center,
        child: Opacity(
          opacity: 0.6,
          child: Icon(
            value ? Icons.visibility_off_rounded : Icons.visibility_rounded,
            color: Get.theme.iconTheme.color,
            size: iconDimension,
          ),
        ),
        /* child: SvgPicture.asset(
          value
              ? AppConfigs.images.svgQuillEyeClosed
              : AppConfigs.images.svgEye,
          // ignore: deprecated_member_use
          color: Get.theme.iconTheme.color,
          width: iconDimension,
          height: iconDimension,
        ), */
      ),
    );
  }
}
