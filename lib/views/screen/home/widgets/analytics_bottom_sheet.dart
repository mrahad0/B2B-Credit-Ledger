import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class AnalyticsBottomSheet extends StatelessWidget {
  const AnalyticsBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.fromLTRB(24.w, 24.h, 24.w, 40.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Analytics',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF0F172A),
                  ),
                ),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: Container(
                    padding: EdgeInsets.all(8.w),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.close,
                      color: const Color(0xFF64748B),
                      size: 20.sp,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Business Summary Card
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF), // Light blue background
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(color: const Color(0xFFBFDBFE), width: 0.5),
              ),
              child: Column(
                children: [
                  // Icon
                  Icon(
                    Icons.pie_chart_outline_rounded,
                    size: 48.sp,
                    color: const Color(0xFF2563EB),
                  ),
                  SizedBox(height: 16.h),

                  // Title
                  Text(
                    "Business Summary",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  SizedBox(height: 8.h),

                  // Subtitle
                  Text(
                    "Detailed monthly reports are generated based on your\nlocal ledger data.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: const Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),
                  SizedBox(height: 24.h),

                  // Export Button
                  SizedBox(
                    width: double.infinity,
                    height: 48.h,
                    child: ElevatedButton(
                      onPressed: () {
                        // TODO: Implement export functionality
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF2563EB),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.download_rounded,
                            color: Colors.white,
                            size: 20.sp,
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            'Export PDF Report',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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

            // Stats Row
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    title: "Total Outstanding",
                    value: "৳57,000",
                    valueColor: const Color(0xFFEF4444),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildStatCard(
                    title: "New Retailers",
                    value: "+2",
                    valueColor: const Color(0xFF2563EB),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required Color valueColor,
  }) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: const Color(0xFFF1F5F9)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF94A3B8),
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            value,
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}
