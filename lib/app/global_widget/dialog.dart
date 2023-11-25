import '../core/utils/functions/number_formatter.dart';
import '../core/values/strings.dart';
import '../data/model/product.dart';
import 'button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogCard2 extends StatelessWidget {
  const DialogCard2({
    super.key,
    required this.product,
  });

  final Product product;

  @override
  Widget build(BuildContext context) {
    RxBool spicy = false.obs;
    RxInt amount = 1.obs;
    TextEditingController note = TextEditingController();

    RxBool isLoading = false.obs;
    RxBool addNote = false.obs;

    // UserProductController controller = Get.find<UserProductController>();

    return Card(
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
                            child: product.id.toString().isNotEmpty
                                ? Image.asset(
                                    product.id.toString(),
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
                                product.name.toString(),
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
                                    'Rp.${formattedNumber(product.price.toInt())}',
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
                        try {
                          // controller.selectedMenu.add(
                          //   SelectedProduct.fromProduct(
                          //     menuItem,
                          //     amount.toInt(),
                          //     menuItem.price * amount.toInt(),
                          //     spicy.value,
                          //     note.text,
                          //   ),
                          // );
                          Get.back();
                        } catch (e) {
                          Get.snackbar(AppStrings.success, e.toString());
                        }
                      },
                      child: Obx(
                        () => isLoading.isFalse
                            ? const Text(
                                'Add to Cart',
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
    );
  }
}
