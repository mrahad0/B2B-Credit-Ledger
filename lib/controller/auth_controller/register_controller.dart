import 'dart:convert';
import 'package:get/get.dart';
import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../helper/route_helper.dart';
import '../../views/base/custom_snackbar.dart';

class RegisterController extends GetxController {
  RxBool isLoading = false.obs;

  Future<void> register({
    required String fullName,
    required String shopName,
    required String email,
    required String password,
    required String confirmPassword,
  }) async {
    try {
      isLoading(true);

      final headers = {"Content-Type": "application/json"};

      final body = {
        "full_name": fullName,
        "shop_name": shopName,
        "email": email,
        "password": password,
        "confirm_password": confirmPassword,
      };

      final response = await ApiClient.postData(
        ApiConstant.register,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success message from API
        String message = response.body["message"] ?? "Registration successful!";
        showCustomSnackBar(message, isError: false);

        // Navigate to OTP verification screen with email
        Get.toNamed(AppRoutes.verifyOtpScreen, arguments: {'email': email});
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }
}
