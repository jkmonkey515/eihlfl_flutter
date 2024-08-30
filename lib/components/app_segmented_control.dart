import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../utils/spacer.dart';

class AppSegmentedControl extends StatelessWidget {
  const AppSegmentedControl({
    super.key,
    required this.titles,
    required this.currentIndex,
    required this.onCurrentIndexChanged,
  });

  final List<String> titles;
  final int currentIndex;
  final void Function(int) onCurrentIndexChanged;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [];

    for (int index = 0; index < titles.length; index++) {
      children.add(
        Expanded(
          flex: 1,
          child: _AppSegmentedControlItem(
            text: titles[index],
            selected: index == currentIndex,
            onTap: () {
              onCurrentIndexChanged(index);
            },
          ),
        ),
      );

      if (index < titles.length - 1) {
        children.add(
          4.0.horizontalSpacer,
        );
      }
    }

    return Ink(
      height: 42.0,
      padding: const EdgeInsets.all(4.0),
      color: const Color(0xffF8F8F8),
      child: Row(
        children: children,
      ),
    );
  }
}

class _AppSegmentedControlItem extends StatelessWidget {
  const _AppSegmentedControlItem({
    required this.text,
    required this.selected,
    required this.onTap,
  });

  final String text;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: selected ? Get.theme.cardColor : Colors.transparent,
          boxShadow: selected
              ? [
                  BoxShadow(
                    offset: const Offset(0.0, 3.0),
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 8.0,
                    spreadRadius: 0.0,
                  ),
                  BoxShadow(
                    offset: const Offset(1.0, 1.0),
                    color: Colors.black.withOpacity(0.06),
                    blurRadius: 1.0,
                    spreadRadius: 0.0,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: Get.textTheme.bodyMedium?.copyWith(
              fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
