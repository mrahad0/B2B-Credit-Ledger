import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../data/model/retailer_model.dart';
import '../../helper/prefs_helper.dart';
import '../../util/app_constants.dart';
import '../../views/base/custom_snackbar.dart';
import '../home_controller/home_controller.dart';

class RetailerController extends GetxController {
  RxBool isLoading = false.obs;
  RxBool isSearching = false.obs;
  RxBool isAddingRetailer = false.obs;
  RxList<RetailerData> retailers = <RetailerData>[].obs;
  RxString searchQuery = ''.obs;
  
  // Search controller and debounce timer
  final TextEditingController searchController = TextEditingController();
  Timer? _debounceTimer;

  @override
  void onInit() {
    super.onInit();
    getRetailers();
  }

  @override
  void onClose() {
    searchController.dispose();
    _debounceTimer?.cancel();
    super.onClose();
  }

  // Search with debounce to avoid too many API calls
  void onSearchChanged(String query) {
    searchQuery.value = query;
    
    // Cancel previous timer
    _debounceTimer?.cancel();
    
    // Start new timer - wait 500ms before making API call
    _debounceTimer = Timer(const Duration(milliseconds: 500), () {
      if (query.isEmpty) {
        getRetailers();
      } else {
        searchRetailers(query);
      }
    });
  }

  // Clear search
  void clearSearch() {
    searchController.clear();
    searchQuery.value = '';
    _debounceTimer?.cancel();
    getRetailers();
  }

  // Get all retailers (with optional search)
  Future<void> getRetailers() async {
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
        ApiConstant.createLedger,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        RetailerListModel retailerListModel = RetailerListModel.fromJson(
          response.body,
        );
        retailers.value = retailerListModel.data ?? [];
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  // Search retailers by name
  Future<void> searchRetailers(String name) async {
    try {
      isSearching(true);

      String token = await PrefsHelper.getString(AppConstants.bearerToken);

      if (token.isEmpty) {
        return;
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      // Add search query parameter
      final String endpoint = "${ApiConstant.createLedger}?search=$name";

      final response = await ApiClient.getData(
        endpoint,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        RetailerListModel retailerListModel = RetailerListModel.fromJson(
          response.body,
        );
        retailers.value = retailerListModel.data ?? [];
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isSearching(false);
    }
  }

  // Selected retailer for details screen
  Rx<RetailerData?> selectedRetailer = Rx<RetailerData?>(null);
  RxBool isLoadingDetails = false.obs;

  // Get retailer details by ID
  Future<void> getRetailerDetails(int retailerId) async {
    try {
      isLoadingDetails(true);
      selectedRetailer.value = null;

      String token = await PrefsHelper.getString(AppConstants.bearerToken);

      if (token.isEmpty) {
        return;
      }

      final headers = {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      };

      // Endpoint with retailer ID
      final String endpoint = "${ApiConstant.createLedger}$retailerId/";

      final response = await ApiClient.getData(
        endpoint,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        RetailerModel retailerModel = RetailerModel.fromJson(response.body);
        selectedRetailer.value = retailerModel.data;
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoadingDetails(false);
    }
  }


  // Add a new retailer
  Future<bool> addRetailer({
    required String fullName,
    required String shopName,
    required String phoneNumber,
    required String address,
  }) async {
    try {
      isAddingRetailer(true);

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

      final body = {
        "full_name": fullName,
        "shop_name": shopName,
        "phone_number": phoneNumber,
        "address": address,
      };

      final response = await ApiClient.postData(
        ApiConstant.createLedger,
        jsonEncode(body),
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        RetailerModel retailerModel = RetailerModel.fromJson(response.body);

        // Add the new retailer to the list
        if (retailerModel.data != null) {
          retailers.insert(0, retailerModel.data!);
        }

        // Refresh dashboard data
        if (Get.isRegistered<HomeController>()) {
          Get.find<HomeController>().getDashboardData();
        }

        // Show success message
        String message = retailerModel.message ?? "Retailer added successfully";
        showCustomSnackBar(message, isError: false);

        // Close the bottom sheet
        Get.back();

        return true;
      } else {
        ApiChecker.checkApi(response);
        return false;
      }
    } catch (e) {
      showCustomSnackBar(
        "Failed to add retailer. Please try again.",
        isError: true,
      );
      return false;
    } finally {
      isAddingRetailer(false);
    }
  }

  void clearForm() {}
}
