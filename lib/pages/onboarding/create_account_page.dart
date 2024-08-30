import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/create_account_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_dropdown.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_text_form_field_secure_toggle_button.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CreateAccountPage extends StatelessWidget {
  const CreateAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(CreateAccountBloc());
    var controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
            onProgress: (int progress) {
              // Update loading bar.
              bloc.formLoadingProgress.value = progress.toDouble();
            },
            onPageStarted: (String url) {},
            onPageFinished: (String url) {
              if (url == 'https://submit.jotform.com/240534843058154' ||
                  url == 'https://eu-submit.jotform.com/240534843058154') {
                bloc.onContinueButtonTap();
              }
            },
            onNavigationRequest: (NavigationRequest request) {
              return NavigationDecision.navigate;
            }),
      )
      ..loadRequest(Uri.parse('https://form.jotform.com/240534843058154'));

    return Scaffold(
        resizeToAvoidBottomInset: true,
        appBar: AppToolbar.build(
          titleText: "Create an Account",
          subtitleText: "Step 2/3",
          onBackButtonTap: bloc.onAppBarBackButtonTap,
        ),
        body: Stack(children: <Widget>[
          WebViewWidget(controller: controller),
          Obx(() => (bloc.formLoadingProgress.value < 100.0)
              ? LinearProgressIndicator(
                  value: bloc.formLoadingProgress.value / 100.0,
                )
              : SizedBox()),
        ]));
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

  Widget _buildFirstNameInput(CreateAccountBloc bloc) {
    return AppTextFormField(
      label: "First name",
      hint: "",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: bloc.firstNameTextController,
      validator: bloc.firstNameTextValidator,
      focusNode: bloc.firstNameFocusNode,
      onFieldSubmitted: bloc.onFirstNameTextSubmitted,
    );
  }

  Widget _buildLastNameInput(CreateAccountBloc bloc) {
    return AppTextFormField(
      label: "Last name",
      hint: "",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: bloc.lastNameTextController,
      validator: bloc.lastNameTextValidator,
      focusNode: bloc.lastNameFocusNode,
      onFieldSubmitted: bloc.onLastNameTextSubmitted,
    );
  }

  Widget _buildEmailInput(CreateAccountBloc bloc) {
    return AppTextFormField(
      label: "Email",
      hint: "",
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: bloc.emailTextController,
      validator: bloc.emailTextValidator,
      focusNode: bloc.emailFocusNode,
      onFieldSubmitted: bloc.onEmailTextSubmitted,
    );
  }

  Widget _buildPasswordInput(CreateAccountBloc bloc) {
    return Obx(() {
      return AppTextFormField(
        label: "Password",
        hint: "",
        textInputType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        controller: bloc.passwordTextController,
        validator: bloc.passwordTextValidator,
        focusNode: bloc.passwordFocusNode,
        onFieldSubmitted: bloc.onPasswordTextSubmitted,
        obscureText: !bloc.passwordTextVisible.value,
        suffixIcon: AppTextFormFieldSecureToggleButton(
          boxDimension: 40.0,
          iconDimension: 24.0,
          value: bloc.passwordTextVisible.value,
          onTap: bloc.onPasswordVisibilityChanged,
        ),
      );
    });
  }

  Widget _buildPasswordHintText() {
    return Opacity(
      opacity: 0.7,
      child: Text(
        "Your password must be at least 8 characters long and include numbers.",
        style: Get.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w400),
        textAlign: TextAlign.start,
        maxLines: 2,
      ),
    );
  }

  Widget _buildTeamNameInput(CreateAccountBloc bloc) {
    return AppTextFormField(
      label: "Team name",
      hint: "",
      textInputType: TextInputType.text,
      textInputAction: TextInputAction.next,
      controller: bloc.teamNameTextController,
      validator: bloc.teamNameTextValidator,
      focusNode: bloc.teamNameFocusNode,
      onFieldSubmitted: bloc.onTeamNameTextSubmitted,
    );
  }

  Widget _buildTeamSupportedDropdown(CreateAccountBloc bloc) {
    return Obx(() {
      return AppDropdown(
        label: "Team Supported",
        hint: "",
        validator: bloc.teamSupportedDropdownValidator,
        values: bloc.teamSupportedValues,
        defaultValue: bloc.teamSupportedDefaultValue.value,
        focusNode: bloc.teamSupportedFocusNode,
        onChange: bloc.onTeamSupportedTextSubmitted,
      );
    });
  }
}
