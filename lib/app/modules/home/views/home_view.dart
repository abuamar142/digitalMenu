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
        padding: AppSizes.marginApp,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.4,
                child: SvgPicture.asset(
                  'assets/icons/home.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.6,
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
                            fixedSize: MaterialStatePropertyAll(AppSizes.buttonSize),
                            shape: MaterialStateProperty.all(
                              RoundedRectangleBorder(
                                borderRadius: AppSizes.allRadius8,
                              ),
                            ),
                          ),
                          onPressed: () {
                            Get.toNamed(Routes.PRODUCT_USER);
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
                            style: ButtonStyle(fixedSize: MaterialStatePropertyAll(AppSizes.buttonSize)),
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
          );
        }),
      ),
    );
  }
}
