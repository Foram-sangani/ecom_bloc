import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'color_print.dart';

class UiUtils {
  static double appButtonHight = 48.w;
  static double bottomBarHight = 85;
  static DateTime calenderFirstDate = DateTime(2000);
  static DateTime calenderLastDate = DateTime(3000);

  static bool _isShowingToast = false;

  static Future toast(message) async {
    Future showToast() {
      printOkStatus("Show toast");
      FToast fToast = FToast();
      fToast.removeQueuedCustomToasts();
      fToast.removeCustomToast();
      return Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        fontSize: 16.0,
      );
    }

    if (!_isShowingToast) {
      _isShowingToast = true;
      showToast().then((_) async {
        await Future.delayed(const Duration(seconds: 1));
        _isShowingToast = false;
      });
    }
  }

  static bool isSameDate({required String dateTimeOne, required String dateTimeTwo}) {
    DateTime dateTime1 = DateTime.parse(dateTimeOne).toLocal();
    DateTime dateTime2 = DateTime.parse(dateTimeTwo).toLocal();
    return dateTime1.year == dateTime2.year && dateTime1.month == dateTime2.month && dateTime1.day == dateTime2.day;
  }

  static SystemUiOverlayStyle systemUiOverlayStyle({
    bool? isReverse,
    Color? statusBarColor,
    Brightness? statusBarIconBrightness,
    Brightness? statusBarBrightness,
    Color? systemNavigationBarColor,
  }) {
    // isReverse = (isReverse ?? Get.isDarkMode);
    return SystemUiOverlayStyle(
      statusBarColor: statusBarColor ?? Colors.transparent, // <-- SEE HERE
      statusBarIconBrightness: statusBarIconBrightness ?? (isReverse == true ? Brightness.light : Brightness.dark), //<-- For Android SEE HERE (dark icons)
      statusBarBrightness: statusBarBrightness ?? (isReverse == true ? Brightness.dark : Brightness.light), //<-- For iOS SEE HERE (dark icons)
      systemNavigationBarColor: systemNavigationBarColor ?? Colors.transparent,
    );
  }
}

/// ------ To Check Internet Ability -------------------->>>
ConnectivityResult? connectivityResult;
final Connectivity connectivity = Connectivity();

Future<bool> getConnectivityResult({
  bool showToast = true,
  /*RxBool? isLoader*/
}) async {
  try {
    connectivityResult = (await connectivity.checkConnectivity()) as ConnectivityResult?;
    if (connectivityResult == ConnectivityResult.wifi || connectivityResult == ConnectivityResult.mobile) {
      return true;
    } else {
      if (showToast == true) {
        UiUtils.toast('AppStrings.noInternetAvailable');
        // isLoader?.value = false;
      }
      return false;
    }
  } on PlatformException catch (e) {
    printErrors(type: "getConnectivityResult Function", errText: e);
    UiUtils.toast('AppStrings.noInternetAvailable');
    // isLoader?.value = false;
    return false;
  }
}
