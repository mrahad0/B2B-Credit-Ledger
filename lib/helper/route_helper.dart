import 'package:flutter_extension/views/screen/home/home_screen.dart';
import 'package:flutter_extension/views/screen/onboarding/onboarding_screen.dart';
import 'package:flutter_extension/views/screen/auth/login_screen.dart';
import 'package:flutter_extension/views/screen/auth/signup_screen.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/views/screen/main/main_page.dart';

import '../views/screen/splash/splash_screen.dart';

class AppRoutes {
  static String splashScreen = "/splash_screen";
  static String homeScreen = "/home_screen";
  static String onboardingScreen = "/onboarding_screen";
  static String loginScreen = "/login_screen";
  static String signUpScreen = "/signup_screen";
  static String mainPage = "/main_page";

  static List<GetPage> page = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: homeScreen, page: () => const HomeScreen()),
    GetPage(name: onboardingScreen, page: () => const OnboardingScreen()),
    GetPage(name: loginScreen, page: () => const LoginScreen()),
    GetPage(name: signUpScreen, page: () => const SignUpScreen()),
    GetPage(name: mainPage, page: () => MainPage()),
  ];
}
