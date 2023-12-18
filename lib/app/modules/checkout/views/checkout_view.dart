import 'package:digital_menu/app/core/theme/sizes.dart';
import 'package:digital_menu/app/core/theme/text.dart';
import 'package:digital_menu/app/data/model/selected_product.dart';

import '../../../core/utils/functions/number_formatter.dart';
import '../../../core/theme/colors.dart';
import '../../../global_widget/button.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/checkout_controller.dart';

class CheckoutView extends GetView<CheckoutController> {
  const CheckoutView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.nameOrder.text = 'Budi';
    controller.noTable.text = '3';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CheckoutView'),
        centerTitle: true,
      ),
      body: Padding(
        padding: AppSizes.marginAppHaveAppBar,
        child: controller.selectedProducts.isNotEmpty
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Detail', style: AppTextStyles.textStyleW700S16),
                  const SizedBox(height: AppSizes.dimen16),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: AppSizes.dimen8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        SizedBox(
                          height: AppSizes.heightTextField,
                          child: TextField(
                            autocorrect: false,
                            controller: controller.nameOrder,
                            keyboardType: TextInputType.text,
                            style: AppTextStyles.textStyleW500S14,
                            decoration: InputDecoration(
                              labelText: 'Name',
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
                          child: TextField(
                            autocorrect: false,
                            controller: controller.noTable,
                            keyboardType: TextInputType.text,
                            style: AppTextStyles.textStyleW500S14,
                            decoration: InputDecoration(
                              labelText: 'No Table',
                              labelStyle: AppTextStyles.textStyleW500S14,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSizes.dimen16),
                  Text('Pesanan', style: AppTextStyles.textStyleW700S16),
                  const SizedBox(height: AppSizes.dimen16),
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return Column(
                          children: [
                            SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: constraints.maxHeight,
                                    child: Obx(
                                      () => ListView.builder(
                                        itemCount: controller.selectedProducts.length,
                                        itemBuilder: (context, index) {
                                          SelectedProduct selectedProduct = controller.selectedProducts[index];

                                          return InkWell(
                                            onTap: () {
                                              Get.dialog(
                                                SingleChildScrollView(
                                                  child: SizedBox(
                                                    height: Get.height,
                                                    child: Dialog(
                                                      child: DialogCard(
                                                        selectedProduct: selectedProduct,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              );
                                            },
                                            child: Card(
                                              elevation: 5,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(vertical: AppSizes.dimen16, horizontal: AppSizes.dimen16),
                                                child: LayoutBuilder(
                                                  builder: (context, constraints) {
                                                    return Row(
                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                      children: [
                                                        Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            SizedBox(
                                                              width: constraints.maxWidth,
                                                              child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  SizedBox(
                                                                    height: 100,
                                                                    width: 100,
                                                                    child: selectedProduct.imageUrl.isNotEmpty
                                                                        ? Image.network(
                                                                            selectedProduct.imageUrl,
                                                                            fit: BoxFit.contain,
                                                                          )
                                                                        : const Center(
                                                                            child: Text(
                                                                              'None',
                                                                            ),
                                                                          ),
                                                                  ),
                                                                  const SizedBox(width: 16),
                                                                  Expanded(
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              selectedProduct.name,
                                                                              maxLines: 2,
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(
                                                                                fontSize: 16,
                                                                                fontWeight: FontWeight.bold,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: constraints.maxWidth * 0.15,
                                                                              child: Obx(
                                                                                () => Text(
                                                                                  selectedProduct.amount.toString(),
                                                                                  textAlign: TextAlign.center,
                                                                                  style: const TextStyle(
                                                                                    fontWeight: FontWeight.bold,
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                        const SizedBox(height: 4),
                                                                        Text(
                                                                          selectedProduct.spicy.value == false ? '' : 'Spicy',
                                                                          style: const TextStyle(
                                                                            fontSize: 12,
                                                                          ),
                                                                        ),
                                                                        Row(
                                                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                          children: [
                                                                            Text(
                                                                              'Rp.${formattedNumber(selectedProduct.price.toInt())}',
                                                                              style: const TextStyle(
                                                                                fontSize: 12,
                                                                              ),
                                                                            ),
                                                                            SizedBox(
                                                                              width: constraints.maxWidth * 0.15,
                                                                              child: Center(
                                                                                child: IconButton(
                                                                                  onPressed: () {
                                                                                    controller.selectedProducts.remove(selectedProduct);
                                                                                  },
                                                                                  icon: const Align(
                                                                                    child: Icon(Icons.delete),
                                                                                  ),
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
                                                            Visibility(
                                                              visible: selectedProduct.note.isEmpty ? false : true,
                                                              child: Column(
                                                                children: [
                                                                  const SizedBox(height: 8),
                                                                  Obx(
                                                                    () => Text(
                                                                      'Note : ${selectedProduct.note}',
                                                                      maxLines: 2,
                                                                      style: const TextStyle(
                                                                        fontSize: 14,
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => Container(
                      margin: const EdgeInsets.symmetric(vertical: AppSizes.dimen16),
                      padding: const EdgeInsets.only(left: AppSizes.dimen16),
                      height: AppBar().preferredSize.height,
                      width: double.infinity,
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: controller.isLoadingCheckout.isFalse ? AppColors.primary : AppColors.yellow), color: AppColors.white),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total',
                            style: TextStyle(color: AppColors.black, fontWeight: FontWeight.bold),
                          ),
                          Row(
                            children: [
                              Obx(
                                () => Text(
                                  'Rp.${formattedNumber(controller.total.toInt())}',
                                  style: TextStyle(
                                    color: AppColors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  controller.addOrder();
                                },
                                child: Obx(
                                  () => Container(
                                    height: double.infinity,
                                    width: 100,
                                    decoration: BoxDecoration(
                                      color: controller.isLoadingCheckout.isFalse ? AppColors.primary : AppColors.yellow,
                                      borderRadius: const BorderRadius.only(
                                        topRight: Radius.circular(8),
                                        bottomRight: Radius.circular(8),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        controller.isLoadingCheckout.isFalse ? 'Checkout' : 'Loading',
                                        style: AppTextStyles.textStyleW700S14.copyWith(color: AppColors.white),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            : const Center(
                child: Text(
                  'Empty',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
      ),
    );
  }
}

class DialogCard extends GetView<CheckoutController> {
  const DialogCard({
    super.key,
    required this.selectedProduct,
  });

  final SelectedProduct selectedProduct;

  @override
  Widget build(BuildContext context) {
    RxBool spicy = selectedProduct.spicy;
    TextEditingController note = TextEditingController();

    RxInt amount = selectedProduct.amount;

    note.text = selectedProduct.note.toString();

    RxBool isLoading = false.obs;
    RxBool addNote = selectedProduct.note.isNotEmpty.obs;

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: LayoutBuilder(
            builder: (context, constraints) {
              return FittedBox(
                child: SizedBox(
                  width: constraints.maxWidth,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Item image
                            SizedBox(
                              height: 200,
                              width: double.infinity,
                              child: selectedProduct.imageUrl.isNotEmpty
                                  ? Image.network(
                                      selectedProduct.imageUrl,
                                      fit: BoxFit.cover,
                                    )
                                  : const Center(
                                      child: Text(
                                        'None',
                                      ),
                                    ),
                            ),
                            const SizedBox(height: 16),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  selectedProduct.name,
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 16),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Rp.${formattedNumber(selectedProduct.price.toInt())}',
                                      style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Obx(
                            () => CheckboxMenuButton(
                              value: spicy.value,
                              onChanged: (value) {
                                spicy.toggle();
                              },
                              child: Text(
                                spicy.isFalse ? 'Not Spicy' : 'Spicy',
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ),
                          // Add button
                          Row(
                            children: [
                              SmallButton(
                                onTap: () {
                                  if (amount > 1) {
                                    amount--;
                                  }
                                },
                                iconData: Icons.remove_outlined,
                              ),
                              SizedBox(
                                width: 32,
                                child: Obx(
                                  () => Text(
                                    amount.toString(),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SmallButton(
                                onTap: () {
                                  amount++;
                                },
                                iconData: Icons.add_outlined,
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Obx(
                        () => CheckboxMenuButton(
                          value: addNote.value,
                          onChanged: (value) {
                            addNote.toggle();
                          },
                          child: const Text(
                            'Add Note',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                      ),
                      Obx(
                        () => Visibility(
                          visible: addNote.value,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              TextField(
                                autocorrect: false,
                                controller: note,
                                keyboardType: TextInputType.text,
                                maxLines: 2,
                                style: const TextStyle(fontSize: 14),
                                decoration: InputDecoration(
                                  labelText: 'Note',
                                  labelStyle: const TextStyle(fontSize: 14),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, 30),
                          backgroundColor: isLoading.isFalse ? Colors.blue : Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          elevation: 4,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              8,
                            ),
                          ),
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        child: Obx(
                          () => isLoading.isFalse
                              ? const Text(
                                  'Save',
                                )
                              : const SizedBox(
                                  width: 15,
                                  height: 15,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
