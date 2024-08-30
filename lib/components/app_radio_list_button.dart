import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';

class AppRadioListButton extends StatelessWidget {
  const AppRadioListButton({
    super.key,
    required this.selectedIndex,
    required this.titles,
    required this.onItemTap,
  });

  final int selectedIndex;
  final List<String> titles;
  final void Function(int) onItemTap;

  @override
  Widget build(BuildContext context) {
    return Ink(
      height: 64.0,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView.separated(
        itemCount: titles.length,
        shrinkWrap: true,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return _AppRadioListButtonItem(
            selected: index == selectedIndex,
            title: titles[index],
            onTap: () {
              onItemTap(index);
            },
          );
        },
        separatorBuilder: (context, index) {
          return 10.0.horizontalSpacer;
        },
      ),
    );
  }
}

class _AppRadioListButtonItem extends StatelessWidget {
  const _AppRadioListButtonItem({
    required this.selected,
    required this.title,
    required this.onTap,
  });

  final bool selected;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: selected ? Get.theme.colorScheme.primary : Colors.transparent,
          border: Border.all(
            color: selected
                ? Get.theme.colorScheme.primary
                : Get.theme.dividerColor,
          ),
        ),
        child: Center(
          child: Text(
            title,
            style: Get.textTheme.bodyMedium?.copyWith(
              color:
                  selected ? AppConfigs.colors.white : AppConfigs.colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
