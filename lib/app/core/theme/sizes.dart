import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppSizes {
  AppSizes._();

  static const dimen4 = 4.0;
  static const dimen8 = 8.0;
  static const dimen12 = 12.0;
  static const dimen16 = 16.0;
  static const dimen24 = 24.0;
  static const dimen32 = 32.0;
  static const dimen48 = 48.0;
  static const dimen56 = 56.0;
  static const dimen64 = 64.0;
  static const dimen72 = 72.0;
  static const dimen80 = 80.0;
  static const dimen88 = 88.0;
  static const dimen100 = 100.0;
  static const dimen120 = 120.0;
  static const dimen160 = 160.0;
  static const dimen200 = 200.0;
  static const dimen240 = 240.0;
  static const dimen280 = 280.0;
  static const dimen360 = 360.0;
  static const dimen400 = 400.0;
  static const dimen600 = 600.0;
  static const dimen800 = 800.0;
  static const dimen1320 = 1320.0;

  static const text13 = 13.0;
  static const text14 = 14.0;
  static const text16 = 16.0;
  static const text22 = 22.0;

  static const radius4 = 4.0;

  static BorderRadius allRadius8 = BorderRadius.circular(8);

  static Radius radius8 = const Radius.circular(8);

  static const heightTextField = 48.0;

  static EdgeInsets marginApp = EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: (Get.height * 0.025) + AppBar().preferredSize.height, bottom: Get.height * 0.025);
  static EdgeInsets marginAppHaveAppBar = EdgeInsets.only(left: Get.width * 0.05, right: Get.width * 0.05, top: Get.height * 0.025, bottom: Get.height * 0.025);

  static Size buttonSize = Size(Get.width, AppSizes.dimen48);
}
