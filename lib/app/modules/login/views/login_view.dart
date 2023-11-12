import '../../../core/theme/sizes.dart';
import '../../../core/theme/text.dart';

import '../../../core/theme/colors.dart';
import '../../../global_widget/button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:svg_flutter/svg_flutter.dart';

import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Login Admin',
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: Get.width * 0.1),
          child: SizedBox(
            height: Get.height * 0.8,
            child: Column(
              children: [
                SvgPicture.asset(
                  'assets/icons/login.svg',
                  height: Get.height * 0.4,
                  fit: BoxFit.fitHeight,
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextField(
                        autocorrect: false,
                        controller: controller.emailController,
                        keyboardType: TextInputType.text,
                        style: AppTextStyles.textStyleW500S14,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: AppTextStyles.textStyleW500S14,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                      const SizedBox(height: AppSizes.dimen16),
                      Obx(
                        () => TextField(
                          autocorrect: false,
                          controller: controller.passwordController,
                          keyboardType: TextInputType.text,
                          style: AppTextStyles.textStyleW500S14,
                          obscureText: controller.isHidden.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: AppTextStyles.textStyleW500S14,
                            suffixIcon: IconButton(
                              iconSize: AppSizes.dimen24,
                              onPressed: () {
                                controller.isHidden.toggle();
                              },
                              icon: Icon(
                                controller.isHidden.isTrue ? Icons.remove_red_eye : Icons.remove_red_eye_outlined,
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.dimen32,
                      ),
                      LargeButton(
                        backgroundColor: AppColors.primary,
                        isLoading: controller.isLoading,
                        onPressed: () {
                          controller.login();
                        },
                        textButton: 'Login',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
