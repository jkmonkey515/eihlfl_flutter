import 'package:flutter/material.dart';

import 'app_icon_vector.dart';

class AppToolbarIcon extends StatelessWidget {
  const AppToolbarIcon({
    super.key,
    required this.vectorIconPath,
    required this.onTap,
    this.color,
  });

  final String vectorIconPath;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return AppVectorIcon(
      boxDimension: 40.0,
      iconDimension: 24.0,
      vectorIconPath: vectorIconPath,
      onTap: onTap,
    );
  }
}
