import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../app_config.dart';
import '../utils/spacer.dart';
import 'app_icon_vector.dart';

class AppToolbar {
  static AppBar build({
    required String titleText,
    String? subtitleText,
    bool? backButtonVisible,
    String? backButtonVectorIconPath,
    VoidCallback? onBackButtonTap,
  }) {
    return AppBar(
      elevation: 0.5,
      leadingWidth: double.infinity,
      leading: Row(children: [
        _buildAppBarBackIconButton(
          backButtonVisible,
          backButtonVectorIconPath,
          onBackButtonTap,
        ),
        if (backButtonVisible ?? true) 4.0.horizontalSpacer,
        Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildAppBarTitleText(titleText),
              if (subtitleText != null) _buildAppBarSubtitleText(subtitleText),
            ],
          ),
        ),
      ]),
    );
  }

  static Widget _buildAppBarBackIconButton(
    bool? visible,
    String? vectorIconPath,
    VoidCallback? onTap,
  ) {
    return visible ?? true
        ? AppVectorIcon(
            boxDimension: 48.0,
            iconDimension: 20.0,
            vectorIconPath: vectorIconPath ?? AppConfigs.images.svgIcArrowLeft,
            color: Get.theme.iconTheme.color,
            onTap: onTap,
          )
        : const SizedBox.square(dimension: 24.0);
  }

  static Widget _buildAppBarTitleText(String titleText) {
    return Text(
      titleText,
      style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  static Widget _buildAppBarSubtitleText(String? subtitleText) {
    return Opacity(
      opacity: 0.8,
      child: Text(
        subtitleText ?? "",
        style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }
}
