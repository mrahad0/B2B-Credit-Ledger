import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../util/app_colors.dart';
import '../../util/style.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    this.color,
    this.textStyle,
    this.radius,
    this.margin = EdgeInsets.zero,
    required this.onTap,
    required this.text,
    this.loading = false,
    this.width,
    this.height,
    this.icon,
    this.iconColor,
    this.iconSize,
  });
  final Function() onTap;
  final String text;
  final bool loading;
  final double? height;
  final double? width;
  final Color? color;
  final double? radius;
  final EdgeInsetsGeometry margin;
  final TextStyle? textStyle;
  final IconData? icon;
  final Color? iconColor;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: margin,
      child: ElevatedButton(
        onPressed: loading ? () {} : onTap,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius ?? 24.r),
          ),
          backgroundColor: color ?? AppColors.primaryColor,
          minimumSize: Size(width ?? Get.width, height ?? 53.h),
        ),
        child: loading
            ? SizedBox(
                height: 20.h,
                width: 20.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style:
                        textStyle ??
                        AppStyles.h1(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                  ),
                  if (icon != null) ...[
                    SizedBox(width: 8.w),
                    Icon(
                      icon,
                      color: iconColor ?? Colors.white,
                      size: iconSize ?? 18.w,
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
