import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter_extension/controller/localization_controller.dart';
import 'package:flutter_extension/util/app_constants.dart';

class LanguageDialog extends StatelessWidget {
  const LanguageDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      backgroundColor: Colors.white,
      insetPadding: EdgeInsets.all(20.w),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              'language'.tr,
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF0F172A),
              ),
            ),
          ),
          GetBuilder<LocalizationController>(
            builder: (localizationController) {
              return ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.symmetric(horizontal: 10.w),
                itemCount: localizationController.languages.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      localizationController.setLanguage(Locale(
                        AppConstants.languages[index].languageCode,
                        AppConstants.languages[index].countryCode,
                      ));
                      localizationController.setSelectIndex(index);
                      Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        vertical: 12.h,
                        horizontal: 16.w,
                      ),
                      margin: EdgeInsets.only(bottom: 10.h),
                      decoration: BoxDecoration(
                        color: localizationController.selectedIndex == index
                            ? const Color(0xFFF1F5F9)
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(10.r),
                        border: Border.all(
                          color: localizationController.selectedIndex == index
                              ? const Color(0xFF2563EB)
                              : const Color(0xFFE2E8F0),
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              localizationController.languages[index].languageName,
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF0F172A),
                              ),
                            ),
                          ),
                          if (localizationController.selectedIndex == index)
                            Icon(
                              Icons.check_circle_rounded,
                              color: const Color(0xFF2563EB),
                              size: 20.sp,
                            ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
          SizedBox(height: 20.h),
        ],
      ),
    );
  }
}
