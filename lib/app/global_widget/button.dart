import '../core/theme/sizes.dart';
import '../core/theme/text.dart';

import '../core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SmallButton extends StatelessWidget {
  const SmallButton({
    super.key,
    this.onTap,
    this.iconData,
  });

  final Function()? onTap;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Ink(
        decoration: BoxDecoration(
          color: Colors.blue,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(4),
        child: Icon(
          iconData,
          color: AppColors.white,
        ),
      ),
    );
  }
}

class LargeButton extends StatelessWidget {
  const LargeButton({
    super.key,
    this.backgroundColor,
    required this.isLoading,
    required this.onPressed,
    required this.textButton,
  });

  final Color? backgroundColor;
  final RxBool isLoading;
  final VoidCallback onPressed;
  final String textButton;

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => ElevatedButton(
        style: ElevatedButton.styleFrom(
          fixedSize: Size(Get.width, 48),
          backgroundColor: isLoading.isFalse ? backgroundColor ?? AppColors.primary : AppColors.red,
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        onPressed: onPressed,
        child: isLoading.value
            ? const FittedBox(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSizes.dimen16),
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 4,
                  ),
                ),
              )
            : Text(
                textButton,
                style: AppTextStyles.textStyleW700S14.copyWith(color: AppColors.white),
              ),
      ),
    );
  }
}

class Dropdown extends StatelessWidget {
  const Dropdown({
    super.key,
    required this.listItems,
    required this.selectedValue,
  });

  final List<String> listItems;
  final RxString selectedValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(border: Border.all(width: 1, color: AppColors.grey), borderRadius: BorderRadius.circular(AppSizes.radius8)),
      child: Obx(
        () => DropdownButton<String>(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.dimen12),
          iconSize: AppSizes.dimen24,
          isExpanded: true,
          itemHeight: AppSizes.dimen48,
          underline: Container(),
          value: selectedValue.value,
          items: listItems
              .map(
                (item) => DropdownMenuItem(
                  value: item,
                  child: Text(
                    item,
                    style: AppTextStyles.textStyleW500S14,
                  ),
                ),
              )
              .toList(),
          onChanged: (item) => selectedValue.value = item!,
          borderRadius: BorderRadius.circular(AppSizes.radius8),
          style: AppTextStyles.textStyleW500S14,
        ),
      ),
    );
  }
}
