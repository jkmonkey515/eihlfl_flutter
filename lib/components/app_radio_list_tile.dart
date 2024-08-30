import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppRadioListTile extends StatelessWidget {
  const AppRadioListTile({
    super.key,
    required this.titles,
    this.titlesStyle,
    required this.index,
    required this.onIndexChanged,
  });

  final List<String> titles;
  final TextStyle? titlesStyle;
  final int index;
  final void Function(int) onIndexChanged;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: titles.length,
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return _AppRadioListTileItem(
          title: titles[index],
          style: titlesStyle,
          value: index == this.index,
          onTap: () {
            onIndexChanged(index);
          },
        );
      },
      separatorBuilder: (context, index) {
        return const Divider(height: 0.0);
      },
    );
  }
}

class _AppRadioListTileItem extends StatelessWidget {
  const _AppRadioListTileItem({
    required this.title,
    this.style,
    required this.value,
    required this.onTap,
  });

  final String title;
  final TextStyle? style;
  final bool value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: style ??
                  Get.textTheme.bodyLarge
                      ?.copyWith(fontWeight: FontWeight.w600),
            ),
            _AppRadioListTileItemBullet(value: value),
          ],
        ),
      ),
    );
  }
}

class _AppRadioListTileItemBullet extends StatelessWidget {
  const _AppRadioListTileItemBullet({
    required this.value,
  });

  final bool value;

  @override
  Widget build(BuildContext context) {
    double dimension = 24.0;

    return Ink(
      width: dimension,
      height: dimension,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          width: value ? 6.0 : 1.0,
          color:
              value ? Get.theme.colorScheme.secondary : Get.theme.dividerColor,
        ),
      ),
    );
  }
}
