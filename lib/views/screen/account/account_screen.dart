import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/edit_profile_bottom_sheet.dart';
import 'widgets/info_dialog.dart';
import 'widgets/sign_out_dialog.dart';
import 'widgets/factory_reset_dialog.dart';
import 'widgets/language_dialog.dart';
import 'package:get/get.dart';
import '../../../controller/account_controller/profile_controller.dart';
import '../../../data/api/api_constant.dart';
import '../../base/custom_image.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({super.key});

  final ProfileController _profileController = Get.put(ProfileController());

  // Update build method to include onTap handlers
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.w),
          child: Column(
            children: [
              // Profile Card
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 32.h, horizontal: 24.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 20,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Avatar Section
                    Stack(
                      children: [
                        Container(
                          width: 110.w,
                          height: 110.w,
                          decoration: BoxDecoration(
                            color: const Color(0xFFF1F5F9),
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 4.w),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 15,
                                offset: const Offset(0, 5),
                              ),
                            ],
                          ),
                          child: Obx(
                            () => ClipOval(
                              child: CustomImage(
                                image:
                                    "${ApiConstant.baseUrl}${_profileController.profileModel.value?.data?.userProfile?.profilePicture ?? ""}",
                                height: 110.w,
                                width: 110.w,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Name
                    Obx(() {
                      if (_profileController.isLoading.value) {
                        return Container(
                          height: 24.h,
                          width: 100.w,
                          color: Colors.grey[200],
                        );
                      }
                      return Text(
                        _profileController
                                .profileModel
                                .value
                                ?.data
                                ?.userProfile
                                ?.fullName ??
                            _profileController
                                .profileModel
                                .value
                                ?.data
                                ?.userProfile
                                ?.shopName ??
                            "User",
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      );
                    }),
                    SizedBox(height: 8.h),

                    // Shop Type & Verification
                    Obx(() {
                      if (_profileController.isLoading.value) {
                        return const SizedBox();
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _profileController.profileModel.value?.data?.role
                                    ?.toUpperCase() ??
                                "RETAILER",
                            style: TextStyle(
                              fontSize: 13.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFF2563EB),
                              letterSpacing: 0.5,
                            ),
                          ),
                          SizedBox(width: 6.w),
                          if (_profileController
                                  .profileModel
                                  .value
                                  ?.data
                                  ?.isVerified ==
                              true)
                            Icon(
                              Icons.verified,
                              color: const Color(0xFF2563EB),
                              size: 18.sp,
                            ),
                        ],
                      );
                    }),
                    SizedBox(height: 8.h),

                    // Location (Email for now as address is null in example)
                    Obx(() {
                      if (_profileController.isLoading.value) {
                        return SizedBox();
                      }
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.email_outlined,
                            size: 16.sp,
                            color: const Color(0xFF94A3B8),
                          ),
                          SizedBox(width: 4.w),
                          Text(
                            _profileController
                                    .profileModel
                                    .value
                                    ?.data
                                    ?.email ??
                                _profileController
                                    .profileModel
                                    .value
                                    ?.data
                                    ?.userProfile
                                    ?.email ??
                                "No Email",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xFF64748B),
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }),
                    SizedBox(height: 24.h),

                    // Edit Profile Button
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Padding(
                            padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom,
                            ),
                            child: const EditProfileBottomSheet(),
                          ),
                        );
                      },
                      child: Container(
                        width: 160.w,
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF8FAFC),
                          borderRadius: BorderRadius.circular(30.r),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.person_outline_rounded,
                              size: 18.sp,
                              color: const Color(0xFF0F172A),
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              "Edit Profile",
                              style: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 24.h),

              // General Preferences
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
                    child: Text(
                      "preferences".tr.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildPreferenceItem(
                          icon: Icons.language,
                          iconColor: const Color(0xFF10B981),
                          iconBgColor: const Color(0xFFECFDF5),
                          title: "language".tr,
                          subtitle: "English",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => const LanguageDialog(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Support & Legal
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, bottom: 12.h),
                    child: Text(
                      "support".tr.toUpperCase(),
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF94A3B8),
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 20,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        _buildPreferenceItem(
                          icon: Icons.privacy_tip_outlined,
                          iconColor: const Color(0xFF3B82F6),
                          iconBgColor: const Color(0xFFEFF6FF),
                          title: "privacy".tr,
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => InfoDialog(
                                title: "privacyTitle".tr,
                                content: "privacyPolicyContent".tr,
                              ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.help_outline_rounded,
                          iconColor: const Color(0xFFF59E0B),
                          iconBgColor: const Color(0xFFFFFBEB),
                          title: "help".tr,
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => InfoDialog(
                                title: "help".tr,
                                content: "helpContent".tr,
                              ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.description_outlined,
                          iconColor: const Color(0xFF64748B),
                          iconBgColor: const Color(0xFFF1F5F9),
                          title: "terms".tr,
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => InfoDialog(
                                title: "terms".tr,
                                content: "termsContent".tr,
                              ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: const Color(0xFF64748B),
                          iconBgColor: const Color(0xFFF1F5F9),
                          title: "about".tr,
                          subtitle: "v1.0.4 Professional",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => InfoDialog(
                                title: "about".tr,
                                content: "aboutContent".tr,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),

              SizedBox(height: 24.h),

              // Action Buttons
              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const SignOutDialog(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30.r),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.logout_rounded,
                        color: const Color(0xFF0F172A),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "signOut".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFF0F172A),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 16.h),

              GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => const FactoryResetDialog(),
                  );
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF2F2),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.delete_outline_outlined,
                        color: const Color(0xFFEF4444),
                        size: 20.sp,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        "deleteAll".tr,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xFFEF4444),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 40.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPreferenceItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    String? subtitle,
    required Widget trailing,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10.w),
              decoration: BoxDecoration(
                color: iconBgColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: iconColor, size: 20.sp),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF0F172A),
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 2.h),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: const Color(0xFF64748B),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            trailing,
          ],
        ),
      ),
    );
  }
}
