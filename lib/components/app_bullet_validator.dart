import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';

class AppBulletValidator extends StatelessWidget {
  const AppBulletValidator({
    super.key,
    required this.value,
    required this.text,
  });

  final bool value;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      _buildBullet(),
      8.0.horizontalSpacer,
      _buildText(),
    ]);
  }

  Widget _buildBullet() {
    double dimension = 9.0;

    return Container(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: value ? const Color(0xff219653) : const Color(0xffE7E6E1),
      ),
    );
  }

  Widget _buildText() {
    return Opacity(
      opacity: 0.4,
      child: Text(
        text,
        style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
