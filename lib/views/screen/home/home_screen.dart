import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/home_controller/home_controller.dart';
import 'package:flutter_extension/controller/localization_controller.dart';
import 'package:flutter_extension/controller/theme_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_constants.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'widgets/analytics_bottom_sheet.dart';
import 'widgets/add_retailer_bottom_sheet.dart';
import 'widgets/notification_bottom_sheet.dart';
import 'package:flutter_extension/controller/main_page_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final HomeController homeController = Get.put(HomeController());
  bool _showSmartInsight = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 60.w,
        leading: Padding(
          padding: EdgeInsets.only(left: 16.w),
          child: CircleAvatar(
            radius: 20.r,
            backgroundColor: AppColors.secondaryColor,
            child: Icon(Icons.person_outline, color: Colors.white, size: 20.sp),
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "User",
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            Row(
              children: [
                Text(
                  "retailerShop".tr,
                  style: TextStyle(color: Colors.grey, fontSize: 13.sp),
                ),
                SizedBox(width: 4.w),
                Icon(Icons.verified, color: Colors.blue, size: 16.sp),
              ],
            ),
          ],
        ),
        actions: [
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => const AnalyticsBottomSheet(),
              );
            },
            child: Container(
              padding: EdgeInsets.all(8.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.grey.withOpacity(0.2)),
              ),
              child: Icon(
                Icons.pie_chart_outline,
                color: Colors.grey[700],
                size: 24.sp,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          GestureDetector(
            onTap: () {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (context) => const NotificationBottomSheet(),
              );
            },
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(right: 16.w),
                  padding: EdgeInsets.all(8.w),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.withOpacity(0.2)),
                  ),
                  child: Icon(
                    Icons.notifications_outlined,
                    color: Colors.grey[700],
                    size: 24.sp,
                  ),
                ),
                Positioned(
                  right: 20.w,
                  top: 5.h,
                  child: CircleAvatar(radius: 4.r, backgroundColor: Colors.red),
                ),
              ],
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          await homeController.getDashboardData();
          setState(() {
            _showSmartInsight = false;
          });
        },
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20.h),
              // Dashboard Card
              Container(
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.all(24.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.r),
                  gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [AppColors.tertiaryColor, AppColors.secondaryColor],
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 12.w,
                            vertical: 6.h,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B),
                            borderRadius: BorderRadius.circular(20.r),
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.1),
                            ),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: 4.r,
                                backgroundColor: const Color(0xFF3B82F6),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "liveBalance".tr,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Icon(
                          Icons.show_chart_rounded,
                          color: const Color(0xFF64748B),
                          size: 24.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      "totalOutstanding".tr,
                      style: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Obx(
                      () => Row(
                        children: [
                          Text(
                            "৳",
                            style: TextStyle(
                              color: const Color(0xFF94A3B8),
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          SizedBox(width: 4.w),
                          homeController.isLoading.value
                              ? Container(
                                  height: 36.h,
                                  width: 120.w,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withValues(alpha: 0.1),
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                )
                              : Text(
                                  homeController.totalOutstanding,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 36.sp,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1,
                                  ),
                                ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Divider(
                      color: Colors.white.withValues(alpha: 0.1),
                      height: 0.05,
                    ),
                    SizedBox(height: 20.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.all(10.w),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withOpacity(0.1),
                            ),
                          ),
                          child: SvgPicture.asset(
                            "assets/images/Users.svg",
                            colorFilter: ColorFilter.mode(
                              Colors.white,
                              BlendMode.srcIn,
                            ),
                            height: 24.sp,
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Obx(
                          () => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              homeController.isLoading.value
                                  ? Container(
                                      height: 16.h,
                                      width: 30.w,
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.1,
                                        ),
                                        borderRadius: BorderRadius.circular(
                                          4.r,
                                        ),
                                      ),
                                    )
                                  : Text(
                                      "${homeController.totalRetailers}",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                              Text(
                                "retailers".tr,
                                style: TextStyle(
                                  color: const Color(0xFF64748B),
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _showSmartInsight = true;
                            });
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 16.w,
                              vertical: 10.h,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(25.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 10,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.auto_awesome_rounded,
                                  color: Colors.white,
                                  size: 16.sp,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "smartInsight".tr,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              if (_showSmartInsight) ...[
                SizedBox(height: 20.h),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 16.w),
                  padding: EdgeInsets.all(24.w),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.r),
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [Color(0xFF3B82F6), Color(0xFF2563EB)],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2563EB).withValues(alpha: 0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -10,
                        top: -10,
                        child: Icon(
                          Icons.auto_awesome,
                          size: 80,
                          color: Colors.white.withValues(alpha: 0.1),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "aiStrategy".tr,
                            style: TextStyle(
                              color: Colors.white.withValues(alpha: 0.7),
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Text(
                            "aiStrategyDesc".tr,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              height: 1.5,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],

              SizedBox(height: 20.h),

              // Due and Paid Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 30,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFFEF2F2),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.arrow_outward_rounded,
                                    color: const Color(0xFFEF4444),
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "due".tr,
                                      style: TextStyle(
                                        color: const Color(0xFF64748B),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "baki".tr,
                                      style: TextStyle(
                                        color: const Color(0xFFEF4444),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Obx(
                              () => Row(
                                children: [
                                  Text(
                                    "৳",
                                    style: TextStyle(
                                      color: const Color(0xFF94A3B8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  homeController.isLoading.value
                                      ? Container(
                                          height: 18.h,
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              4.r,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          homeController.totalDue,
                                          style: TextStyle(
                                            color: const Color(0xFF0F172A),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(16.w),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(24.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.08),
                              blurRadius: 30,
                            ),
                          ],
                          border: Border.all(
                            color: Colors.grey.withValues(alpha: 0.1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: EdgeInsets.all(8.w),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFECFDF5),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Icon(
                                    Icons.south_west_rounded,
                                    color: const Color(0xFF10B981),
                                    size: 18.sp,
                                  ),
                                ),
                                SizedBox(width: 12.w),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "paid".tr,
                                      style: TextStyle(
                                        color: const Color(0xFF64748B),
                                        fontSize: 13.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "joma".tr,
                                      style: TextStyle(
                                        color: const Color(0xFF10B981),
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16.h),
                            Obx(
                              () => Row(
                                children: [
                                  Text(
                                    "৳",
                                    style: TextStyle(
                                      color: const Color(0xFF94A3B8),
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  homeController.isLoading.value
                                      ? Container(
                                          height: 18.h,
                                          width: 60.w,
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius: BorderRadius.circular(
                                              4.r,
                                            ),
                                          ),
                                        )
                                      : Text(
                                          homeController.totalPaid,
                                          style: TextStyle(
                                            color: const Color(0xFF0F172A),
                                            fontSize: 18.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Quick Actions
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "quickActions".tr,
                      style: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildQuickActionItem(
                          icon: Icons.add_rounded,
                          color: const Color(0xFF3B82F6),
                          label: "addRetailer".tr,
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => Padding(
                                padding: EdgeInsets.only(
                                  bottom: MediaQuery.of(
                                    context,
                                  ).viewInsets.bottom,
                                ),
                                child: const FractionallySizedBox(
                                  heightFactor: 0.9,
                                  child: AddRetailerBottomSheet(),
                                ),
                              ),
                            );
                          },
                        ),
                        _buildQuickActionItem(
                          icon: Icons.send_rounded,
                          color: const Color(0xFF8B5CF6),
                          label: "reminders".tr,
                          onTap: () {
                            Get.find<MainPageController>().changeIndex(1);
                          },
                        ),
                        _buildQuickActionItem(
                          icon: Icons.description_outlined,
                          color: const Color(0xFF10B981),
                          label: "reports".tr,
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // Secure Storage Info
              Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 16.w),
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  border: Border.all(color: Colors.grey, width: 0.1),
                  borderRadius: BorderRadius.circular(40.r),
                ),
                child: Column(
                  children: [
                    Text(
                      "secureLocalStorage".tr,
                      style: TextStyle(
                        color: const Color(0xFF94A3B8),
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      "secureStorageDesc".tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: const Color(0xFF334155),
                        fontSize: 13.sp,
                        height: 1.5,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActionItem({
    required IconData icon,
    required Color color,
    required String label,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 64.w,
            height: 64.w,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 30,
                ),
              ],
              border: Border.all(color: Colors.grey.withOpacity(0.1)),
            ),
            child: Icon(icon, color: color, size: 28.sp),
          ),
          SizedBox(height: 12.h),
          Text(
            label,
            style: TextStyle(
              color: const Color(0xFF0F172A),
              fontSize: 13.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
