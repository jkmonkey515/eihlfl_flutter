import 'package:flutter/material.dart';
import 'package:football_hockey/app_config.dart';
import 'package:football_hockey/blocs/create_account_step_fee_and_charity_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class CreateAccountStepFeeAndCharityPage extends StatelessWidget {
  const CreateAccountStepFeeAndCharityPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(CreateAccountStepFeeAndCharityBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Fee and Charity",
        subtitleText: "Step 1/3",
        onBackButtonTap: bloc.onAppBarBackButtonTap,
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCoverImage(),
            Padding(
                padding: EdgeInsets.all(16.0), child: _buildDescriptionText()),
            const Divider(height: 0.0),
            16.0.verticalSpacer,
          ],
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
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
                "EIHLFL Entry Fee and Charity Donation",
                style: Get.textTheme.bodyMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              6.0.verticalSpacer,
              Text(
                "Half of all entries this year will go to Macmillan Cancer",
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
            child: Text(
              "£4.99",
              style: Get.textTheme.bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildPrimaryButton(CreateAccountStepFeeAndCharityBloc bloc) {
    return AppBottomNavBarContainer(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(children: [
        Expanded(
          flex: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "£4.99",
                style: Get.textTheme.titleMedium
                    ?.copyWith(fontWeight: FontWeight.w600),
              ),
              4.0.verticalSpacer,
              Opacity(
                opacity: 0.6,
                child: Text(
                  "Total fee",
                  style: Get.textTheme.bodyMedium
                      ?.copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            flex: 1,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              AppPrimaryButton(
                text: "Purchase Account",
                onPressed: bloc.onSubmitButtonTap,
              ),
              TextButton(
                  onPressed: bloc.onRestoreButtonTap,
                  child: Text(
                    "Restore",
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ))
            ])),
      ]),
    );
  }
}
