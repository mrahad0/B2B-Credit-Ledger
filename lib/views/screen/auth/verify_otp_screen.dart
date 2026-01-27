import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller/otp_controller.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/views/base/custom_button.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

/// OTP Verification Screen for Registration
/// After successful verification, navigates to Login Screen
class VerifyOtpScreen extends StatefulWidget {
  const VerifyOtpScreen({super.key});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final OtpController _otpController = Get.put(OtpController());
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _pinFocusNode = FocusNode();

  // Get actual email from arguments
  String get email {
    final args = Get.arguments;
    if (args != null && args['email'] != null) {
      return args['email'];
    }
    return '';
  }

  // Get masked email for display
  String get maskedEmail {
    final args = Get.arguments;
    if (args != null && args['email'] != null) {
      String emailStr = args['email'];
      int atIndex = emailStr.indexOf('@');
      if (atIndex > 2) {
        return '${emailStr.substring(0, 2)}****${emailStr.substring(atIndex)}';
      }
      return emailStr;
    }
    return 'ex****@email.com';
  }

  void _verifyOtp() {
    String otp = _pinController.text;
    if (otp.length == 6 && email.isNotEmpty) {
      _otpController.verifyOtp(
        email: email,
        otp: otp,
      );
    }
  }

  void _resendCode() {
    if (email.isNotEmpty) {
      _otpController.resendOtp(email: email);
    }
  }

  @override
  void dispose() {
    _pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Pinput theme
    final defaultPinTheme = PinTheme(
      width: 50.w,
      height: 56.h,
      textStyle: TextStyle(
        fontSize: 22.sp,
        fontWeight: FontWeight.w600,
        color: const Color(0xFF0F172A),
      ),
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFFE2E8F0), width: 1.5),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFFF8FAFC),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF3B82F6), width: 2),
      ),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: BoxDecoration(
        color: const Color(0xFFF0F9FF),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: const Color(0xFF3B82F6), width: 1.5),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
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
                  "Verify OTP",
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

                // OTP Verification Card
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
                    children: [
                      // Enter code text
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: TextStyle(
                            fontSize: 15.sp,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF64748B),
                          ),
                          children: [
                            const TextSpan(text: 'Enter '),
                            TextSpan(
                              text: 'the',
                              style: TextStyle(
                                color: const Color(0xFF3B82F6),
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const TextSpan(text: ' code sent to your email'),
                          ],
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        maskedEmail,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0F172A),
                        ),
                      ),

                      SizedBox(height: 28.h),

                      // Pinput OTP Input
                      Pinput(
                        controller: _pinController,
                        focusNode: _pinFocusNode,
                        length: 6,
                        defaultPinTheme: defaultPinTheme,
                        focusedPinTheme: focusedPinTheme,
                        submittedPinTheme: submittedPinTheme,
                        showCursor: true,
                        cursor: Container(
                          width: 2,
                          height: 24.h,
                          decoration: BoxDecoration(
                            color: const Color(0xFF3B82F6),
                            borderRadius: BorderRadius.circular(1),
                          ),
                        ),
                        onCompleted: (pin) {
                          // Auto verify when all 6 digits are entered
                          _verifyOtp();
                        },
                      ),

                      SizedBox(height: 20.h),

                      // Resend code
                      TextButton(
                        onPressed: _resendCode,
                        child: Text(
                          'Resend code',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF3B82F6),
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // Verify Button
                      Obx(
                        () => Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.r),
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFF2563EB).withValues(alpha: 0.25),
                                blurRadius: 20,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: CustomButton(
                            loading: _otpController.isLoading.value,
                            onTap: _verifyOtp,
                            text: 'Verify & Enter',
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

                      // Divider
                      Divider(height: 1.h, color: Colors.grey.withValues(alpha: 0.2)),

                      SizedBox(height: 24.h),

                      // Back to login
                      InkWell(
                        onTap: () {
                          Get.offAllNamed(AppRoutes.loginScreen);
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
                              'Back to login',
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
                          ],
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
    );
  }
}
