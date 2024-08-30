import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/blocs/create_account_step_fee_and_charity_bloc%20copy.dart';
import 'package:football_hockey/blocs/create_account_step_team_submission_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_dropdown.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class AwaitingAccountActivation extends StatelessWidget {
  const AwaitingAccountActivation({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(AwaitingAccountActivationBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Team Submitted",
        subtitleText: "3/3 | Complete",
        backButtonVisible: false,
      ),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildCoverImage(),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: _buildDescriptionText(),
          ),
        ],
      ),
      bottomNavigationBar: _buildBackToLogin(bloc),
    );
  }

  Widget _buildCoverImage() {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Image.asset(
        AppConfigs.images.pngImgBackgroundSignUp,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildDescriptionText() {
    return Container(
      color: Get.theme.colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Expanded(
          flex: 3,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Account Creation Underway",
                style: Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              6.0.verticalSpacer,
              Text(
                "Check your email for confirmation whenver your account is created",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w400),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ],
          ),
        ),
        Expanded(
          flex: 1,
          child: Align(
              alignment: Alignment.centerRight,
              child: SizedBox(
                  width: 30, height: 30, child: CircularProgressIndicator())),
        ),
      ]),
    );
  }

  Widget _buildBackToLogin(AwaitingAccountActivationBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Go to Home",
        onPressed: bloc.onBackToLoginButtonTap,
      ),
    );
  }
}
