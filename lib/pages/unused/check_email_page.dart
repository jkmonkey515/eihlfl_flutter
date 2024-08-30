import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/blocs/check_email_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_icon_vector.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';


class CheckEmailPage extends StatelessWidget {
  const CheckEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(CheckEmailBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Check your email",
        onBackButtonTap: bloc.onAppBarCloseButtonTap,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildImage(bloc),
              16.0.verticalSpacer,
              _buildTitleText(bloc),
              6.0.verticalSpacer,
              _buildDescriptionText(bloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
    );
  }

  Widget _buildImage(CheckEmailBloc bloc) {
    return AppVectorIcon(
      boxDimension: 72.0,
      iconDimension: 54.0,
      vectorIconPath: AppConfigs.images.svgIcMailOpened,
    );
  }

  Widget _buildTitleText(CheckEmailBloc bloc) {
    return Text(
      "Check your email",
      style: Get.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildDescriptionText(CheckEmailBloc bloc) {
    return Text(
      "Almost there! We've dropped an email in your inbox with a link to create a new password. If you can't find it, peek into your spam folder just in case.",
      style: Get.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w400),
      textAlign: TextAlign.center,
      maxLines: 3,
    );
  }

  Widget _buildPrimaryButton(CheckEmailBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Back to Login",
        onPressed: bloc.onOpenEmailButtonTap,
      ),
    );
  }
}
