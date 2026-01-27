import 'package:flutter/material.dart';
import 'package:flutter_extension/controller/auth_controller/splash_controller.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _bouncingController;
  late Animation<double> _bouncingAnimation;

  late AnimationController _dotsController;
  int _activeDotIndex = 0;

  @override
  void initState() {
    super.initState();

    // Bouncing animation for logo
    _bouncingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);

    _bouncingAnimation = Tween<double>(begin: 0, end: -20).animate(
      CurvedAnimation(parent: _bouncingController, curve: Curves.easeInOut),
    );

    // Dots loading animation
    _dotsController =
        AnimationController(
            vsync: this,
            duration: const Duration(milliseconds: 1000),
          )
          ..addListener(() {
            int newIndex = (_dotsController.value * 3).floor();
            if (newIndex != _activeDotIndex) {
              setState(() {
                _activeDotIndex = newIndex % 3;
              });
            }
          })
          ..repeat();

    Future.delayed(const Duration(seconds: 4), () {
      Get.find<SplashController>().jumpNextScreen();
    });
  }

  @override
  void dispose() {
    _bouncingController.dispose();
    _dotsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Logo Area
                  SizedBox(
                    width: 140.w,
                    height: 140.w,
                    child: Stack(
                      alignment: Alignment.center,
                      clipBehavior: Clip.none,
                      children: [
                        // Bouncing Main Blue Shield
                        AnimatedBuilder(
                          animation: _bouncingAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0, _bouncingAnimation.value),
                              child: child,
                            );
                          },
                          child: Container(
                            width: 100.w,
                            height: 100.w,
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor,
                              borderRadius: BorderRadius.circular(25.r),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryColor.withOpacity(
                                    0.3,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 5,
                                  offset: const Offset(0, 10),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Icon(
                                Icons.verified_user_outlined,
                                color: Colors.white,
                                size: 60.w,
                              ),
                            ),
                          ),
                        ),
                        // Top Right Green Dot
                        Positioned(
                          top: 20.h,
                          right: 15.w,
                          child: Container(
                            width: 25.w,
                            height: 25.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFF4CAF50),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                        // Bottom Left Yellow Dot
                        Positioned(
                          bottom: 30.h,
                          left: 10.w,
                          child: Container(
                            width: 25.w,
                            height: 25.w,
                            decoration: BoxDecoration(
                              color: const Color(0xFFFFC107),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 3),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10.h),
                  // App Name
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Baki',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        'Ledger',
                        style: TextStyle(
                          fontSize: 32.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  // Professional subtitle
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 20.w,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text(
                          'P R O F E S S I O N A L',
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[500],
                          ),
                        ),
                      ),
                      Container(
                        width: 20.w,
                        height: 1,
                        color: Colors.grey[300],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            // Bottom Loading indicator
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: EdgeInsets.only(bottom: 50.h),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(3, (index) {
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 4.w),
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: 10.w,
                            height: 10.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _activeDotIndex == index
                                  ? AppColors.primaryColor
                                  : AppColors.primaryColor.withOpacity(0.3),
                            ),
                          ),
                        );
                      }),
                    ),
                    SizedBox(height: 15.h),
                    Text(
                      'STARTING SECURE SESSION',
                      style: TextStyle(
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                        color: Colors.grey[400],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
