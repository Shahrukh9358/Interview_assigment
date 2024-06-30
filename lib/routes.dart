import 'package:assignment_project/onbaording.dart';
import 'package:assignment_project/screens/auth/ask_user_details.dart';
import 'package:assignment_project/screens/auth/index.dart';
import 'package:assignment_project/screens/auth/verify_otp.dart';
import 'package:assignment_project/screens/dashboard/index.dart';
import 'package:assignment_project/screens/dashboard/video_call/agora_ui_kit.dart';
import 'package:assignment_project/screens/login_with_email/email.dart';
import 'package:assignment_project/screens/login_with_email/forgot_password.dart';
import 'package:assignment_project/splash.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';

final getRoutes = [
  GetPage(
      name: '/',
      page: () => const SplashScreen(),
      transition: Transition.cupertino
  ),
  GetPage(
      name: '/onboarding',
      page: () => const Onboarding(),
      transition: Transition.cupertino
  ),
  GetPage(
      name: '/authentication',
      page: () => const AuthenticationScreen(),
      transition: Transition.cupertino
  ),
  GetPage(
      name: '/loginEmail',
      page: () => const EmailPasswordScreen(),
      transition: Transition.cupertino
  ),
  GetPage(
      name: '/forgetpassword',
      page: () => const ForgotPassword(),
      transition: Transition.cupertino
  ),
  GetPage(
      name: '/verify_otp',
      page: () => const VerifyOtpScreen(),
      transition: Transition.cupertino
  ),

  GetPage(
      name: '/ask_user_details',
      page: () => const AskUserDetails(),
      transition: Transition.cupertino
  ),

  GetPage(
      name: '/agora_ui_kit_screen',
      page: () => const AgoraUIKit(),
      transition: Transition.cupertino
  ),

  GetPage(
      name: '/dashboard',
      page: () => const Dashboard(),
      transition: Transition.cupertino
  ),
];