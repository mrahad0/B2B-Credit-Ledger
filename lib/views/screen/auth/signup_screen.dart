import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_extension/views/base/custom_text_field.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _shopController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void _signup() {
    if (_formKey.currentState!.validate()) {
      // Success logic - After signup navigate wherever appropriate, usually home or login
      Get.offAllNamed(AppRoutes.homeScreen);
    }
  }

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
                  SizedBox(height: 40.h),

                  // Top Logo Area
                  Container(
                    width: 80.w,
                    height: 80.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(22.r),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF0F172A).withOpacity(0.1),
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

                  SizedBox(height: 24.h),

                  Text(
                    "Join BakiLedger",
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

                  SizedBox(height: 32.h),

                  // Signup Card
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
                        // Full Name Field
                        Text(
                          "Full name",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _nameController,
                          hintText: "Enter your name",
                          prefixIcon: const Icon(
                            Icons.person_outline_rounded,
                            size: 22,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your full name";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Shop Name Field
                        Text(
                          "Shop name",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _shopController,
                          hintText: "Business or shop name",
                          prefixIcon: const Icon(
                            Icons.storefront_outlined,
                            size: 22,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your shop name";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Phone Number Field
                        Text(
                          "Phone number",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _phoneController,
                          hintText: "017XXXXXXXX",
                          keyboardType: TextInputType.phone,
                          prefixIcon: const Icon(
                            Icons.tablet_android_rounded,
                            size: 22,
                          ),
                          prefixText: "+88 ",
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your phone number";
                            }
                            if (!value.startsWith("01")) {
                              return "Phone number must start with 01";
                            }
                            if (value.length < 11) {
                              return "Please enter a valid phone number";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Password Field
                        Text(
                          "Password",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "Create password",
                          isPassword: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 22,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please enter your password";
                            }
                            if (value.length < 8) {
                              return "Password must be at least 8 digits";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 20.h),

                        // Confirm Password Field
                        Text(
                          "Confirm password",
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF334155),
                          ),
                        ),
                        SizedBox(height: 10.h),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "Repeat password",
                          isPassword: true,
                          prefixIcon: const Icon(
                            Icons.lock_outline_rounded,
                            size: 22,
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }
                            if (value != _passwordController.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),

                        SizedBox(height: 28.h),

                        // Create Account Button
                        Center(
                          child: Container(
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
                              onTap: _signup,
                              text: "Create account ",
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

                        // Divider or Bottom spacing
                        Container(
                          height: 1.h,
                          color: Colors.grey.withValues(alpha: 0.1),
                        ),

                        SizedBox(height: 24.h),

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
