import 'package:flutter/material.dart';
import 'package:flutter_extension/helper/route_helper.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_extension/util/app_constants.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingModel> _onboardingData = [
    OnboardingModel(
      title: "Manage 'Baki' Smartly",
      description:
          "Track every single due and payment with professional accuracy and ease.",
      icon: Icons.monetization_on_outlined,
      color: const Color(0xFFE9F3FD),
      iconColor: const Color(0xFF2683EB),
    ),
    OnboardingModel(
      title: "Real-time Reminders",
      description:
          "Send instant WhatsApp reminders to retailers and get paid 2x faster.",
      icon: Icons.phone_iphone_outlined,
      color: const Color(0xFFE8F5E9),
      iconColor: const Color(0xFF4CAF50),
    ),
    OnboardingModel(
      title: "Secure Records",
      description:
          "Your data is stored safely on your device. Manage your business with confidence.",
      icon: Icons.shield_outlined,
      color: const Color(0xFFEDE7F6),
      iconColor: const Color(0xFF673AB7),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _onboardingData.length,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemBuilder: (context, index) {
                  return OnboardingContent(data: _onboardingData[index]);
                },
              ),
            ),

            // Page Indicator
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: EdgeInsets.only(right: 8.w),
                  height: 6,
                  width: _currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppColors.primaryColor
                        : Colors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),

            SizedBox(height: 48.h),

            // Action Button
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
              child: ElevatedButton(
                onPressed: () {
                  if (_currentPage < _onboardingData.length - 1) {
                    _pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                    );
                  } else {
                    Get.find<SharedPreferences>().setBool(
                      AppConstants.ONBOARDING,
                      false,
                    );
                    Get.offAllNamed(AppRoutes.loginScreen);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black, // Dark blue/black from image
                  minimumSize: Size(double.infinity, 56.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _currentPage == _onboardingData.length - 1
                          ? "GET STARTED"
                          : "NEXT",
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 1.2,
                      ),
                    ),
                    SizedBox(width: 8.w),
                    const Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}

class OnboardingContent extends StatelessWidget {
  final OnboardingModel data;
  const OnboardingContent({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 160.w,
            height: 160.w,
            decoration: BoxDecoration(
              color: data.color,
              borderRadius: BorderRadius.circular(40.r),
            ),
            child: Icon(data.icon, size: 80.w, color: data.iconColor),
          ),
          SizedBox(height: 48.h),
          Text(
            data.title,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 26.sp,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF0F172A),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            data.description,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

class OnboardingModel {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final Color iconColor;

  OnboardingModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.iconColor,
  });
}
