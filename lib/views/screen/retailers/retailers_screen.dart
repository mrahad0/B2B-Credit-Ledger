import 'package:flutter/material.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'retailer_details_screen.dart';
import '../home/widgets/add_retailer_bottom_sheet.dart';

class RetailersScreen extends StatelessWidget {
  const RetailersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
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
                        "Retailers",
                        style: TextStyle(
                          fontSize: 28.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Row(
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
                            "2 ACCOUNTS ACTIVE",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                              color: const Color(0xFF94A3B8),
                              letterSpacing: 1,
                            ),
                          ),
                        ],
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
                            color: AppColors.secondaryColor.withOpacity(0.3),
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
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.search,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF94A3B8),
                            size: 24.sp,
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: TextField(
                              decoration: InputDecoration(
                                hintText: "Search by name or shop name",
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
              _buildRetailerCard(
                initial: "K",
                name: "Kabir Ahmed",
                shopName: "Mayer Doa Store",
                location: "Karwan Bazar",
                amount: "45,000",
                isDue: true,
              ),
              SizedBox(height: 16.h),
              _buildRetailerCard(
                initial: "S",
                name: "Sujon Mia",
                shopName: "Sujon General store",
                location: "Mohakhali",
                amount: "12,000",
                isDue: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRetailerCard({
    required String initial,
    required String name,
    required String shopName,
    required String location,
    required String amount,
    required bool isDue,
  }) {
    return GestureDetector(
      onTap: () {
        Get.to(() => const RetailerDetailsScreen());
      },
      child: Container(
        padding: EdgeInsets.all(20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
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
                initial,
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
                    name,
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
                          shopName,
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
                      Text(
                        location,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: const Color(0xFF94A3B8),
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
                  "৳ $amount",
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFFEF4444), // Red for Due
                  ),
                ),
                SizedBox(height: 8.h),
                if (isDue)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFEF2F2),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: const Color(0xFFFECACA)),
                    ),
                    child: Text(
                      "DUE",
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFEF4444),
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
