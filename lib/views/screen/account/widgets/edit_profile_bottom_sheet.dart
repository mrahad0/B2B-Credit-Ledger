import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import '../../../../controller/account_controller/profile_controller.dart';
import '../../../../views/base/custom_button.dart';
import '../../../base/custom_image.dart';
import 'dart:io';

class EditProfileBottomSheet extends StatefulWidget {
  const EditProfileBottomSheet({super.key});

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  final ProfileController _profileController = Get.find<ProfileController>();
  late TextEditingController _fullNameController;
  late TextEditingController _shopNameController;
  late TextEditingController _locationController;

  @override
  void initState() {
    super.initState();
    final profile = _profileController.profileModel.value?.data?.userProfile;
    _fullNameController = TextEditingController(text: profile?.fullName ?? "");
    _shopNameController = TextEditingController(text: profile?.shopName ?? "");
    _locationController = TextEditingController(text: profile?.address ?? "");
    // Reset picked image on open
    _profileController.pickedImage.value = null;
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
        child: SingleChildScrollView(
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
              SizedBox(height: 24.h),

              // Image Picker
              Center(
                child: Stack(
                  children: [
                    Obx(() {
                      if (_profileController.pickedImage.value != null) {
                        return Container(
                          width: 100.w,
                          height: 100.w,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: FileImage(
                                _profileController.pickedImage.value!,
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      }
                      return Container(
                        width: 100.w,
                        height: 100.w,
                        decoration: const BoxDecoration(
                          color: Color(0xFFF1F5F9),
                          shape: BoxShape.circle,
                        ),
                        child: ClipOval(
                          child: CustomImage(
                            image:
                                _profileController
                                    .profileModel
                                    .value
                                    ?.data
                                    ?.userProfile
                                    ?.profilePicture ??
                                "",
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    }),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: GestureDetector(
                        onTap: () => _profileController.pickImage(),
                        child: Container(
                          padding: EdgeInsets.all(8.w),
                          decoration: BoxDecoration(
                            color: const Color(0xFF2563EB),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 16.sp,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
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

              _buildLabel('Address'),
              CustomTextField(
                controller: _locationController,
                hintText: 'Enter address',
                filColor: const Color(0xFFF8FAFC),
              ),
              SizedBox(height: 32.h),

              // Save Button
              Obx(
                () => CustomButton(
                  loading: _profileController.isLoading.value,
                  onTap: () {
                    _profileController.updateProfile(
                      fullName: _fullNameController.text,
                      shopName: _shopNameController.text,
                      address: _locationController.text,
                    );
                  },
                  text: 'Save Changes',
                  color: const Color(0xFF2563EB),
                  radius: 30.r,
                  height: 56.h,
                  textStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 16.h),
            ],
          ),
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
