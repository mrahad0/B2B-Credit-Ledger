import 'dart:convert';

import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../helper/prefs_helper.dart';
import '../../helper/route_helper.dart';
import '../../util/app_constants.dart';

class LoginController extends GetxController {
  RxBool isRememberMe = false.obs;
  RxBool isLoading = false.obs;

  void onRememberMeChanged(bool value) => isRememberMe(value);

  login(String email, String password) async {
    isLoading(true);

    var headers = {'Content-Type': 'application/json'};

    var response = await ApiClient.postData(
      ApiConstant.login,
      jsonEncode({"email": email, "password": password}),
      headers: headers,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      await PrefsHelper.setString(
        AppConstants.bearerToken,
        response.body["access_token"],
      );
      Get.offAllNamed(AppRoutes.mainPage);
    } else {
      ApiChecker.checkApi(response);
    }

    isLoading(false);
  }
}
