import 'package:flutter/material.dart';

import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_extension/controller/auth_controller/otp_controller.dart';
import 'package:get/get.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final OtpController _otpController = Get.put(OtpController());

  String get email => Get.arguments['email'] ?? '';
  String get otp => Get.arguments['otp'] ?? '';

  void _resetPassword() {
    if (_formKey.currentState!.validate()) {
      _otpController.resetPassword(
        email: email,
        otp: otp,
        newPassword: _newPasswordController.text,
        confirmPassword: _confirmPasswordController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Colors.black,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20.h),

                  // Top Icon
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withValues(alpha: 0.1),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.lock_reset_rounded,
                        color: const Color(0xFF3B82F6),
                        size: 42.w,
                      ),
                    ),
                  ),

                  SizedBox(height: 32.h),

                  Text(
                    "Reset Password",
                    style: TextStyle(
                      fontSize: 28.sp,
                      fontWeight: FontWeight.w800,
                      color: const Color(0xFF0F172A),
                      letterSpacing: -0.5,
                    ),
                  ),

                  SizedBox(height: 8.h),

                  Text(
                    "Enter your new password and confirm it to reset your account access.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Form Card
                  Container(
                    padding: EdgeInsets.all(24.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(32.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withValues(alpha: 0.25),
                          blurRadius: 30,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // New Password Field
                        Text(
                          "New Password",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          controller: _newPasswordController,
                          hintText: "Enter new password",
                          isPassword: true,
                          prefixIcon: const Icon(Icons.lock_outline, size: 22),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your new password";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 digits";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 24.h),

                        // Confirm Password Field
                        Text(
                          "Confirm Password",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "Confirm new password",
                          isPassword: true,
                          prefixIcon: const Icon(Icons.lock_outline, size: 22),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != _newPasswordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 32.h),

                        // Submit Button
                        Obx(
                          () => Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.r),
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(
                                    0xFF2563EB,
                                  ).withValues(alpha: 0.25),
                                  blurRadius: 20,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: CustomButton(
                              loading: _otpController.isLoading.value,
                              onTap: _resetPassword,
                              text: "Reset Password",
                              color: AppColors.primaryColor,
                              radius: 30.r,
                              height: 56.h,
                              textStyle: TextStyle(
                                fontSize: 17.sp,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
