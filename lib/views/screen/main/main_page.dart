import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_extension/controller/main_page_controller.dart';
import 'package:flutter_extension/views/screen/home/home_screen.dart';
import 'package:flutter_extension/views/screen/retailers/retailers_screen.dart';
import 'package:flutter_extension/views/screen/account/account_screen.dart';
import 'package:flutter_extension/util/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final MainPageController controller = Get.put(MainPageController());

  final List<Widget> _screens = [
    const HomeScreen(),
    const RetailersScreen(),
    const AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => _screens[controller.selectedIndex.value]),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(blurRadius: 20, color: Colors.black.withOpacity(.1)),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
            child: Obx(
              () => GNav(
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.white,
                iconSize: 28,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                duration: const Duration(milliseconds: 400),
                tabBackgroundColor: AppColors.primaryColor,
                color: Colors.grey,
                tabs: [
                  GButton(
                    icon: Icons.grid_view_rounded,
                    leading: SvgPicture.asset(
                      "assets/images/Dashboard.svg",
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 0
                            ? Colors.white
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                    ),
                    text: 'Home',
                  ),
                  GButton(
                    icon: Icons.group_outlined,
                    leading: SvgPicture.asset(
                      "assets/images/Users.svg",
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 1
                            ? Colors.white
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                    ),
                    text: 'Retailers',
                  ),
                  GButton(
                    icon: Icons.settings_outlined,
                    leading: SvgPicture.asset(
                      "assets/images/Settings.svg",
                      colorFilter: ColorFilter.mode(
                        controller.selectedIndex.value == 2
                            ? Colors.white
                            : Colors.grey,
                        BlendMode.srcIn,
                      ),
                      height: 24,
                      width: 24,
                    ),
                    text: 'Account',
                  ),
                ],
                selectedIndex: controller.selectedIndex.value,
                onTabChange: (index) {
                  controller.changeIndex(index);
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
