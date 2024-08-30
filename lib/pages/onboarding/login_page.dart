import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/login_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_text_form_field_secure_toggle_button.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(LoginBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Login",
        onBackButtonTap: bloc.onAppBarBackButtonTap,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        child: Form(
          key: bloc.formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEmailInput(bloc),
              16.0.verticalSpacer,
              _buildPasswordInput(bloc),
              6.0.verticalSpacer,
              _buildForgotPasswordText(bloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
    );
  }

  Widget _buildEmailInput(LoginBloc bloc) {
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

  Widget _buildPasswordInput(LoginBloc bloc) {
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

  Widget _buildForgotPasswordText(LoginBloc bloc) {
    return GestureDetector(
      onTap: bloc.onForgetPasswordButtonTap,
      behavior: HitTestBehavior.opaque,
      child: Text(
        "Forgot password?",
        style: Get.textTheme.bodySmall?.copyWith(
          color: Get.theme.colorScheme.primary,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _buildPrimaryButton(LoginBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Login",
        onPressed: bloc.onLoginButtonTap,
      ),
    );
  }
}
