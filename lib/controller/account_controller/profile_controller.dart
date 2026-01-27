import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../data/model/profile_model.dart';
import '../../helper/prefs_helper.dart';
import '../../helper/route_helper.dart' show AppRoutes;
import '../../util/app_constants.dart';
import '../../views/base/custom_snackbar.dart';

class ProfileController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<ProfileModel?> profileModel = Rx<ProfileModel?>(null);
  Rx<File?> pickedImage = Rx<File?>(null);
  final ImagePicker _picker = ImagePicker();

  @override
  void onInit() {
    super.onInit();
    getProfileData();
  }

  Future<void> pickImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      pickedImage.value = File(image.path);
    }
  }

  Future<void> getProfileData() async {
    try {
      isLoading(true);

      String token = await PrefsHelper.getString(AppConstants.bearerToken);

      if (token.isEmpty) {
        return;
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await ApiClient.getData(
        ApiConstant.profile,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        profileModel.value = ProfileModel.fromJson(response.body);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateProfile({
    required String fullName,
    required String shopName,
    required String address,
  }) async {
    try {
      isLoading(true);

      String token = await PrefsHelper.getString(AppConstants.bearerToken);
      if (token.isEmpty) return;

      Map<String, String> body = {
        "full_name": fullName,
        "shop_name": shopName,
        "address": address,
      };

      List<MultipartBody> multipartBody = [];
      if (pickedImage.value != null) {
        multipartBody.add(MultipartBody("profile_picture", pickedImage.value!));
      }

      final response = await ApiClient.putMultipartData(
        ApiConstant.profile,
        body,
        multipartBody: multipartBody,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        profileModel.value = ProfileModel.fromJson(response.body);
        Get.back(); // Close bottom sheet
        showCustomSnackBar("Profile updated successfully", isError: false);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  // Delete user account
  RxBool isDeleting = false.obs;

  Future<bool> deleteAccount() async {
    try {
      isDeleting(true);

      String token = await PrefsHelper.getString(AppConstants.bearerToken);
      if (token.isEmpty) {
        showCustomSnackBar(
          "Authentication error. Please login again.",
          isError: true,
        );
        return false;
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      final response = await ApiClient.deleteData(
        ApiConstant.deleteAccount,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // Clear stored tokens and user data
        await PrefsHelper.remove(AppConstants.bearerToken);
        await PrefsHelper.remove(AppConstants.TOKEN);

        // Show success message from API response
        String message =
            response.body['message'] ?? "Account deleted successfully";
        showCustomSnackBar(message, isError: false);

        // Navigate to login screen
        Get.offAllNamed(AppRoutes.loginScreen);
        return true;
      } else {
        ApiChecker.checkApi(response);
        return false;
      }
    } catch (e) {
      showCustomSnackBar(
        "Failed to delete account. Please try again.",
        isError: true,
      );
      return false;
    } finally {
      isDeleting(false);
    }
  }
}
