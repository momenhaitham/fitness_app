import 'package:fitness_app/core/resources/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../app_locale/app_locale.dart';

class UIUtils {
  static void showEasyLoading({String? status}) {
    EasyLoading.instance.indicatorType = EasyLoadingIndicatorType.ripple;
    EasyLoading.instance.indicatorSize = 45.0;
    EasyLoading.instance.loadingStyle = EasyLoadingStyle.custom;
    EasyLoading.instance.radius = 10.0;
    EasyLoading.instance.backgroundColor = AppColors.primaryColor;
    EasyLoading.instance.indicatorColor = AppColors.baseWhiteColor;
    EasyLoading.instance.textColor = AppColors.baseWhiteColor;
    EasyLoading.instance.maskType = EasyLoadingMaskType.black;
    EasyLoading.show(status: status ?? AppLocale.loading);
  }

  static void hideLoading(BuildContext context) => EasyLoading.dismiss();

  static void showMessage(
    String message, {
    required Color backGroundColor,
    required Color textColor,
  }) => Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_LONG,
    backgroundColor: backGroundColor,
    textColor: textColor,
  );
}
