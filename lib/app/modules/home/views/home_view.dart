import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:universal_platform/universal_platform.dart';

import '../../../core/theme/colors.dart';
import '../../../core/theme/text.dart';

import '../../../core/values/strings.dart';
import '../../../routes/app_pages.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1, vertical: Get.height * 0.05),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              height: Get.height * 0.4,
              child: SvgPicture.asset(
                'assets/icons/home.svg',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(
              height: Get.height * 0.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Welcome to Ours Cafe',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleW700S22,
                      ),
                      const SizedBox(height: 24),
                      Text(
                        AppStrings.cafeName,
                        textAlign: TextAlign.center,
                        style: AppTextStyles.textStyleW700S16,
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      // Select menu button
                      ElevatedButton(
                        style: ButtonStyle(
                          fixedSize: MaterialStatePropertyAll(Size(Get.width, AppSizes.dimen48)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(AppSizes.radius8),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.toNamed(Routes.CAFE_MENU);
                        },
                        child: Text(
                          'Select Menu',
                          style: AppTextStyles.textStyleW700S14.copyWith(color: AppColors.white),
                        ),
                      ),
                      const SizedBox(height: AppSizes.dimen16),
                      // Login admin button
                      Visibility(
                        visible: UniversalPlatform.isAndroid,
                        child: TextButton(
                          onPressed: () {
                            Get.toNamed(Routes.LOGIN);
                          },
                          child: Text(
                            'Login Admin',
                            style: AppTextStyles.textStyleW700S14,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
