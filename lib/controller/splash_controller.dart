import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashController extends GetxController {
  final SharedPreferences sharedPreferences;
  SplashController({required this.sharedPreferences});

  jumpNextScreen() {
    bool showOnboarding = sharedPreferences.getBool(AppConstants.ONBOARDING) ?? true;

    if (showOnboarding) {
      Get.offNamed(AppRoutes.onboardingScreen);
    } else {
      Get.offNamed(AppRoutes.loginScreen);
    }
  }
}
