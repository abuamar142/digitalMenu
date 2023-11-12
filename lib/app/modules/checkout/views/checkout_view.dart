import 'package:digital_menu/app/data/model/transaction.dart';
import 'package:digital_menu/app/routes/app_pages.dart';

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
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('CheckoutView'),
        centerTitle: true,
      ),
      body: controller.sales.isNotEmpty
          ? Column(
              children: [
                SizedBox(
                  height: Get.height - AppBar().preferredSize.height * 2 - 50,
                  child: Obx(
                    () => ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: controller.sales.length,
                      itemBuilder: (context, index) {
                        Sale sale = controller.sales[index];

                        return InkWell(
                          onTap: () {
                            Get.dialog(
                              SingleChildScrollView(
                                child: SizedBox(
                                  height: Get.height,
                                  child: Dialog(
                                    child: DialogCard(
                                      sale: sale,
                                    ),
                                  ),
                                ),
                              ),
                            );
                          },
                          child: Card(
                            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                            elevation: 5,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
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
                                                  child: sale.image.isNotEmpty
                                                      ? Image.network(
                                                          sale.image,
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
                                                            sale.name,
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
                                                                sale.totalItem.toString(),
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
                                                        sale.spicy.value == false ? '' : 'Spicy',
                                                        style: const TextStyle(
                                                          fontSize: 12,
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Text(
                                                            'Rp.${formattedNumber(sale.price.toInt())}',
                                                            style: const TextStyle(
                                                              fontSize: 12,
                                                            ),
                                                          ),
                                                          SizedBox(
                                                            width: constraints.maxWidth * 0.15,
                                                            child: Center(
                                                              child: IconButton(
                                                                onPressed: () {
                                                                  controller.sales.remove(sale);
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
                                            visible: sale.note.isEmpty ? false : true,
                                            child: Column(
                                              children: [
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Note : ${sale.note}',
                                                  maxLines: 2,
                                                  style: const TextStyle(
                                                    fontSize: 14,
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
                Container(
                  margin: const EdgeInsets.only(bottom: 16, right: 16, left: 16),
                  padding: const EdgeInsets.only(left: 16),
                  height: AppBar().preferredSize.height,
                  width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.primary), color: AppColors.white),
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
                          Container(
                            height: double.infinity,
                            width: 100,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(8),
                                bottomRight: Radius.circular(8),
                              ),
                            ),
                            child: TextButton(
                              onPressed: () {
                                if (controller.sales.isNotEmpty) {
                                  Get.toNamed(Routes.RESULT, arguments: controller.sales[0]);
                                } else {
                                  Get.toNamed(Routes.RESULT);
                                }
                              },
                              child: Text(
                                'Checkout',
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
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
    );
  }
}

class DialogCard extends StatelessWidget {
  const DialogCard({
    super.key,
    required this.sale,
  });

  final Sale sale;

  @override
  Widget build(BuildContext context) {
    RxBool spicy = sale.spicy;
    TextEditingController note = TextEditingController();

    RxInt totalItem = sale.totalItem;

    note.text = sale.note.toString();

    RxBool isLoading = false.obs;
    RxBool addNote = sale.note.isNotEmpty.obs;

    print(sale.id);

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
                              child: sale.image.isNotEmpty
                                  ? Image.network(
                                      sale.image,
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
                                  sale.name,
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
                                      'Rp.${formattedNumber(sale.price.toInt())}',
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
                                  if (totalItem > 1) {
                                    totalItem--;
                                  }
                                },
                                iconData: Icons.remove_outlined,
                              ),
                              SizedBox(
                                width: 32,
                                child: Obx(
                                  () => Text(
                                    totalItem.toString(),
                                    style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              SmallButton(
                                onTap: () {
                                  totalItem++;
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
