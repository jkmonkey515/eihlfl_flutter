import 'package:flutter/material.dart';
import 'package:football_hockey/blocs/forget_password_bloc.dart';
import 'package:football_hockey/components/app_bottom_nav_bar_container.dart';
import 'package:football_hockey/components/app_buttons.dart';
import 'package:football_hockey/components/app_text_form_field.dart';
import 'package:football_hockey/components/app_toolbar.dart';
import 'package:get/get.dart';

class ForgetPasswordPage extends StatelessWidget {
  const ForgetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(ForgetPasswordBloc());

    return Scaffold(
      appBar: AppToolbar.build(
        titleText: "Forgot password",
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
              _buildPasswordInput(bloc),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildPrimaryButton(bloc),
    );
  }

  Widget _buildPasswordInput(ForgetPasswordBloc bloc) {
    return AppTextFormField(
      label: "Email address",
      hint: "",
      textInputType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      controller: bloc.emailAddressTextController,
      validator: bloc.emailAddressTextValidator,
      focusNode: bloc.emailAddressFocusNode,
      onFieldSubmitted: bloc.onEmailAddressTextSubmitted,
    );
  }

  Widget _buildPrimaryButton(ForgetPasswordBloc bloc) {
    return AppBottomNavBarContainer(
      child: AppPrimaryButton(
        text: "Reset password",
        onPressed: bloc.onResetPasswordButtonTap,
      ),
    );
  }
}
