import 'package:football_hockey/pages/onboarding/awaiting_account_activation.dart';
import 'package:football_hockey/pages/unused/check_email_page.dart';
import 'package:football_hockey/pages/onboarding/create_account_page.dart';
import 'package:football_hockey/pages/onboarding/create_account_step_fee_and_charity_page.dart';
import 'package:football_hockey/pages/unused/create_password_page.dart';
import 'package:football_hockey/pages/onboarding/forget_password_page.dart';
import 'package:football_hockey/pages/onboarding/login_page.dart';
import 'package:get/get.dart';

import 'pages/dashboard_page.dart';
import 'pages/rosters/rosters_page.dart';
import 'pages/splash_page.dart';

class PageRoutes {
  static String checkEmail = '/check_email';
  static String createAccount = '/create_account';

  static String createAccountStepFeeAndCharity =
      '/create_account_step_fee_and_charity';
  static String awaitingAccountActivation = '/awaitingAccountActivation';
  static String createPassword = '/create_password';
  static String dashboard = '/dashboard';
  static String forgetPassword = '/forget_password';
  static String login = '/login';
  static String rosters = '/rosters';
  static String splash = '/';
}

class AppRoutes {
  List<GetPage> get getPages {
    return [
      GetPage(
        name: PageRoutes.checkEmail,
        page: () => const CheckEmailPage(),
      ),
      GetPage(
        name: PageRoutes.createAccount,
        page: () => const CreateAccountPage(),
      ),
      GetPage(
        name: PageRoutes.createAccountStepFeeAndCharity,
        page: () => const CreateAccountStepFeeAndCharityPage(),
      ),
      GetPage(
        name: PageRoutes.awaitingAccountActivation,
        page: () => const AwaitingAccountActivation(),
      ),
      GetPage(
        name: PageRoutes.createPassword,
        page: () => const CreatePasswordPage(),
      ),
      GetPage(
        name: PageRoutes.dashboard,
        page: () => const DashboardPage(),
      ),
      GetPage(
        name: PageRoutes.forgetPassword,
        page: () => const ForgetPasswordPage(),
      ),
      GetPage(
        name: PageRoutes.login,
        page: () => const LoginPage(),
      ),
      GetPage(
        name: PageRoutes.rosters,
        page: () => const RostersPage(),
      ),
      GetPage(
        name: PageRoutes.splash,
        page: () => const SplashPage(),
      ),
    ];
  }
}
