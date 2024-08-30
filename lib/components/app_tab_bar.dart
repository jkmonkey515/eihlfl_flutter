import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class AppTabBar extends StatelessWidget {
  const AppTabBar({
    super.key,
    this.smallTabBar,
    required this.models,
    required this.index,
    required this.onIndexChanged,
  });
  final bool? smallTabBar;
  final List<AppTabBarItemModel> models;
  final int index;
  final void Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int i = 0; i < models.length; i++) {
      children.add(
        Expanded(
          flex: 1,
          child: _AppTabBarItem(
            value: index == i,
            model: models[i],
            onTap: () {
              onIndexChanged(i);
            },
          ),
        ),
      );

      if (i < models.length - 1) {
        children.add(
          const VerticalDivider(width: 0.0),
        );
      }
    }

    return Ink(
      height: smallTabBar == true ? 45.0 : 60.0,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: Row(children: children),
    );
  }
}

class _AppTabBarItem extends StatelessWidget {
  const _AppTabBarItem({
    required this.value,
    required this.model,
    required this.onTap,
  });

  final bool value;
  final AppTabBarItemModel model;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: value ? Get.theme.colorScheme.primary : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (model.vectorIconPath != null)
                AppVectorIcon(
                  boxDimension: 14.0,
                  iconDimension: 14.0,
                  vectorIconPath: model.vectorIconPath!,
                  color: Get.theme.colorScheme.primary,
                ),
              if (model.vectorIconPath != null) 8.0.horizontalSpacer,
              Text(
                model.title,
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AppTabBarItemModel {
  AppTabBarItemModel({
    required this.title,
    this.vectorIconPath,
    required this.widget,
  });

  final String title;
  final String? vectorIconPath;
  final Widget widget;
}
