import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'widgets/edit_profile_bottom_sheet.dart';
import 'widgets/info_dialog.dart';
import 'widgets/sign_out_dialog.dart';
import 'widgets/factory_reset_dialog.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

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
                          child: Center(
                            child: Text(
                              "U",
                              style: TextStyle(
                                fontSize: 44.sp,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFF94A3B8),
                              ),
                            ),
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
                    SizedBox(height: 16.h),

                    // Name
                    Text(
                      "User",
                      style: TextStyle(
                        fontSize: 22.sp,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF0F172A),
                      ),
                    ),
                    SizedBox(height: 8.h),

                    // Shop Type & Verification
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "RETAILER SHOP",
                          style: TextStyle(
                            fontSize: 13.sp,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF2563EB),
                            letterSpacing: 0.5,
                          ),
                        ),
                        SizedBox(width: 6.w),
                        Icon(
                          Icons.verified,
                          color: const Color(0xFF2563EB),
                          size: 18.sp,
                        ),
                      ],
                    ),
                    SizedBox(height: 8.h),

                    // Location
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: const Color(0xFF94A3B8),
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          "Dhaka, Bangladesh",
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: const Color(0xFF64748B),
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
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
                      "GENERAL PREFERENCES",
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
                          title: "App Language",
                          subtitle: "English",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.wb_sunny_outlined,
                          iconColor: const Color(0xFF3B82F6),
                          iconBgColor: const Color(0xFFEFF6FF),
                          title: "App Appearance",
                          subtitle: "light",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {},
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.notifications_none_rounded,
                          iconColor: const Color(0xFFF97316),
                          iconBgColor: const Color(0xFFFFF7ED),
                          title: "Push Notifications",
                          trailing: Transform.scale(
                            scale: 0.8,
                            child: Switch(
                              value: true,
                              onChanged: (val) {},
                              activeColor: Colors.white,
                              activeTrackColor: const Color(0xFF2563EB),
                            ),
                          ),
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
                      "SUPPORT & LEGAL",
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
                          color: Colors.black.withOpacity(0.05),
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
                          title: "Privacy Policy",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => const InfoDialog(
                                    title: "Privacy Policy",
                                    content:
                                        "Your data is stored locally on this device. We do not share your customer credit records with any third party.",
                                  ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.help_outline_rounded,
                          iconColor: const Color(0xFFF59E0B),
                          iconBgColor: const Color(0xFFFFFBEB),
                          title: "Help Center",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => const InfoDialog(
                                    title: "Help Center",
                                    content:
                                        "Manage your wholesale ledger with ease. Tap a retailer to see full history or add a new transaction. Use the reports tab for monthly summaries.",
                                  ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.description_outlined,
                          iconColor: const Color(0xFF64748B),
                          iconBgColor: const Color(0xFFF1F5F9),
                          title: "Terms of Use",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => const InfoDialog(
                                    title: "Terms of Use",
                                    content:
                                        "By using BakiLedger, you agree to maintain the confidentiality of your account. Records are managed locally for your convenience.",
                                  ),
                            );
                          },
                        ),
                        Divider(height: 1, color: const Color(0xFFF1F5F9)),
                        _buildPreferenceItem(
                          icon: Icons.info_outline_rounded,
                          iconColor: const Color(0xFF64748B),
                          iconBgColor: const Color(0xFFF1F5F9),
                          title: "About BakiLedger",
                          subtitle: "v1.0.4 Professional",
                          trailing: Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 16.sp,
                            color: const Color(0xFFCBD5E1),
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder:
                                  (context) => const InfoDialog(
                                    title: "About BakiLedger",
                                    content:
                                        "BakiLedger Professional Edition v1.0.4. Empowering Bangladeshi wholesalers through smart digital accounting solutions.",
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
                        color: Colors.black.withOpacity(0.05),
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
                        "Sign Out Account",
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
                        "Factory Reset (Delete All)",
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
