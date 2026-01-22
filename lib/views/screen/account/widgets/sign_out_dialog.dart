import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/helper/route_helper.dart';

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(30.r),
      ),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                color: const Color(0xFFEFF6FF),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.logout_rounded,
                color: const Color(0xFF2563EB),
                size: 28.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              "Sign Out?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 12.h),

            // Subtitle
            Text(
              "You will need to log back in to access\nyour business ledger records.",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xFF64748B),
                height: 1.5,
                fontWeight: FontWeight.w500,
              ),
            ),
            SizedBox(height: 32.h),

            // Confirm Button
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: () {
                  Get.offAllNamed(AppRoutes.loginScreen);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF0F172A),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Confirm',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Cancel Button
            GestureDetector(
              onTap: () => Get.back(),
              child: Text(
                'Cancel',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: const Color(0xFF94A3B8),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
