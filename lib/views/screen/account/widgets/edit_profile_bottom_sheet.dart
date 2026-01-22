import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late TextEditingController _fullNameController;
  late TextEditingController _shopNameController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    _fullNameController = TextEditingController(text: "MD Ahad");
    _shopNameController = TextEditingController(text: "Retailer Shop");
    _locationController = TextEditingController(text: "Dhaka, Bangladesh");
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _shopNameController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30.r)),
        ),
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle Bar
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            SizedBox(height: 24.h),

            // Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Profile Settings',
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
            SizedBox(height: 32.h),

            // Fields
            _buildLabel('Full Name'),
            CustomTextField(
              controller: _fullNameController,
              hintText: 'Enter full name',
              filColor: const Color(0xFFF8FAFC),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Shop Name'),
            CustomTextField(
              controller: _shopNameController,
              hintText: 'Enter shop name',
              filColor: const Color(0xFFF8FAFC),
            ),
            SizedBox(height: 16.h),

            _buildLabel('Location'),
            CustomTextField(
              controller: _locationController,
              hintText: 'Enter location',
              filColor: const Color(0xFFF8FAFC),
            ),
            SizedBox(height: 32.h),

            // Save Button
            SizedBox(
              width: double.infinity,
              height: 56.h,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Implement save logic
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2563EB),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Save Changes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 8.h, left: 4.w),
      child: Text(
        label,
        style: TextStyle(
          color: const Color(0xFF94A3B8),
          fontSize: 12.sp,
          fontWeight: FontWeight.bold,
          // letterSpacing: 0.5,
        ),
      ),
    );
  }
}
