import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';

class AddRetailerBottomSheet extends StatefulWidget {
  const AddRetailerBottomSheet({super.key});

  @override
  State<AddRetailerBottomSheet> createState() => _AddRetailerBottomSheetState();
}

class _AddRetailerBottomSheetState extends State<AddRetailerBottomSheet> {
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _shopNameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  bool _isFormValid = false;

  void _validateForm() {
    setState(() {
      _isFormValid =
          _fullNameController.text.isNotEmpty &&
          _shopNameController.text.isNotEmpty &&
          _phoneController.text.isNotEmpty &&
          _addressController.text.isNotEmpty;
    });
  }

  @override
  void initState() {
    super.initState();
    _fullNameController.addListener(_validateForm);
    _shopNameController.addListener(_validateForm);
    _phoneController.addListener(_validateForm);
    _addressController.addListener(_validateForm);
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _shopNameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
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
          children: [
            // Header (Fixed)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'New Retailer',
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      'ADD TO YOUR LEDGER',
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 1,
                      ),
                    ),
                  ],
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

            // Scrollable Content
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 4.h),
                    Divider(
                      color: Colors.grey.withValues(alpha: 0.1),
                      height: 32.h,
                    ),

                    // Photo Uploader
                    Center(
                      child: Stack(
                        children: [
                          Container(
                            width: 110.w,
                            height: 110.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF1F5F9),
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: Colors.white,
                                width: 4.w,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.05),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                            ),
                            child: Icon(
                              Icons.person_outline_rounded,
                              size: 48.sp,
                              color: const Color(0xFF94A3B8),
                            ),
                          ),
                          Positioned(
                            bottom: 4.h,
                            right: 4.w,
                            child: Container(
                              padding: EdgeInsets.all(8.w),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2563EB),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3.w,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF2563EB,
                                    ).withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.camera_alt_rounded,
                                color: Colors.white,
                                size: 18.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Center(
                      child: Text(
                        'RETAILER PHOTO',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF94A3B8),
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),

                    _buildLabel('FULL NAME'),
                    CustomTextField(
                      controller: _fullNameController,
                      hintText: 'e.g. Kabir Ahmed',
                      prefixIcon: const Icon(Icons.person_outline_rounded),
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel('SHOP NAME'),
                    CustomTextField(
                      controller: _shopNameController,
                      hintText: 'e.g. Mayer Doa Enterprise',
                      prefixIcon: const Icon(
                        Icons.store_mall_directory_outlined,
                      ),
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel('PHONE NUMBER'),
                    CustomTextField(
                      controller: _phoneController,
                      hintText: '017xxxxxxxx',
                      keyboardType: TextInputType.phone,
                      prefixIcon: const Icon(Icons.phone_outlined),
                    ),
                    SizedBox(height: 16.h),

                    _buildLabel('ADDRESS'),
                    CustomTextField(
                      controller: _addressController,
                      hintText: 'Shop address...',
                      prefixIcon: const Icon(Icons.location_on_outlined),
                    ),
                    SizedBox(height: 24.h),

                    // Add Button
                    GestureDetector(
                      onTap: _isFormValid
                          ? () {
                              // TODO: Implement add retailer logic
                              Get.back();
                            }
                          : null,
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 16.h),
                        decoration: BoxDecoration(
                          color: _isFormValid
                              ? AppColors.primaryColor
                              : const Color(0xFFF1F5F9),
                          borderRadius: BorderRadius.circular(16.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.check_rounded,
                              color: _isFormValid
                                  ? Colors.white
                                  : const Color(0xFF94A3B8),
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'ADD RETAILER',
                              style: TextStyle(
                                color: _isFormValid
                                    ? Colors.white
                                    : const Color(0xFF94A3B8),
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 24.h),
                  ],
                ),
              ),
            ),
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
          letterSpacing: 1,
        ),
      ),
    );
  }
}
