import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../controller/retailer_controller/retailer_controller.dart';
import '../../../data/model/retailer_model.dart';
import 'retailer_details_screen.dart';
import '../home/widgets/add_retailer_bottom_sheet.dart';

class RetailersScreen extends StatelessWidget {
  const RetailersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RetailerController retailerController = Get.put(RetailerController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: RefreshIndicator(
          color: AppColors.primaryColor,
          onRefresh: () async {
            await retailerController.getRetailers();
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header Section
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "title".tr,
                          style: TextStyle(
                            fontSize: 28.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF0F172A),
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Obx(
                          () => Row(
                            children: [
                              Container(
                                width: 6.w,
                                height: 6.w,
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "${retailerController.retailers.where((r) => r.isActive == true).length} ${"activeAccounts".tr}",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF94A3B8),
                                  letterSpacing: 1,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const FractionallySizedBox(
                              heightFactor: 0.9,
                              child: AddRetailerBottomSheet(),
                            ),
                          ),
                        );
                      },
                      child: Container(
                        width: 48.w,
                        height: 48.w,
                        decoration: BoxDecoration(
                          color: AppColors.secondaryColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.secondaryColor.withValues(alpha: 0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.person_add_alt_outlined,
                          color: Colors.white,
                          size: 24.sp,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 32.h),

                // Search and Filter Section
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 16.w),
                        height: 52.h,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16.r),
                          border: Border.all(color: const Color(0xFFE2E8F0)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.02),
                              blurRadius: 10,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Obx(
                              () => retailerController.isSearching.value
                                  ? SizedBox(
                                      width: 24.sp,
                                      height: 24.sp,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: const Color(0xFF94A3B8),
                                      ),
                                    )
                                  : Icon(
                                      Icons.search,
                                      color: const Color(0xFF94A3B8),
                                      size: 24.sp,
                                    ),
                            ),
                            SizedBox(width: 12.w),
                            Expanded(
                              child: TextField(
                                controller: retailerController.searchController,
                                onChanged: retailerController.onSearchChanged,
                                style: TextStyle(
                                  color: const Color(0xFF0F172A),
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                                decoration: InputDecoration(
                                  hintText: "searchPlaceholder".tr,
                                  hintStyle: TextStyle(
                                    fontStyle: FontStyle.normal,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xFF94A3B8),
                                    fontSize: 14.sp,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            Obx(
                              () => retailerController.searchQuery.value.isNotEmpty
                                  ? GestureDetector(
                                      onTap: retailerController.clearSearch,
                                      child: Container(
                                        padding: EdgeInsets.all(4.w),
                                        decoration: BoxDecoration(
                                          color: const Color(0xFFF1F5F9),
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.close,
                                          color: const Color(0xFF64748B),
                                          size: 16.sp,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink(),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 52.h,
                      height: 52.h,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16.r),
                        border: Border.all(color: const Color(0xFFE2E8F0)),
                      ),
                      child: Icon(
                        fontWeight: FontWeight.bold,
                        Icons.swap_vert_rounded,
                        color: const Color(0xFF64748B),
                        size: 24.sp,
                      ),
                    ),
                  ],
                ),


                SizedBox(height: 24.h),

                // Retailer List
                Obx(() {
                  if (retailerController.isLoading.value) {
                    // Loading Skeleton
                    return Column(
                      children: List.generate(
                        3,
                        (index) => Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: _buildSkeletonCard(),
                        ),
                      ),
                    );
                  }

                  if (retailerController.retailers.isEmpty) {
                    // Empty State
                    return Center(
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 60.h),
                        child: Column(
                          children: [
                            Container(
                              width: 80.w,
                              height: 80.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F5F9),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                Icons.people_outline_rounded,
                                size: 40.sp,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "noRetailers".tr,
                              style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF64748B),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Text(
                              "addFirstRetailer".tr,
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  // Retailer List
                  return Column(
                    children: retailerController.retailers
                        .map(
                          (retailer) => Padding(
                            padding: EdgeInsets.only(bottom: 16.h),
                            child: _buildRetailerCard(retailer: retailer),
                          ),
                        )
                        .toList(),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSkeletonCard() {
    return Container(
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Row(
        children: [
          Container(
            width: 56.w,
            height: 56.w,
            decoration: BoxDecoration(
              color: const Color(0xFFF1F5F9),
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 16.h,
                  width: 120.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 14.h,
                  width: 160.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
                SizedBox(height: 6.h),
                Container(
                  height: 12.h,
                  width: 100.w,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1F5F9),
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                height: 18.h,
                width: 60.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              SizedBox(height: 8.h),
              Container(
                height: 24.h,
                width: 40.w,
                decoration: BoxDecoration(
                  color: const Color(0xFFF1F5F9),
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRetailerCard({required RetailerData retailer}) {
    // Determine color based on balance status
    Color balanceColor;
    Color badgeColor;
    Color badgeBgColor;
    Color badgeBorderColor;
    String badgeText;

    if (retailer.isDue) {
      balanceColor = const Color(0xFFEF4444); // Red
      badgeColor = const Color(0xFFEF4444);
      badgeBgColor = const Color(0xFFFEF2F2);
      badgeBorderColor = const Color(0xFFFECACA);
      badgeText = "due".tr.toUpperCase();
    } else if (retailer.isPaid) {
      balanceColor = const Color(0xFF10B981); // Green
      badgeColor = const Color(0xFF10B981);
      badgeBgColor = const Color(0xFFECFDF5);
      badgeBorderColor = const Color(0xFFA7F3D0);
      badgeText = "paid".tr.toUpperCase();
    } else {
      balanceColor = const Color(0xFF64748B); // Gray for clear
      badgeColor = const Color(0xFF64748B);
      badgeBgColor = const Color(0xFFF1F5F9);
      badgeBorderColor = const Color(0xFFE2E8F0);
      badgeText = "clear".tr.toUpperCase();
    }

    return GestureDetector(
      onTap: () {
        // Fetch retailer details and navigate
        final controller = Get.find<RetailerController>();
        controller.getRetailerDetails(retailer.id!);
        Get.to(() => RetailerDetailsScreen(retailerId: retailer.id!));
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
          border: Border.all(color: const Color(0xFFF1F5F9)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28.r,
              backgroundColor: const Color(0xFFF1F5F9),
              child: Text(
                retailer.initial,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    retailer.fullName ?? "Unknown",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 6.h),
                  Row(
                    children: [
                      Icon(
                        Icons.storefront_outlined,
                        size: 14.sp,
                        color: const Color(0xFF64748B),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          retailer.shopName ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        size: 14.sp,
                        color: const Color(0xFF94A3B8),
                      ),
                      SizedBox(width: 4.w),
                      Expanded(
                        child: Text(
                          retailer.address ?? "",
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  "৳ ${retailer.formattedBalance}",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: balanceColor,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: badgeBgColor,
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: badgeBorderColor),
                  ),
                  child: Text(
                    badgeText,
                    style: TextStyle(
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                      color: badgeColor,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
