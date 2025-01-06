import 'package:ecommerce_app/utils/res/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  AppTheme._();

  static String fontFamilyInter = 'Inter';

  static ThemeData lightMode(BuildContext context, {required Color kPrimaryColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.light(useMaterial3: true);
    Color scaffoldBackgroundColor = const Color(0xFFFFFFFF);
    return base.copyWith(
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      shadowColor: const Color(0xFFdedcdc),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor.withOpacity(0.2),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFFFFFFFF),
      disabledColor: const Color(0xFFD3D9DD),
      textTheme: buildTextTheme(base: base.textTheme, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, myFontFamily: fontFamily),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.kPrimaryColor)),
      // Widgets Theme
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        color: Color(0xFFFFFFFF), // color: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
      ),
      popupMenuTheme: const PopupMenuThemeData(
        elevation: 0,
        color: Colors.white,
        surfaceTintColor: Colors.transparent,
      ),

      dividerTheme: const DividerThemeData(color: Color(0xFFE0E4E5)),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FCFF),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor, width: 0.4),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent, elevation: 0),
      iconTheme: const IconThemeData(color: Color(0xff2b2b2b)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: Colors.white,
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: kPrimaryColor,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        headerForegroundColor: Colors.white,
      ),
      timePickerTheme: TimePickerThemeData(
        dayPeriodColor: kPrimaryColor,
      ),
      colorScheme: ColorScheme.light(
        error: errorColor ?? Colors.red,
        primary: kPrimaryColor,
      ),
    );
  }

  static ThemeData darkMode(BuildContext context, {required Color kPrimaryColor, Color? errorColor, String? fontFamily}) {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: kPrimaryColor,
      visualDensity: VisualDensity.comfortable,
      scaffoldBackgroundColor: const Color(0xFF181818),
      shadowColor: const Color(0x8F000000),
      indicatorColor: kPrimaryColor,
      splashColor: kPrimaryColor.withOpacity(0.2),
      hoverColor: kPrimaryColor.withOpacity(0.1),
      splashFactory: InkRipple.splashFactory,
      canvasColor: const Color(0xFF1E1E1E),
      disabledColor: const Color(0xFFCCCCCC),
      textTheme: buildTextTheme(base: base.textTheme, myFontFamily: fontFamily),
      primaryTextTheme: buildTextTheme(base: base.primaryTextTheme, myFontFamily: fontFamily),
      radioTheme: RadioThemeData(fillColor: WidgetStateProperty.all(AppColors.kPrimaryColor)),

      // Widgets Theme
      appBarTheme: AppBarTheme(
        centerTitle: true,
        color: kPrimaryColor,
        surfaceTintColor: Colors.transparent,
      ),
      popupMenuTheme: const PopupMenuThemeData(
        color: Color(0xff222222),
        surfaceTintColor: Colors.transparent,
      ),
      tooltipTheme: TooltipThemeData(
        textStyle: TextStyle(color: const IconThemeData().color),
        decoration: BoxDecoration(
          color: const Color(0xFF181818),
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: kPrimaryColor, width: 0.4),
        ),
      ),
      bottomSheetTheme: const BottomSheetThemeData(backgroundColor: Colors.transparent),
      iconTheme: const IconThemeData(color: Color(0xFFFFFFFF)),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: kPrimaryColor,
        foregroundColor: base.iconTheme.color,
      ),
      datePickerTheme: DatePickerThemeData(
        headerBackgroundColor: kPrimaryColor,
        backgroundColor: const Color(0xff222222),
        surfaceTintColor: Colors.transparent,
        headerForegroundColor: const Color(0xff222222),
      ),
      colorScheme: ColorScheme.dark(
        error: errorColor ?? Colors.red,
        primary: kPrimaryColor,
      ),
    );
  }

/* ===================> Custom TextStyle <================== */
  static TextTheme buildTextTheme({required TextTheme base, String? myFontFamily}) =>
      //? If not using responsive font remove both ".sp - 2.5"
      base.copyWith(
        //* Display
        displayLarge: TextStyle(fontSize: (57.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: base.displayLarge!.color, fontFamily: myFontFamily),
        displayMedium: TextStyle(fontSize: (45.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w300, color: base.displayMedium!.color, fontFamily: myFontFamily),
        displaySmall: TextStyle(fontSize: (36.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.displaySmall!.color, fontFamily: myFontFamily),

        //* Headline
        headlineLarge: TextStyle(fontSize: (32.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineLarge!.color, fontFamily: myFontFamily),
        headlineMedium: TextStyle(fontSize: (28.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineMedium!.color, fontFamily: myFontFamily),
        headlineSmall: TextStyle(fontSize: (24.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w400, color: base.headlineSmall!.color, fontFamily: myFontFamily),

        //* Title
        titleLarge: TextStyle(fontSize: (22.0.sp - 2.5), letterSpacing: 0.0, fontWeight: FontWeight.w500, color: base.titleLarge!.color, fontFamily: myFontFamily),
        titleMedium: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.titleMedium!.color, fontFamily: myFontFamily),
        titleSmall: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w500, color: base.titleSmall!.color, fontFamily: myFontFamily),

        //* Label
        labelLarge: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.1, fontWeight: FontWeight.w400, color: base.labelLarge!.color, fontFamily: myFontFamily),
        labelMedium: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.labelMedium!.color, fontFamily: myFontFamily),
        labelSmall: TextStyle(fontSize: (11.0.sp - 2.5), letterSpacing: 0.5, fontWeight: FontWeight.w400, color: base.labelSmall!.color, fontFamily: myFontFamily),

        //* Body Text
        bodyLarge: TextStyle(fontSize: (16.0.sp - 2.5), letterSpacing: 0.15, fontWeight: FontWeight.w400, color: base.bodyLarge!.color, fontFamily: myFontFamily),
        // This style is flutter default body textStyle (without textStyle)
        bodyMedium: TextStyle(fontSize: (14.0.sp - 2.5), letterSpacing: 0.25, fontWeight: FontWeight.w400, color: base.bodyMedium!.color, fontFamily: myFontFamily),
        bodySmall: TextStyle(fontSize: (12.0.sp - 2.5), letterSpacing: 0.4, fontWeight: FontWeight.w400, color: base.bodySmall!.color, fontFamily: myFontFamily),
      );
}
