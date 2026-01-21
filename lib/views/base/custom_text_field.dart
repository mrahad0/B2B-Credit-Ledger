import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../util/app_colors.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final bool? isObscureText;
  final String? obscure;
  final Color? filColor;
  final Widget? prefixIcon;
  final String? labelText;
  final String? hintText;
  final double? contentPaddingHorizontal;
  final double? contentPaddingVertical;
  final Widget? suffixIcon;
  final FormFieldValidator? validator;
  final bool isPassword;
  final bool? isEmail;
  final Color? textColor;
  final Color? hintColor;
  final String? prefixText;
  final TextStyle? prefixStyle;
  final FocusNode? focusNode;

  const CustomTextField({
    super.key,
    this.contentPaddingHorizontal,
    this.contentPaddingVertical,
    this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    this.isEmail,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.isObscureText = false,
    this.obscure = '*',
    this.filColor,
    this.labelText,
    this.isPassword = false,
    this.textColor,
    this.hintColor,
    this.prefixText,
    this.prefixStyle,
    this.focusNode,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool obscureText = true;
  late FocusNode _focusNode;
  bool _isFocused = false;

  void toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscuringCharacter: widget.obscure!,
      validator: widget.validator,
      focusNode: _focusNode,
      cursorColor: AppColors.primaryColor,
      obscureText: widget.isPassword ? obscureText : false,
      style: TextStyle(
          color: widget.textColor ?? const Color(0xFF1E293B),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(
            horizontal: widget.contentPaddingHorizontal ?? 16.w,
            vertical: widget.contentPaddingVertical ?? 18.h),
        fillColor: widget.filColor ?? const Color(0xFFF8FAFC),
        filled: true,
        prefixIcon: widget.prefixIcon != null
            ? ColorFiltered(
                colorFilter: ColorFilter.mode(
                  _isFocused ? AppColors.primaryColor : const Color(0xFF94A3B8),
                  BlendMode.srcIn,
                ),
                child: widget.prefixIcon,
              )
            : null,
        prefixText: widget.prefixText,
        prefixStyle: widget.prefixStyle ??
            TextStyle(
                color: const Color(0xFF94A3B8),
                fontSize: 16.sp,
                fontWeight: FontWeight.w600),
        suffixIcon: widget.isPassword
            ? GestureDetector(
                onTap: toggle,
                child: _suffixIcon(
                    obscureText ? Icons.visibility_off : Icons.visibility),
              )
            : widget.suffixIcon,
        prefixIconConstraints: BoxConstraints(minHeight: 24.w, minWidth: 48.w),
        labelText: widget.labelText,
        labelStyle: TextStyle(color: Colors.grey[600], fontSize: 14.sp),
        hintText: widget.hintText,
        hintStyle: TextStyle(
            color: widget.hintColor ?? const Color(0xFFCBD5E1),
            fontSize: 16.sp,
            fontWeight: FontWeight.w600),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Color(0xFFE2E8F0), width: 1.5),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: BorderSide(color: AppColors.primaryColor, width: 1.5),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.r),
          borderSide: const BorderSide(color: Colors.red, width: 1.5),
        ),
      ),
    );
  }

  _suffixIcon(IconData icon) {
    return Padding(
        padding: const EdgeInsets.all(12.0),
        child: Icon(icon, color: const Color(0xFF94A3B8)));
  }
}
