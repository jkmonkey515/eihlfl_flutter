import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../app_config.dart';
import '../blocs/splash_bloc.dart';
import '../components/app_buttons.dart';
import '../utils/spacer.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = Get.put(SplashBloc());

    return Scaffold(
      backgroundColor: Get.theme.colorScheme.primary,
      body: Stack(alignment: Alignment.bottomCenter, children: [
        _buildBackgroundGradient(),
        SafeArea(
          child: Column(
            children: [
              10.0.verticalSpacer,
              _buildLogoImage(),
              10.0.verticalSpacer,
              _buildCoverImage(),
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: _buildGreetingText(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildDescriptionText(),
              ),
              15.0.verticalSpacer,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildLoginButton(bloc),
              ),
              5.0.verticalSpacer,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: _buildSignUpButton(bloc),
              ),
              6.0.verticalSpacer,
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50.0),
                child: _buildTermsAndConditionsText(bloc),
              ),
              6.0.verticalSpacer,
            ],
          ),
        ),
      ]),
    );
  }

  Widget _buildBackgroundGradient() {
    return Container(
      width: Get.size.width,
      height: Get.size.height * 0.5,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Color(0xff000000),
            Color(0xff00AEEF),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoImage() {
    return SizedBox.square(
      dimension: 80.0,
      child: Image.asset(
        AppConfigs.images.pngImgLogo,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildCoverImage() {
    return AspectRatio(
      aspectRatio: 1.5,
      child: Stack(fit: StackFit.expand, children: [
        Image.asset(
          AppConfigs.images.pngImgBackgroundSplash,
          fit: BoxFit.cover,
        ),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xff005E93),
                Colors.transparent,
                Colors.transparent,
                Color(0xff005E93),
              ],
            ),
          ),
        ),
      ]),
    );
  }

  Widget _buildGreetingText() {
    return Text(
      "Welcome to the EIHLFL!",
      style: GoogleFonts.viga(
        color: Get.theme.cardColor,
        fontWeight: FontWeight.w400,
        fontSize: 40.0,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Widget _buildDescriptionText() {
    return Text(
      "Login to view your team or sign up below.",
      style: Get.textTheme.bodyLarge?.copyWith(
        color: Get.theme.cardColor,
        fontWeight: FontWeight.w400,
      ),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }

  Widget _buildLoginButton(SplashBloc bloc) {
    return AppPrimaryButton(
      text: "Login",
      onPressed: bloc.onLogInButtonTap,
      textStyle: Get.textTheme.titleMedium?.copyWith(
        color: Get.theme.iconTheme.color,
        fontWeight: FontWeight.w700,
      ),
      color: Get.theme.cardColor,
    );
  }

  Widget _buildSignUpButton(SplashBloc bloc) {
    return AppTextButton(
      text: "Sign Up",
      onPressed: bloc.onSignUpButtonTap,
      textStyle: Get.textTheme.titleMedium?.copyWith(
        color: Get.theme.cardColor,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildTermsAndConditionsText(SplashBloc bloc) {
    TextStyle? style = Get.textTheme.bodySmall?.copyWith(
      color: Get.theme.cardColor,
      fontWeight: FontWeight.w400,
    );

    return RichText(
      text: TextSpan(children: [
        TextSpan(
          text: "By proceeding, you accept our ",
          style: style,
        ),
        TextSpan(
          text: "Terms and Conditions",
          style: style?.copyWith(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = bloc.onTermsAndConditionsButtonTap,
        ),
        TextSpan(
          text: " & ",
          style: style,
        ),
        TextSpan(
          text: "Privacy Policy",
          style: style?.copyWith(
            decoration: TextDecoration.underline,
            fontWeight: FontWeight.w500,
          ),
          recognizer: TapGestureRecognizer()
            ..onTap = bloc.onPrivacyPolicyButtonTap,
        ),
        TextSpan(
          text: ".",
          style: style,
        ),
      ]),
      textAlign: TextAlign.center,
      maxLines: 2,
    );
  }
}
