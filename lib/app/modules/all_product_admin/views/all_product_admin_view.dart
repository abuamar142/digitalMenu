import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:digital_menu/app/routes/app_pages.dart';
import '../../../core/theme/sizes.dart';
import '../../../core/theme/text.dart';
import '../../../views/views/loading_screen_view.dart';
import '../../../controllers/product_controller.dart';
import '../../../core/utils/functions/number_formatter.dart';
import '../../../data/model/product.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/all_product_admin_controller.dart';

class AllProductAdminView extends GetView<AllProductAdminController> {
  const AllProductAdminView({super.key});

  @override
  Widget build(BuildContext context) {
    ProductController productController = Get.find<ProductController>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Product Added'),
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: productController.streamProducts(),
        builder: (context, snapProduct) {
          if (snapProduct.connectionState == ConnectionState.waiting) {
            return const LoadingScreenView();
          }

          if (snapProduct.data!.docs.isEmpty) {
            return const Center(
              child: Text(
                'Products empty',
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          if (snapProduct.hasData && snapProduct.data!.docs.isNotEmpty) {
            List<Product> allProducts = [];

            for (var element in snapProduct.data!.docs) {
              allProducts.add(Product.fromJson(element.data()));
            }

            return ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: AppSizes.dimen8),
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                Product product = allProducts[index];

                print(product.imageUrl);

                return InkWell(
                  onTap: () {
                    Get.toNamed(Routes.DETAIL_MENU_ADMIN, arguments: product);
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(vertical: AppSizes.dimen8, horizontal: AppSizes.dimen16),
                    elevation: 5,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: AppSizes.dimen16, horizontal: AppSizes.dimen8),
                      child: Row(
                        children: [
                          SizedBox(
                            height: 100,
                            width: 100,
                            child: product.imageUrl.isNotEmpty
                                ? Image.network(product.imageUrl.toString())
                                : const Center(
                                    child: Text(
                                      'None',
                                    ),
                                  ),
                          ),
                          const SizedBox(width: AppSizes.dimen16),
                          Expanded(
                            child: SizedBox(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyles.textStyleW700S16,
                                  ),
                                  FittedBox(
                                    child: Text(
                                      product.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyles.textStyleW500S13,
                                    ),
                                  ),
                                  Text(
                                    'Rp.${formattedNumber(product.price.toInt())}',
                                    style: AppTextStyles.textStyleW500S13,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: Text(
                'Products empty',
                style: TextStyle(fontSize: 16),
              ),
            );
          }
        },
      ),
    );
  }
}
