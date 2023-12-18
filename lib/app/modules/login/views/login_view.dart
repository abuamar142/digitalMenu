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
      body: Padding(
        padding: AppSizes.marginAppHaveAppBar,
        child: LayoutBuilder(builder: (context, constraints) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                height: constraints.maxHeight * 0.4,
                child: SvgPicture.asset(
                  'assets/icons/login.svg',
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: constraints.maxHeight * 0.6,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: AppSizes.heightTextField,
                      child: TextField(
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
                    ),
                    const SizedBox(height: AppSizes.dimen16),
                    SizedBox(
                      height: AppSizes.heightTextField,
                      child: Obx(
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
                    ),
                    const SizedBox(height: AppSizes.dimen32),
                    LargeButton(
                      backgroundColor: AppColors.primary,
                      isLoading: controller.isLoading,
                      onPressed: () {
                        controller.login();
                      },
                      textButton: 'Login',
                    ),
                    const SizedBox(height: AppSizes.dimen64)
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
