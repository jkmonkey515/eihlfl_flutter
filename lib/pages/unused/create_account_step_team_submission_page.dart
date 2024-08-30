import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/create_account_step_team_submission_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_dropdown.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class CreateAccountStepTeamSubmissionPage extends StatelessWidget {
  const CreateAccountStepTeamSubmissionPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(CreateAccountStepTeamSubmissionBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Team Submission",
        subtitleText: "Step 2/3",
        onBackButtonTap: bloc.onAppBarBackButtonTap,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
        child: Form(
          key: bloc.formKey,
          child: Obx(() {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildRulesText(),
                20.0.verticalSpacer,
                _buildHintText(),
                20.0.verticalSpacer,
                AppDropdown(
                  label: "Net minder",
                  hint: "",
                  validator: bloc.netMinderDropdownValidator,
                  values: bloc.netMinderValues,
                  defaultValue: bloc.netMinderDefaultValue.value,
                  onChange: bloc.onNetMinderTextSubmitted,
                ),
                16.0.verticalSpacer,
                _buildDefenceTitleText(),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Defence 1",
                  hint: "",
                  validator: bloc.defence1DropdownValidator,
                  values: bloc.defence1Values,
                  defaultValue: bloc.defence1DefaultValue.value,
                  onChange: bloc.onDefence1TextSubmitted,
                ),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Defence 2",
                  hint: "",
                  validator: bloc.defence2DropdownValidator,
                  values: bloc.defence2Values,
                  defaultValue: bloc.defence2DefaultValue.value,
                  onChange: bloc.onDefence2TextSubmitted,
                ),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Defence 3",
                  hint: "",
                  validator: bloc.defence3DropdownValidator,
                  values: bloc.defence3Values,
                  defaultValue: bloc.defence3DefaultValue.value,
                  onChange: bloc.onDefence3TextSubmitted,
                ),
                6.0.verticalSpacer,
                AppDropdown(
                  label: "Defence 4",
                  hint: "",
                  validator: bloc.defence4DropdownValidator,
                  values: bloc.defence4Values,
                  defaultValue: bloc.defence4DefaultValue.value,
                  onChange: bloc.onDefence4TextSubmitted,
                ),
                16.0.verticalSpacer,
                _buildForwardTitleText(),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Forward 1",
                  hint: "",
                  validator: bloc.forward1DropdownValidator,
                  values: bloc.forward1Values,
                  defaultValue: bloc.forward1DefaultValue.value,
                  onChange: bloc.onForward1TextSubmitted,
                ),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Forward 2",
                  hint: "",
                  validator: bloc.forward2DropdownValidator,
                  values: bloc.forward2Values,
                  defaultValue: bloc.forward2DefaultValue.value,
                  onChange: bloc.onForward2TextSubmitted,
                ),
                16.0.verticalSpacer,
                AppDropdown(
                  label: "Forward 3",
                  hint: "",
                  validator: bloc.forward3DropdownValidator,
                  values: bloc.forward3Values,
                  defaultValue: bloc.forward3DefaultValue.value,
                  onChange: bloc.onForward3TextSubmitted,
                ),
                6.0.verticalSpacer,
                AppDropdown(
                  label: "Forward 4",
                  hint: "",
                  validator: bloc.forward4DropdownValidator,
                  values: bloc.forward4Values,
                  defaultValue: bloc.forward4DefaultValue.value,
                  onChange: bloc.onForward4TextSubmitted,
                ),
                16.0.verticalSpacer,
                _buildCaptainTitleText(),
                16.0.verticalSpacer,
                AppTextFormField(
                  label: "Team captain",
                  hint: "",
                  controller: bloc.teamCaptainTextController,
                  validator: bloc.teamCaptainTextValidator,
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
    );
  }

  Widget _buildRulesText() {
    return Container(
      color: Get.theme.colorScheme.primary.withOpacity(0.1),
      padding: const EdgeInsets.all(10.0),
      child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Rules",
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
            2.0.verticalSpacer,
            Opacity(
              opacity: 0.8,
              child: Text(
                "1 N/M, 6 D, 12 FW. Minimum of 5 British players. Imports are in CAPS. No more than 3 players from each team!",
                style: Get.textTheme.bodySmall
                    ?.copyWith(fontWeight: FontWeight.w500),
                textAlign: TextAlign.start,
                maxLines: 3,
              ),
            ),
          ]),
    );
  }

  Widget _buildHintText() {
    return Opacity(
      opacity: 0.7,
      child: Text(
        "All field are required*",
        style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
      ),
    );
  }

  Widget _buildDefenceTitleText() {
    return Text(
      "Defence",
      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildForwardTitleText() {
    return Text(
      "Forward",
      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildCaptainTitleText() {
    return Text(
      "Capitan",
      style: Get.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600),
    );
  }

  Widget _buildPrimaryButton(CreateAccountStepTeamSubmissionBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Continue",
        onPressed: bloc.onContinueButtonTap,
      ),
    );
  }
}
