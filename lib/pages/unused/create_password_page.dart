import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/create_password_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_text_form_field_secure_toggle_button.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:football_hockey/utils/spacer.dart';
import 'package:get/get.dart';

class CreatePasswordPage extends StatelessWidget {
  const CreatePasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(CreatePasswordBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Create password",
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
              _buildHintText(),
              16.0.verticalSpacer,
              _buildPasswordInput(bloc),
              16.0.verticalSpacer,
              _buildConfirmNewPasswordInput(bloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
    );
  }

  Widget _buildHintText() {
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

  Widget _buildPasswordInput(CreatePasswordBloc bloc) {
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

  Widget _buildConfirmNewPasswordInput(CreatePasswordBloc bloc) {
    return Obx(() {
      return AppTextFormField(
        label: "Confirm new password",
        hint: "",
        textInputType: TextInputType.visiblePassword,
        textInputAction: TextInputAction.next,
        controller: bloc.confirmNewPasswordTextController,
        validator: bloc.confirmNewPasswordTextValidator,
        focusNode: bloc.confirmNewPasswordFocusNode,
        onFieldSubmitted: bloc.onConfirmNewPasswordTextSubmitted,
        obscureText: !bloc.confirmNewPasswordTextVisible.value,
        suffixIcon: AppTextFormFieldSecureToggleButton(
          boxDimension: 40.0,
          iconDimension: 24.0,
          value: bloc.confirmNewPasswordTextVisible.value,
          onTap: bloc.onConfirmNewPasswordVisibilityChanged,
        ),
      );
    });
  }

  Widget _buildPrimaryButton(CreatePasswordBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Reset password",
        onPressed: bloc.onResetPasswordButtonTap,
      ),
    );
  }
}
