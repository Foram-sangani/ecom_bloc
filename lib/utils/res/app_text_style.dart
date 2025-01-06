import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextStyle {
  AppTextStyle._();

  static TextStyle textFieldStyle(BuildContext context) => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w500, color: AppColors.midnightGreen);

  static TextStyle textFieldHintStyle(BuildContext context) => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400, color: const Color(0xFF667085));

  static TextStyle appButtonStyle(BuildContext context) => TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600);

  static TextStyle? titleStyle(BuildContext context, {Color? color}) => Theme.of(context).textTheme.headlineMedium?.copyWith(
        fontSize: 24.0.sp,
        fontWeight: FontWeight.w600,
        color: color ?? AppColors.midnightGreen,
      );

  static TextStyle? subtitleStyle(BuildContext context, {FontWeight? fontWeight, double? fontSize, Color? color}) => Theme.of(context).textTheme.bodyLarge?.copyWith(
        fontSize: fontSize ?? 14.sp,
        fontWeight: fontWeight ?? FontWeight.w400,
        color: color ?? Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(.55),
      );
  // style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: 16.sp, fontWeight: FontWeight.w500),
}
