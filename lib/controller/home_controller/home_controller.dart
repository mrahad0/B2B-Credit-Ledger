import 'package:get/get.dart';
import '../../data/api/api_checker.dart';
import '../../data/api/api_client.dart';
import '../../data/api/api_constant.dart';
import '../../data/model/dashboard_model.dart';
import '../../helper/prefs_helper.dart';
import '../../util/app_constants.dart';

class HomeController extends GetxController {
  RxBool isLoading = false.obs;
  Rx<DashboardModel?> dashboardModel = Rx<DashboardModel?>(null);

  @override
  void onInit() {
    super.onInit();
    getDashboardData();
  }

  Future<void> getDashboardData() async {
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
        ApiConstant.dashboard,
        headers: headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        dashboardModel.value = DashboardModel.fromJson(response.body);
      } else {
        ApiChecker.checkApi(response);
      }
    } finally {
      isLoading(false);
    }
  }

  // Getters for easy access to dashboard data
  DashboardData? get dashboardData => dashboardModel.value?.data;

  String get totalOutstanding =>
      dashboardData?.formattedTotalOutstanding ?? "0";
  String get totalDue => dashboardData?.formattedTotalDue ?? "0";
  String get totalPaid => dashboardData?.formattedTotalPaid ?? "0";
  int get totalRetailers => dashboardData?.totalRetailers ?? 0;
  int get activeRetailers => dashboardData?.activeRetailers ?? 0;
  int get retailersWithDue => dashboardData?.retailersWithDue ?? 0;
  int get retailersWithPaid => dashboardData?.retailersWithPaid ?? 0;
}
