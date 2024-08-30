import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({
    super.key,
    required this.currentIndex,
    required this.onIndexChanged,
    required this.models,
  });

  final int currentIndex;
  final void Function(int) onIndexChanged;
  final List<BottomNavBarItemModel> models;

  @override
  Widget build(BuildContext context) {
    var children = <Widget>[];

    for (int index = 0; index < models.length; index++) {
      children.add(
        Expanded(
          flex: 1,
          child: Center(
            child: _BottomNavBarItem(
              isCurrent: index == currentIndex,
              model: models[index],
              onTap: () {
                onIndexChanged(index);
              },
            ),
          ),
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        border: Border(
          top: BorderSide(color: Get.theme.dividerColor),
        ),
      ),
      child: SafeArea(
        child: SizedBox(
          height: 48.0,
          child: Row(
            children: children,
          ),
        ),
      ),
    );
  }
}

class _BottomNavBarItem extends StatelessWidget {
  const _BottomNavBarItem({
    required this.isCurrent,
    required this.model,
    required this.onTap,
  });

  final bool isCurrent;
  final BottomNavBarItemModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        AppVectorIcon(
          boxDimension: 24.0,
          iconDimension: 24.0,
          vectorIconPath: model.vectorIconPath,
          color: model.negativeColor,
        ),
        10.0.verticalSpacer,
        Text(
          model.title,
          style: Get.textTheme.bodySmall?.copyWith(
            color: isCurrent ? model.positiveColor : model.negativeColor,
            fontWeight: FontWeight.w400,
            fontSize: 10.0,
          ),
        ),
      ]),
    );
  }
}

class BottomNavBarItemModel {
  BottomNavBarItemModel({
    required this.title,
    required this.vectorIconPath,
    required this.positiveColor,
    required this.negativeColor,
    required this.widget,
  });

  final String title;
  final String vectorIconPath;
  final Color positiveColor;
  final Color negativeColor;
  final Widget widget;
}
