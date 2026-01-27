import 'dart:convert';
import 'package:get/get.dart';
import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../helper/route_helper.dart';
import '../../views/base/custom_snackbar.dart';

class OtpController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isResending = false.obs;

  Future<void> sendForgotPasswordOtp({required String email}) async {
    try {
      isLoading(true);

      final headers = {"Content-Type": "application/json"};
      final body = {"email": email};

      final response = await ApiClient.postData(
        ApiConstant.forgotPassword,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.body["message"] ?? "OTP sent to your email";
        showCustomSnackBar(message, isError: false);
        Get.toNamed(
          AppRoutes.forgotPasswordOtpScreen,
          arguments: {'email': email},
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyForgotPasswordOtp({required String email, required String otp}) async {
    try {
      isLoading(true);

      final headers = {"Content-Type": "application/json"};
      final body = {"email": email, "otp": otp};

      final response = await ApiClient.postData(
        ApiConstant.resetOtp,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.body["message"] ?? "OTP verified successfully";
        showCustomSnackBar(message, isError: false);
        Get.toNamed(
            AppRoutes.resetPasswordScreen,
            arguments: {'email': email, 'otp': otp}
        );
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> resetPassword({
    required String email,
    required String otp,
    required String newPassword,
    required String confirmPassword,
  }) async {
    try {
      isLoading(true);

      final headers = {"Content-Type": "application/json"};
      final body = {
        "email": email,
        "otp": otp,
        "new_password": newPassword,
        "confirm_password": confirmPassword
      };

      final response = await ApiClient.postData(
        ApiConstant.resetPassword,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        String message = response.body["message"] ?? "Password reset successful";
        showCustomSnackBar(message, isError: false);
        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> verifyOtp({required String email, required String otp}) async {
    try {
      isLoading(true);

      final headers = {"Content-Type": "application/json"};

      final body = {"email": email, "otp": otp};

      final response = await ApiClient.postData(
        ApiConstant.verifyOtp,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success message from API
        String message =
            response.body["message"] ?? "Email verified successfully!";
        showCustomSnackBar(message, isError: false);

        Get.offAllNamed(AppRoutes.loginScreen);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> resendOtp({required String email}) async {
    try {
      isResending(true);

      final headers = {"Content-Type": "application/json"};

      final body = {"email": email};

      final response = await ApiClient.postData(
        ApiConstant.resendOtp,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Show success message from API
        String message = response.body["message"] ?? "OTP code has been resent";
        showCustomSnackBar(message, isError: false);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isResending(false);
    }
  }
}
