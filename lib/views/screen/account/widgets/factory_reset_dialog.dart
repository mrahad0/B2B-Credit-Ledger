import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class FactoryResetDialog extends StatelessWidget {
  const FactoryResetDialog({super.key});

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
                color: const Color(0xFFFEF2F2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.warning_amber_rounded,
                color: const Color(0xFFEF4444),
                size: 32.sp,
              ),
            ),
            SizedBox(height: 20.h),

            // Title
            Text(
              "Wipe All Data?",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
            SizedBox(height: 12.h),

            // Subtitle
            Text(
              "Warning: This will permanently delete\nevery customer and transaction. This\ncannot be undone.",
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
                  // TODO: Implement wiping data logic
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFEF4444), // Red color
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
