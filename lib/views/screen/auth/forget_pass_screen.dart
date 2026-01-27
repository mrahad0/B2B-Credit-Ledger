import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller/otp_controller.dart';

import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ForgetPassScreen extends StatefulWidget {
  const ForgetPassScreen({super.key});

  @override
  State<ForgetPassScreen> createState() => _ForgetPassScreen();
}

class _ForgetPassScreen extends State<ForgetPassScreen> {
  final TextEditingController _emailController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final OtpController _otpController = Get.put(OtpController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 60.h),

                  // Top Logo Area
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
                        Icons.verified_user_rounded,
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
                    "Manage your wholesale business like a pro",
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF94A3B8),
                    ),
                  ),

                  SizedBox(height: 40.h),

                  // Reset Password Card
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
                        // Email Field
                        Text(
                          "Email",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Enter your email",
                          keyboardType: TextInputType.emailAddress,
                          prefixIcon: const Icon(
                            Icons.email_outlined,
                            size: 22,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your email";
                            }
                            if (!GetUtils.isEmail(value)) {
                              return "Please enter a valid email address";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 28.h),

                        // Login Button
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
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  _otpController.sendForgotPasswordOtp(
                                    email: _emailController.text,
                                  );
                                }
                              },

                              text: "Send OTP",
                              icon: Icons.arrow_forward_rounded,
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

                        SizedBox(height: 32.h),

                        Divider(height: 1.h, color: Colors.grey),

                        SizedBox(height: 32.h),

                        // Back to login
                        Center(
                          child: InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.arrow_back_rounded,
                                  size: 18.sp,
                                  color: const Color(0xFF94A3B8),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  "Back to login",
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w700,
                                    color: const Color(0xFF94A3B8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),

                  SizedBox(height: 48.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
