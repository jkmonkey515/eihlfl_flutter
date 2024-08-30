import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config.dart';

class LatestNewsListView extends StatelessWidget {
  const LatestNewsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 170.0,
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 30.0),
          children: [_LatestNewsListViewItem()],
        )

        //   itemBuilder: (context, index) {
        //     return _LatestNewsListViewItem(isOdd: index.isOdd);
        //   },
        //   separatorBuilder: (context, index) {
        //     return 15.0.horizontalSpacer;
        //   },
        // ),
        );
  }
}

class _LatestNewsListViewItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 170.0,
      width: 240.0,
      decoration: BoxDecoration(
        color: Get.theme.cardColor,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(color: Get.theme.dividerColor),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCoverImage(),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTitleText(),
                    // Add more news items here in future iterations
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCoverImage() {
    return Image.asset(
      AppConfigs.images.slapshotVintageLogo,
      fit: BoxFit.cover,
      width: 240.0,
      height: 130.0,
    );
  }

  Widget _buildNewsBadge() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      decoration: BoxDecoration(
        color: Get.theme.primaryColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
      child: Text(
        "News",
        style: Get.textTheme.bodySmall?.copyWith(
          color: Get.theme.cardColor,
          fontWeight: FontWeight.w400,
          fontSize: 9.0,
        ),
      ),
    );
  }

  Widget _buildDateText() {
    return Text(
      "01/01/2023",
      style: Get.textTheme.bodySmall?.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: 10.0,
      ),
    );
  }

  Widget _buildTitleText() {
    return Text(
      "Slap Shot Player of the Week",
      style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600),
    );
  }
}
